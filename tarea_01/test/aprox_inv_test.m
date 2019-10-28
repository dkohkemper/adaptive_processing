% *************************************************************************
% TEST: Compares output of Matlab INV() function and APROX_INV().
%
% Developer:    Daniel Kohkemper
% Date:         October, 2019
% *************************************************************************
clc;
clear;
close('all');
addpath 'src';

fprintf('Simulation start\n');

% Set constants
mat_size  = 4;
ro        = 0.8;
sigma_sqr = 0.7;
tolerance = 0.001;

% Set test matrix
test_mat  = rand(mat_size, mat_size);

% Use matlab inverse function
matrix_inv = inv(test_mat)
% Get matrix inverse through approximation
matrix_inv_approx = aprox_inv(test_mat, tolerance)
