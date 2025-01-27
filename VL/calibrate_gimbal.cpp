#include <cmath>
#include <csignal>
#include <ctime>
#include <iostream>
#include <fstream>
#include <stdio.h>
#include <chrono>
#include "../include/eric_gimbal_decs.h"
#include <robotcontrol.h>

int main() {

    std::ofstream dataFile("../data/gimbal_calibration_data.txt", std::ios::out);
    if(!dataFile.is_open()) {
        fprintf(stderr, "Failed to open calibration file");
        return -1;
    }

    if (rc_adc_init() != 0) {
        fprintf(stderr, "ADC failed to initialize!\n");
        return -1;
    }

    // Calibrating the potentiometer
    std::cout << "Calibrating the potentiometer...\n";

    // Potentiometer Calibration Values
    int x_pos_bits, x_neg_bits, y_pos_bits, y_neg_bits;
    double x_pos_angle, x_neg_angle, y_pos_angle, y_neg_angle;
    // x+
    int x = 0;
    do {
        std::cout << "In X, please rotate rocket as far as possible in the positive dirction and log the absolute angle!\n";
        std::cin >> x_pos_angle;
        x_pos_bits =  rc_adc_read_raw(ADC_CH_X);
        std::cout << "Positive x measurement concluded\n";

        std::cout << "If you want to repeat this measurement, please enter (1) for YES and (2) for NO:\n";
        std::cin >> x;
    }   while(x == 1);
    // x-
    do { 
        std::cout << "In X, please rotate rocket as far as possible in the negative dirction and log the absolute angle!\n";
        std::cin >> x_neg_angle;
        x_neg_angle = -x_neg_angle;
        x_neg_bits =  rc_adc_read_raw(ADC_CH_X);
        std::cout << "Negative x measurement concluded\n";
        std::cout << "If you want to repeat this measurement, please enter (1) for YES and (2) for NO:\n";
        std::cin >> x;
        std::cin.ignore();  // Correctly handle input buffer
    }   while(x == 1);
    // y+
    do {
        std::cout << "In Y, please rotate rocket as far as possible in the positive dirction and log the absolute angle!\n";
        std::cin >> y_pos_angle;
        y_pos_bits =  rc_adc_read_raw(ADC_CH_Y);
        std::cout << "Positive y measurement concluded\n";
        std::cout << "If you want to repeat this measurement, please enter (1) for YES and (2) for NO:\n";
        std::cin >> x;
        std::cin.ignore();  // Correctly handle input buffer
    }   while(x == 1);
    //y-
    do {
        std::cout << "In Y, please rotate rocket as far as possible in the neegative dirction and log the absolute angle!\n";
        std::cin >> y_neg_angle;
        y_neg_angle = -y_neg_angle;
        y_neg_bits =  rc_adc_read_raw(ADC_CH_Y);
        std::cout << "Negative y measurement concluded\n";
        std::cout << "If you want to repeat this measurement, please enter (1) for YES and (2) for NO:\n";
        std::cin >> x;
        std::cin.ignore();  // Correctly handle input buffer
    }   while(x == 1);

    printf("Calibration Complete!\n");
    
    printf(" x angle range | x poten range | y angle range | y poten range |\n");
    printf(" %2.1f - %2.1f |", x_neg_angle, x_pos_angle);
    printf(" %4d - %4d     |", x_neg_bits, x_pos_bits);
    printf(" %2.1f - %2.1f |", y_neg_angle, y_pos_angle);
    printf(" %4d - %4d     |", y_neg_bits, y_pos_bits);
    printf("\n");

    // Log calibration data
    dataFile << x_neg_angle << ", " << x_pos_angle << ", " << x_neg_bits << ", " << x_pos_bits << std::endl;
    dataFile << y_neg_angle << ", " << y_pos_angle << ", " << y_neg_bits << ", " << y_pos_bits << std::endl;

    dataFile.close();
    return 0;
}