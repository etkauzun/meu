clc; clear;

% getting the values for LE with k=1,2,3,4 respectively
[approx_LE_k1, error_LE_k1, log_err_LE_k1,log_n_LE_k1] = q5_LE_appr(0,3,10e1);
[approx_LE_k2, error_LE_k2, log_err_LE_k2,log_n_LE_k2] = q5_LE_appr(0,3,10e2);
[approx_LE_k3, error_LE_k3, log_err_LE_k3,log_n_LE_k3] = q5_LE_appr(0,3,10e3);
[approx_LE_k4, error_LE_k4, log_err_LE_k4,log_n_LE_k4] = q5_LE_appr(0,3,10e4);

% getting the values for trap with k=1,2,3,4 respectively
[approx_t_k1, error_t_k1, log_err_t_k1,log_n_t_k1] = q5_trap_appr(0,3,10e1);
[approx_t_k2, error_t_k2, log_err_t_k2,log_n_t_k2] = q5_trap_appr(0,3,10e2);
[approx_t_k3, error_t_k3, log_err_t_k3,log_n_t_k3] = q5_trap_appr(0,3,10e3);
[approx_t_k4, error_t_k4, log_err_t_k4,log_n_t_k4] = q5_trap_appr(0,3,10e4);

% getting the values for CT with k=1,2,3,4 respectively
[approx_CT_k1, error_CT_k1, log_err_CT_k1,log_n_CT_k1] = q5_CT_appr(0,3,10e1);
[approx_CT_k2, error_CT_k2, log_err_CT_k2,log_n_CT_k2] = q5_CT_appr(0,3,10e2);
[approx_CT_k3, error_CT_k3, log_err_CT_k3,log_n_CT_k3] = q5_CT_appr(0,3,10e3);
[approx_CT_k4, error_CT_k4, log_err_CT_k4,log_n_CT_k4] = q5_CT_appr(0,3,10e4);

% creating arrays to store those values
log_n_LE = [log_n_LE_k1,log_n_LE_k2,log_n_LE_k3,log_n_LE_k4];
log_e_LE = [log_err_LE_k1,log_err_LE_k2,log_err_LE_k3,log_err_LE_k4];
log_n_t = [log_n_t_k1,log_n_t_k2,log_n_t_k3,log_n_t_k4];
log_e_t = [log_err_t_k1,log_err_t_k2,log_err_t_k3,log_err_t_k4];
log_n_CT = [log_n_CT_k1,log_n_CT_k2,log_n_CT_k3,log_n_CT_k4];
log_e_CT = [log_err_CT_k1,log_err_CT_k2,log_err_CT_k3,log_err_CT_k4];


figure(1); hold on;
plot(log_n_LE, log_e_LE,'-b','LineWidth',2); % plotting LE values
plot(log_n_t, log_e_t,'--r','LineWidth',2); % plotting trap values
plot(log_n_CT, log_e_CT,'-g','LineWidth',2); % plotting CT values
xlabel('log10 of n values'); ylabel('log10 of error values');
title('Graph of n vs error values');
legend('LE','Trapezoid','Corrected Trapz.');
hold off;
