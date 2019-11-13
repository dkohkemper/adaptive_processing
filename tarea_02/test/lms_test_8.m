% *************************************************************************
% TEST 1: 
% *************************************************************************
clc;
clear;
close('all');
addpath 'src';

fprintf('Simulation start\n');

% Set constants
d_var      = csvread("../input/d.text");
u_vec      = csvread("../input/U.text");
w_init_vec = [];
tol        = 0;
iter_max   = 0;

[idx_k, w_vector, error, min_val] = lms_8_lmmn(d_var, u_vec, w_init_vec, tol, iter_max);

% TODO: Uncomment when function works
% figure(1);
% stem(idx_k, error);
% xlabel("Iterarations");
% ylabel("Error e_k");
% title("Test 1:Iterations vs general error e_k")
% 
% figure(2);
% stem(idx_k, min_val);
% xlabel("Iterarations");
% ylabel("Min value");
% title("Test 1:Iterations vs minimun value")

fprintf('Simulation end\n');