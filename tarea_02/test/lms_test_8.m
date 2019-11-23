% *************************************************************************
% TEST 8:
% *************************************************************************
clc;
clear;
close('all');
addpath 'src';

fprintf('Simulation start\n...\n');

% Set constants
d_var      = csvread("input/d.text");
u_vec      = csvread("input/U.text");
c_init_vec = zeros(size(u_vec, 2),1); % FIR Channel
tol        = 1e-10;
iter_max   = size(u_vec, 1); % s=100000
mu         = 1.5e-05;
delta      = 0.5;
fprintf('  tol    = %d\n', tol);
fprintf('iter_max = %d\n', iter_max);
fprintf('   mu    = %d\n', mu);
fprintf('  delta  = %d\n...\n', delta);

% Exercise 1
[idx_k, c_vector, error_vec, min_val_vec] = lms_8_lmmn(d_var, u_vec, c_init_vec, mu, delta, tol, iter_max);

% Exercise 2
%% Subsection a
csvwrite("results/c_estimation/test_8_c_aprox.csv", c_vector);

%% Subsection b
figure(1);
plot((1 : idx_k), error_vec);
xlabel("Iterarations");
ylabel("Error e_k");
title("Test 8: General error e_k vs Iterations")
print(1, "results/plots/test_8_ek.pdf");

figure(2);
plot((1 : idx_k), min_val_vec);
xlabel("Iterarations");
ylabel("Min value");
title("Test 8: Minimun value vs Iterations")
print(2, "results/plots/test_8_min.pdf");

fprintf('Simulation end\n');

%% Subsection c
csvwrite("results/int_c_estimation/test_8_int_c_aprox.csv", int32(c_vector));