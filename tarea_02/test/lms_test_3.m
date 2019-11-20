% *************************************************************************
% TEST 3:
% *************************************************************************
clc;
clear;
close('all');
addpath 'src';

fprintf('Simulation start\n');

% Set constants
d_var      = csvread("input/d.text");
u_vec      = csvread("input/U.text");
c_init_vec = zeros(size(u_vec, 2),1); % FIR Channel
tol        = 10^-5;
iter_max   = size(u_vec, 1);
mu         = 0.1;
epsilon    = 10^-15;

[idx_k, c_vector, error_vec, min_val_vec] = lms_3_e_nlms(d_var, u_vec, c_init_vec, mu, epsilon, tol, iter_max);
csvwrite("results/test_3_c_aprox.csv", c_vector);

figure(1);
plot((1 : idx_k), error_vec);
xlabel("Iterarations");
ylabel("Error e_k");
title("Test 3: General error e_k vs Iterations")

figure(2);
plot((1 : idx_k), min_val_vec);
xlabel("Iterarations");
ylabel("Min value");
title("Test 3: Minimun value vs Iterations")

fprintf('Simulation end\n');
