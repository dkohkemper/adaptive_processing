% *************************************************************************
% Script that gives solution to problem:
%
%     min     E[|| s - B_1 C_1 x_1 - B_2 C_2 x_2 - ... - B_L C_L x_L||^2]
% B_1 ... B_L
% C_1 ... C_L
%
% Developers:   Daniel Kohkemper, Costa Rica Institute of Technology
%               Fabricio Quirós,  Ridgerun
% Date:         December, 2019
% *************************************************************************

% Make s random vector of dimension 30 and exponential covariance matrix ro = 0.4, sigma = 2

% x_j = A_j s_j + v_j, for j = 1,2 where
%   A_1 and A_2 are tridiagonal matrices 30x30, entries different than cero come from randn
%   v_1 and v_2 are random vectors of dimension 30, whose covariance matrices are 
%   R_v1v1 = 0.25 I_30 and R_v2v2 = 0.75 I_30.
%   s, v_1, v_2, are orthogonal between each other
%
%   Initial matrices B_1, B_2, C_1, C_2, are randomly generated between ]0,1[ using randn
%
%   Tolerance is epsilon = 10^-4 and max_iter = 1000
clc;
clear;
fclose("all");

ro       = 0.4;
sigma    = 2;
dim      = 4;
tol      = 10^-4;
max_iter = 1000;

% Generate s matrix
s_mat = rand(dim, dim);
% Generate s exponential covariance matrix
s_cov_mat = exp_cov_mat(ro, sigma, dim);

% Generate v1 and v1 random vectors
v1_mat = rand(dim, 1);
v2_mat = rand(dim, 1);

% Generate v1 and v2 covariance matrixes
R_v1v1 = 0.25 * eye(dim);
R_v2v2 = 0.75 * eye(dim);

% Generate A1 and A2
A1_mat = full(gallery('tridiag', dim, randn, randn, randn));
A2_mat = full(gallery('tridiag', dim, randn, randn, randn));

% Generate random C_i and B_i initial matrixes
B1_mat = rand(dim, dim);
B2_mat = rand(dim, dim);
C1_mat = rand(dim, dim);
C2_mat = rand(dim, dim);

% Generate the following graphs
%   error vs iterations
%   min vs iterations
%   min vs k
