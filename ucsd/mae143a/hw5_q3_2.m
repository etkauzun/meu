close all; clear; clc
    % Parameters
    dt = 0.001;
    t = 0:dt:5;
    h_values = [0.1, 0.2, 0.4];
    
    % Continuous sine wave
    y_t = sin(pi * t);
    
    % Plot
    figure;
    for i = 1:length(h_values)
        h = h_values(i);
        t_h = 0:h:5;
        y_h = sin(pi * t_h);
        
        [x_zoh, y_zoh] = stairs(t_h, y_h);
        y_k = y_zoh(1:2:end);
        x_k = x_zoh(1:2:end);
        
        subplot(3, 3, i);
        plot(t, y_t, 'r', x_zoh, y_zoh, 'b', x_k, y_k, 'x');
        title(['ZOH (h = ', num2str(h), ')']);
        xlabel('Time');
        ylabel('Amplitude');
        legend('Continuous Sine Wave', 'Sampled Points', 'Location', 'best');
        grid on;
    end
    
    for i = 1:length(h_values)
        h = h_values(i);
        t_h = 0:h:5;
        y_h = sin(pi * t_h);
        
        [x_zoh, y_zoh] = stairs(t_h, y_h);
        y_k = y_zoh(1:2:end);
        x_k = x_zoh(1:2:end);
        
        y_foh = zeros(size(y_zoh));
        y_foh(1) = y_k(1);
        y_foh(2) = y_k(2);
        for j = 4:2:(length(x_zoh)-1)
            if j-3 >= 1 && j-1 <= length(y_k)
                y_foh(j-1) = y_zoh(j-1);
                m = (y_zoh(j-1) - y_zoh(j-2));
                y_foh(j) = (m) + y_zoh(j-1);
            end
        end
        
        subplot(3, 3, length(h_values) + i);
        plot(t, y_t, 'r', x_zoh, y_zoh, 'b', x_k, y_k, 'x', x_zoh(1:end-1), y_foh(1:end-1), 'm');
        title(['FOH (h = ', num2str(h), ')']);
        xlabel('Time');
        ylabel('Amplitude');
        legend('Continuous Sine Wave', 'Sampled Points', 'FOH', 'Location', 'best');
        grid on;
    end
    
    for i = 1:length(h_values)
        h = h_values(i);
        t_h = 0:h:5;
        y_h = sin(pi * t_h);
        
        [x_zoh, y_zoh] = stairs(t_h, y_h);
        y_k = y_zoh(1:2:end);
        x_k = x_zoh(1:2:end);
        
        y_soh = zeros(size(y_zoh));
        for j = 4:2:(length(x_zoh)-1)
            if j-3 >= 1 && j-1 <= length(y_k)
                xmin = j - 3; 
                xmax = j - 1;
                xd = [x_zoh(xmin), x_zoh(xmax)];
                fd = [y_k(j-3), y_k(j-1)];
                x = [x_zoh(xmax + 1)];
                y_soh(j-1:j) = Lagrange(x, xd, fd);
            end
        end
        
        subplot(3, 3, 2*length(h_values) + i);
        plot(t, y_t, 'r', x_zoh, y_zoh, 'b', x_k, y_k, 'x', x_zoh(1:end-1), y_soh(1:end-1), 'g');
        title(['SOH (h = ', num2str(h), ')']);
        xlabel('Time');
        ylabel('Amplitude');
        legend('Continuous Sine Wave', 'Sampled Points', 'SOH', 'Location', 'best');
        grid on;
    end

