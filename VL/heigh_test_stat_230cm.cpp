#include <iostream>
#include <robotcontrol.h>
#include <csignal>
#include <cmath>
#include <chrono>
#include <fstream>  // For file handling
#include <vector>   // For storing multiple measurements
#include <numeric>  // For calculating mean
#include <algorithm> // For calculating standard deviation

// this script is for the 230cm test, with the mean and std dev of 5 measurements at each interval saved to a file

#define LIDAR_I2C_BUS 1
#define LIDAR_ADDRESS 0x62
#define DMP_SAMPLE_RATE_HZ 100
#define DMP_I2C_BUS 2
#define DMP_GPIO_INT_PIN_CHIP 3
#define DMP_GPIO_INT_PIN_PIN 21
#define LIDAR_ANGLE_DEGREES 30.0
#define RATE_HZ 100

volatile bool keepRunning = true;

void signalHandler(int signum) {
    keepRunning = false;
}

void power_down() {
    rc_i2c_close(LIDAR_I2C_BUS);
    rc_mpu_power_off();
}

double calculate_mean(const std::vector<double>& data) {
    return std::accumulate(data.begin(), data.end(), 0.0) / data.size();
}

double calculate_standard_deviation(const std::vector<double>& data, double mean) {
    double sum = 0.0;
    for (const auto& value : data) {
        sum += std::pow(value - mean, 2);
    }
    return std::sqrt(sum / data.size());
}

int main() {
    double lidar_angle = LIDAR_ANGLE_DEGREES * M_PI / 180.0;
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
        std::cerr << "Failed to initialize I2C bus" << std::endl;
        return -1;
    }

    // Interval setting: 10 cm for each stop
    double height_interval = 0.10; // 10 cm in meters
    double current_height = 2.30;  // Starting height at 230 cm (2.30 meters)
    double next_target_height = current_height - height_interval;

    // Open a file to save the data
    std::ofstream data_file("rocket_data.csv");
    if (!data_file.is_open()) {
        std::cerr << "Failed to open file for writing" << std::endl;
        return -1;
    }
    data_file << "Height_Mean,Height_StdDev,Distance_Mean,Distance_StdDev\n";

    rc_filter_t height_filter = RC_FILTER_INITIALIZER;
    rc_filter_t distance_filter = RC_FILTER_INITIALIZER;

    double cutoff_freq = 2.0;  // Cutoff frequency in Hz
    double sample_rate = 20.0;  // Sample rate in Hz

    if (rc_filter_first_order_lowpass(&height_filter, cutoff_freq, sample_rate)) {
        std::cerr << "Failed to initialize height filter\n";
        return -1;
    }

    if (rc_filter_first_order_lowpass(&distance_filter, cutoff_freq, sample_rate)) {
        std::cerr << "Failed to initialize distance filter\n";
        return -1;
    }

    while (keepRunning) {
        std::vector<double> heights;
        std::vector<double> distances;

        // Collect 5 measurements
        for (int i = 0; i < 5; ++i) {
            auto start = std::chrono::high_resolution_clock::now();

            // Rangefinder measurement code
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

            double distance = ((data[0] << 8) | data[1]) / 100.0; // [m]

            double norm = rc_vector_norm(rf_measurement_b, 2);
            if (rc_vector_times_scalar(&rf_measurement_b, distance / norm) != 0) {
                std::cerr << "Failed to normalize and magnify measurement body vector" << std::endl;
                power_down();
                return -1;
            }

            // Reading orientation from IMU
            for (int i = 0; i < 4; i++) {
                quat_array[i] = mpu_data.fused_quat[i];
            }

            rc_vector_from_array(&quat, quat_array, 4);
            rc_quaternion_to_tb(quat, &tb_angles);
            rc_quaternion_to_rotation_matrix(quat, &b2l);
            rc_matrix_times_col_vec(b2l, rf_measurement_b, &rf_measurement_l);
            rc_matrix_times_col_vec(b2l, rf_placement_b, &rf_placement_l);

            double height = std::fabs(rf_measurement_l.d[2] + rf_placement_l.d[2]);

            auto end = std::chrono::high_resolution_clock::now();
            std::chrono::duration<double> duration = end - start;

            double filtered_height = rc_filter_march(&height_filter, height);
            double filtered_distance = rc_filter_march(&distance_filter, distance);

            heights.push_back(filtered_height);
            distances.push_back(filtered_distance);

            rc_usleep(1000000 / RATE_HZ); // Sleep to maintain the sample rate
        }

        // Calculate mean and standard deviation
        double height_mean = calculate_mean(heights);
        double height_stddev = calculate_standard_deviation(heights, height_mean);
        double distance_mean = calculate_mean(distances);
        double distance_stddev = calculate_standard_deviation(distances, distance_mean);

        // Save data after user confirmation
        auto now = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
        data_file << height_mean << ","
                  << height_stddev << ","
                  << distance_mean << ","
                  << distance_stddev << "\n";

        // Inform the user of the current height
        std::cout << "Measurements taken at height: " << height_mean << " meters" << std::endl;

        // Check if the user is ready to move to the next interval
        std::cout << "Move the rocket to " << next_target_height << " meters and press Enter to continue... ";
        std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');

        // Update the next target height
        next_target_height -= height_interval;

        // Break the loop if the next target height is less than or equal to zero
        if (next_target_height <= 0) {
            break;
        }
    }

    data_file.close(); // Close the file
    rc_filter_free(&height_filter);
    rc_filter_free(&distance_filter);

    power_down();
    std::cout << "Program Terminated" << std::endl;
    return 0;
}
