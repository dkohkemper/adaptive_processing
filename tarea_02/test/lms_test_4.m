% *************************************************************************
% TEST 4:
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
% TODO: Check that in e-NLMS pow norm, mu and epsilon should be M times smaller
% than in e-NLMS
mu         = 0.1;
epsilon    = 10^-15;
beta       = 0.5;

[idx_k, w_vector, error_vec, min_val_vec] = ...
    lms_4_e_nlms_pow_norm(d_var, u_vec, w_init_vec, mu, epsilon, beta, tol, iter_max);

figure(1);
plot((1 : idx_k), error_vec);
xlabel("Iterarations");
ylabel("Error e_k");
title("Test 4: General error e_k vs Iterations")

figure(2);
plot((1 : idx_k), min_val_vec);
xlabel("Iterarations");
ylabel("Min value");
title("Test 4: Minimun value vs Iterations")

fprintf('Simulation end\n');
