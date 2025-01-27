#include <iostream>
#include <robotcontrol.h>
#include <csignal>
#include <cmath>
#include <chrono>
#include <fstream>

#define LIDAR_I2C_BUS 1
#define LIDAR_ADDRESS 0x62
#define DMP_SAMPLE_RATE_HZ 20
#define DMP_I2C_BUS 2
#define DMP_GPIO_INT_PIN_CHIP 3
#define DMP_GPIO_INT_PIN_PIN 21
#define LIDAR_ANGLE_DEGREES 30.0
#define RATE_HZ 20

// this script saves data for each interval (must be increasing)

volatile bool keepRunning = true;

void signalHandler(int signum) {
    keepRunning = false;
}

void power_down() {
    rc_i2c_close(LIDAR_I2C_BUS);
    rc_mpu_power_off();
}

int main() {

    double lidar_angle = LIDAR_ANGLE_DEGREES*M_PI/180.0;
    double quat_array[4] = {1.0, 0.0, 0.0, 0.0};
    double rf_measurement_hat_b_array[3] = {0.0, std::sin(lidar_angle), -std::cos(lidar_angle)};
    double rf_placement_b_array[3] = {0.0, 0.0, 0.0};

    rc_vector_t quat = RC_VECTOR_INITIALIZER;
    rc_vector_from_array(&quat, quat_array, 4);
    rc_vector_t tb_angles = RC_VECTOR_INITIALIZER;
    rc_vector_alloc(&tb_angles, 3);

    rc_vector_t rf_measurement_b = RC_VECTOR_INITIALIZER;
    rc_vector_from_array(&rf_measurement_b, rf_measurement_hat_b_array, 3);
    rc_vector_t rf_placement_b = RC_VECTOR_INITIALIZER;
    rc_vector_from_array(&rf_placement_b, rf_placement_b_array, 3);

    rc_vector_t rf_measurement_l = RC_VECTOR_INITIALIZER;
    rc_vector_alloc(&rf_measurement_l, 3);
    rc_vector_t rf_placement_l = RC_VECTOR_INITIALIZER;
    rc_vector_alloc(&rf_placement_l, 3);

    rc_matrix_t l2b = RC_MATRIX_INITIALIZER;
    rc_matrix_t b2l = RC_MATRIX_INITIALIZER;
    rc_matrix_alloc(&l2b, 3, 3);
    rc_matrix_alloc(&b2l, 3, 3);

    /*
    Initialize signal handler, IMU, and i2c communication
    */

    std::signal(SIGINT, signalHandler);

    rc_mpu_data_t mpu_data;
    rc_mpu_config_t conf = rc_mpu_default_config();
    conf.dmp_sample_rate = DMP_SAMPLE_RATE_HZ;
    conf.i2c_bus = DMP_I2C_BUS;
    conf.gpio_interrupt_pin_chip = DMP_GPIO_INT_PIN_CHIP;
    conf.gpio_interrupt_pin = DMP_GPIO_INT_PIN_PIN;
    conf.enable_magnetometer = 1;

    if (rc_mpu_initialize_dmp(&mpu_data, conf) < 0) {
        std::cerr << "Failed to initialize MPU" << std::endl;
        rc_i2c_close(LIDAR_I2C_BUS);
        return -1;
    }

    if (rc_i2c_init(LIDAR_I2C_BUS, LIDAR_ADDRESS) < 0) {
        std::cerr << "Failed to initialized I2C bus" << std::endl;
        return -1;
    }

    // User-defined height interval
    double height_interval;
    std::cout << "Enter the height interval (in meters) for saving data: ";
    std::cin >> height_interval;

    /*
    Header for Terminal Data
    */
    printf(" Raw Dist |");
    printf("  Height  |");
    printf(" Filtered Raw Dist |");
    printf("  Filtered Height  |");
    /*
    printf("    q0    |");
    printf("    q1    |");
    printf("    q2    |");
    printf("    q3    |");
    printf("  Tait_x  |");
    printf("  Tait_y  |");
    printf("  Tait_z  |");
    */
    //printf("  ms_b_x  |");
    //printf("  ms_b_y  |");
    printf("  ms_b_z  |");
    //printf("  ms_l_x  |");
    //printf("  ms_l_y  |");
    printf("  ms_l_z  |");
    // printf(" loop [s] |");
    printf("\n");

    // Initialize the next target height
    double next_target_height = height_interval;

    // Define a tolerance range
    double tolerance = 0.10; // Tolerance of ±0.10 meters

    // Open a file to save the data
    std::ofstream data_file("rocket_data.csv");
    if (!data_file.is_open()) {
        std::cerr << "Failed to open file for writing" << std::endl;
        return -1;
    }
    data_file << "Time,Height,Distance,Filtered_Height,Filtered_Distance\n";

    // Low-pass filtering height and data
    rc_filter_t height_filter = RC_FILTER_INITIALIZER;  // Create an empty filter for height
    rc_filter_t distance_filter = RC_FILTER_INITIALIZER;  // Create an empty filter for distance

    double filtered_height, filtered_distance; // Declare the variables

    // Parameters for the low-pass filter
    double cutoff_freq = 3.0;  // Cutoff frequency in Hz
    double sample_rate = 20.0;  // Sample rate in Hz

    // Initialize the filters with first-order low-pass
    if (rc_filter_first_order_lowpass(&height_filter, cutoff_freq, sample_rate)) {
        fprintf(stderr, "Failed to initialize height filter\n");
        return -1;
    }

    if (rc_filter_first_order_lowpass(&distance_filter, cutoff_freq, sample_rate)) {
        fprintf(stderr, "Failed to initialize distance filter\n");
        return -1;
    }

    
    while (keepRunning) {

        // Start clock for computation time
        auto start = std::chrono::high_resolution_clock::now();

        /*
        READING DISTANCE FROM RANGEFINDER
        */
        if (rc_i2c_write_byte(LIDAR_I2C_BUS, 0x00, 0x04) < 0) {
            std::cerr << "Failed to send measurement command" << std::endl;
            power_down();
            return -1;
        }

        uint8_t status;
        do {
            if (rc_i2c_read_byte(LIDAR_I2C_BUS, 0x01, &status) < 0) {
                std::cerr << "Failed to read status register" << std::endl;
                power_down();
                return -1;
            }
        } while (status & 0x01);

        uint8_t data[2];
        if (rc_i2c_read_byte(LIDAR_I2C_BUS, 0x0f, &data[0]) < 0) {
            std::cerr << "Failed to read high byte" << std::endl;
            power_down();
            return -1;
        }
        if (rc_i2c_read_byte(LIDAR_I2C_BUS, 0x10, &data[1]) < 0) {
            std::cerr << "Failed to read low byte" << std::endl;
            power_down();
            return -1;
        }

        double distance = ((data[0] << 8) | data[1])/100.0; //[m]

        double norm = rc_vector_norm(rf_measurement_b, 2);
        if (rc_vector_times_scalar(&rf_measurement_b, distance/norm) != 0) {
            std::cerr << "Failed to normalize and magnify measurement body vector" << std::endl;
            power_down();
            return -1;
        }

        /*
        READING ORIENTATION FROM IMU
        */

        for (int i = 0; i < 4; i++) {
            quat_array[i] = mpu_data.fused_quat[i];
        }

        rc_vector_from_array(&quat, quat_array, 4);

        rc_quaternion_to_tb(quat, &tb_angles);

        rc_quaternion_to_rotation_matrix(quat, &b2l);

        rc_matrix_times_col_vec(b2l, rf_measurement_b, &rf_measurement_l);
        rc_matrix_times_col_vec(b2l, rf_placement_b, &rf_placement_l);

        double height = std::fabs(rf_measurement_l.d[2] + rf_placement_l.d[2]);

        //Check computation time
        auto end = std::chrono::high_resolution_clock::now();
        std::chrono::duration<double> duration = end - start;

        // Getting the filtered data
        filtered_height = rc_filter_march(&height_filter, height);
        filtered_distance = rc_filter_march(&distance_filter, distance);   

        // Check if the current height is within the target range
        if (height >= next_target_height) {
            // Inform the user
            std::cout << "\nHeight interval reached: " << height << " meters. Saving data...\n";

            // Get the current time since the start
            auto now = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());

            // Debug print to confirm saving data
            std::cout << "Saving data at height: " << height << std::endl;

            // Save data to the file
            data_file << std::ctime(&now) << ","
                      << height << ","
                      << distance << ","
                      << filtered_height << ","
                      << filtered_distance << "\n";

            // Update the next target height
            next_target_height += height_interval;
        }


        /*
        Print Data to Terminal
        */
        
        printf("\r");
        printf("%7.3f   |", distance);
        printf("%7.3f   |", height);
        printf("%7.3f   |", filtered_distance);
        printf("%7.3f   |", filtered_height);
        //printf("%7.3f   |", quat.d[0]);
        //printf("%7.3f   |", quat.d[1]);
        //printf("%7.3f   |", quat.d[2]);
        //printf("%7.3f   |", quat.d[3]);
        //printf("%7.3f   |", tb_angles.d[0]*RAD_TO_DEG);
        //printf("%7.3f   |", tb_angles.d[1]*RAD_TO_DEG);
        //printf("%7.3f   |", tb_angles.d[2]*RAD_TO_DEG);
        //printf("%7.3f   |", rf_measurement_b.d[0]);
        //printf("%7.3f   |", rf_measurement_b.d[1]);
        printf("%7.3f   |", rf_measurement_b.d[2]);
        //printf("%7.3f   |", rf_measurement_l.d[0]);
        //printf("%7.3f   |", rf_measurement_l.d[1]);
        printf("%7.3f   |", rf_measurement_l.d[2]);
        //printf("%7.3f   |", duration.count());
        
        fflush(stdout);

        rc_usleep(1000000/RATE_HZ);

    }

    rc_filter_free(&height_filter);
    rc_filter_free(&distance_filter);

    data_file.close(); // Close the file
    power_down();
    std::cout << "Program Terminated" << std::endl;
    return 0;

}