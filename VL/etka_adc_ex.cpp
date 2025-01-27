#include <stdio.h> 
#include <robotcontrol.h>
#include <csignal> 
#include <iostream> 
#include <vector> 
#include <cmath>

volatile bool keepRunning = true; // bb on

#define ADC_CH 0 // adc channel on bb is zero

// Signal handler to catch ctrl+c, shutting down the script
void signalHandler(int signum) {
    keepRunning = false;
}

// Performing linear interpolation
double linearInterp(double x, const double*  xp, const double* fp, int size) {
    if (x <= xp[0]) {
        return fp[0]; // If x is below the first value, return the first angle
    }
    if (x >= xp[size - 1]) {
        return fp[size - 1]; // If x is above the last value, return the last angle
    }
    
    // Find the interval [xp[i], xp[i+1]] that contains x
    for (int i = 0; i < size - 1; ++i) {
        if (x >= xp[i] && x <= xp[i + 1]) {
            // Perform linear interpolation
            double interp = fp[i] + (x - xp[i]) * (fp[i + 1] - fp[i]) / (xp[i + 1] - xp[i]);
            printf("Interpolating between %.2f and %.2f: Result = %.2f\n", xp[i], xp[i+1], interp);
            return interp;
        } 
    }   
    printf("linterp not running");
    return -1;
}

int main(int argc, char *argv[]) { // these are the arguments for some reason

    // Register Signal Handler 
    std::signal(SIGINT, signalHandler);
    printf("Beginning Script ... \n");

    // Initializing the adc
    if(rc_adc_init() != 0){ // Robot library functions: if initialization fails
        fprintf(stderr, "ADC initailization failed.\n"); // stderr is used to output error messages
        return -1; // ends the main function
    }

    // Defining Alex's mapping arrays
    double angle_alex[] = {0, 50, 70, 90, 110, 130, 180};
    double volt_alex[] = {0.08, 0.44, 0.49, 0.52, 0.55, 0.57, 0.61};

    printf("   Bits    |  Angle B  |  Voltage  |  Angle V  |  Abs Difference\n");
    printf("---------------------------------------------------------------\n");


    // Reading the adc values while bb is on
    while(keepRunning){
        // Checking if the raw data is obtained 
        if(rc_adc_read_volt	(ADC_CH) == -1){
            fprintf(stderr,"Raw VOLT data failed to read.\n");
            break;
        }
        if (rc_adc_read_raw(ADC_CH) == -1){
            fprintf(stderr,"Raw BIT data failed to read.\n");
            break;
        }

        // Converting volt to angles
        double raw_volt = rc_adc_read_volt(ADC_CH);
        double angle_v = linearInterp(raw_volt, volt_alex,angle_alex, 7);

        // Converting bits to angles (Eric's method)
        int raw_bit = rc_adc_read_raw(ADC_CH); // Getting the raw data in bits
        double angle_b = 270.0 * raw_bit / 4095.0 ;

        // Printing
        double abs_diff = std::abs(angle_v - angle_b);
        printf(" \r  %6d   |  %6.2f   |  %6.2f   |  %6.2f   |  %6.2f  ", raw_bit, angle_b, raw_volt, angle_v, abs_diff);
        fflush(stdout);
        // rc_usleep(100000);
    }

    // Ending the program
    rc_adc_cleanup(); // cleans up the adc subsytem
    printf("\nProgram successfully terminated.\n");
    return 0; // ends the main function
}