% Testbench to obtain the LMS estimator of x given y
% Test 1
%   rho   = 0.5
%   sigma = 1
%   tol   = 10^-4
%   m belongs to [2,100]
%
%   Plot dimension m vs general error e_k
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
mat_size  = 2 : 1: 100;
rho       = 0.5;
sigma_sqr = 1;
tolerance = 10^-4;

error_mat = NaN(1, length(mat_size));

% Call solution
for idx_dim = 1 : length(mat_size)
    % Call solution to linear estimator of x given y
    [matrix_k, error] = solucion_problA(mat_size(idx_dim), rho, sigma_sqr, tolerance);
    % Get error into vector
    error_mat(idx_dim) = error;
end

figure(1);
stem(mat_size, error_mat);
xlabel("Dimension m");
ylabel("General error e_k");
title("Test 1: Dimension m vs general error e_k")
