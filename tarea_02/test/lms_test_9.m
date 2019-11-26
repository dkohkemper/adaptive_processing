% *************************************************************************
% TEST 9:
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
epsilon    = 1e-15;
lambda     = 1;
fprintf(' tol      = %d\n', tol);
fprintf(' iter_max = %d\n', iter_max);
fprintf(' epsilon  = %d\n', epsilon);
fprintf(' lambda   = %d\n...\n', lambda);

% Exercise 1
[idx_k, c_vector, error_vec, min_val_vec] = lms_9_rls(d_var, u_vec, c_init_vec, epsilon, lambda, tol, iter_max);

% Exercise 2
% Subsection a
csvwrite("results/c_estimation/test_9_c_aprox.csv", c_vector);

% Subsection b
figure(1);
plot((1 : idx_k), error_vec);
xlabel("Iterarations");
ylabel("Error e_k");
title("Test 9: General error e_k vs Iterations")
print(1, "results/plots/test_9_ek.pdf");

figure(2);
plot((1 : idx_k), min_val_vec);
xlabel("Iterarations");
ylabel("Min value");
title("Test 9: Minimun value vs Iterations")
print(2, "results/plots/test_9_min.pdf");

fprintf('Simulation end\n');

% Subsection c
csvwrite("results/int_c_estimation/test_9_int_c_aprox.csv", int32(c_vector));
