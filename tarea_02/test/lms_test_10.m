% *************************************************************************
% TEST 10:
%
% Developers:   Daniel Kohkemper, Costa Rica Institute of Technology
%               Fabricio Quirós,  Ridgerun
% Date:         November, 2019
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
tol        = 1e-05;
iter_max   = size(u_vec, 1); % s=100000
alpha      = 0.01;
epsilon    = 2.5e-17;
lambda     = 0.989;
mu         = 0.025;
fprintf(' tol      = %d\n', tol);
fprintf(' iter_max = %d\n', iter_max);
fprintf(' alpha    = %d\n', alpha);
fprintf(' epsilon  = %d\n', epsilon);
fprintf(' lambda   = %d\n', lambda);
fprintf(' mu       = %d\n...\n', mu);

% Exercise 1
[idx_k, c_vector, error_vec, min_val_vec] = ...
    lms_10_gauss_newton(d_var, u_vec, c_init_vec, alpha, epsilon, lambda, mu, tol, iter_max);

% Exercise 2
% Subsection a
csvwrite("results/c_estimation/test_10_c_aprox.csv", c_vector);

% Subsection b
figure(1);
plot((1 : idx_k), error_vec);
xlabel("Iterarations");
ylabel("Error e_k");
title("Test 10: General error e_k vs Iterations")
print(1, "results/plots/test_10_ek.pdf");

figure(2);
plot((1 : idx_k), min_val_vec);
xlabel("Iterarations");
ylabel("Min value");
title("Test 10: Minimun value vs Iterations")
print(2, "results/plots/test_10_min.pdf");

fprintf('Simulation end\n');

% Subsection c
csvwrite("results/int_c_estimation/test_10_int_c_aprox.csv", int32(c_vector));
