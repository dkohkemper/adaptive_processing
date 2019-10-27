% Testbench to obtain the LMS estimator of x given y
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
mat_size  = 3;
ro        = 0.8;
sigma_sqr = 0.7;
tolerance = 0.001;

test_mat  = [1 0 2; -1 5 0; 0 3 -9];
matrix_a_inv = aprox_inv(test_mat, tolerance);

% Call solution
[matrix_k, error] = solucion_problA(mat_size, ro, sigma_sqr, tolerance);

fprintf('Error = %d\n', error);
