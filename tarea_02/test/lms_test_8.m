% *************************************************************************
% TEST 8:
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
delta      = 0.5;

[idx_k, w_vector, error_vec, min_val_vec] = lms_8_lmmn(d_var, u_vec, w_init_vec, mu, delta, tol, iter_max);

figure(1);
plot((1 : idx_k), error_vec);
xlabel("Iterarations");
ylabel("Error e_k");
title("Test 8: General error e_k vs Iterations")

figure(2);
plot((1 : idx_k), min_val_vec);
xlabel("Iterarations");
ylabel("Min value");
title("Test 8: Minimun value vs Iterations")

fprintf('Simulation end\n');
