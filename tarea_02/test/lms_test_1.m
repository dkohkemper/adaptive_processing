% *************************************************************************
% TEST 1: 
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
tol        = 0.01;
iter_max   = 3000;
mu         = 0.001;

[idx_k, w_vector, error, min_val] = lms_1_const_step(d_var, u_vec, w_init_vec, mu, tol, iter_max);

figure(1);
plot((1 : idx_k), error);
xlabel("Iterarations");
ylabel("Error e_k");
title("Test 1:Iterations vs general error e_k")
% 
% figure(2);
% stem(idx_k, min_val);
% xlabel("Iterarations");
% ylabel("Min value");
% title("Test 1:Iterations vs minimun value")

fprintf('Simulation end\n');
