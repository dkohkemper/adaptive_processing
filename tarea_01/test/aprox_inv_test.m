% Testbench to obtain the LMS estimator of x given y
%
% Developer:    Daniel Kohkemper
% Date:         October, 2019
% *************************************************************************
clc;
clear;
close('all');
addpath 'src';

% Set constants
mat_size  = 4;
ro        = 0.8;
sigma_sqr = 0.7;
tolerance = 0.001;
matrix_str = [];

% Generate matrixes to be used in the linear model solution
matrix_str = gen_matrix(matrix_str, mat_size, ro, sigma_sqr);

test_mat  = [1 0 2; -1 5 0; 0 3 -9];
matrix_a_inv = aprox_inv(test_mat, tolerance);

% Call solution
[matrix_k, error] = solucion_problA(matrix_str, mat_size, ro, sigma_sqr, tolerance);