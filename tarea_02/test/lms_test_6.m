% *************************************************************************
% TEST 6:
% *************************************************************************
clc;
clear;
close('all');
addpath 'src';

fprintf('Simulation start\n');

% Set constants
d_var      = csvread("input/d.text");
u_vec      = csvread("input/U.text");
w_init_vec = zeros(size(u_vec, 2),1);
tol        = 10^-6;
iter_max   = size(u_vec, 1);
mu         = 0.0001;
alpha      = 0.01;

[idx_k, w_vector, error_vec, min_val_vec] = lms_6_leaky_lms(d_var, u_vec, w_init_vec, mu, alpha, tol, iter_max);

figure(1);
plot((1 : idx_k), error_vec);
xlabel("Iterarations");
ylabel("Error e_k");
title("Test 6: General error e_k vs Iterations")

figure(2);
plot((1 : idx_k), min_val_vec);
xlabel("Iterarations");
ylabel("Min value");
title("Test 6: Minimun value vs Iterations")

fprintf('Simulation end\n');
