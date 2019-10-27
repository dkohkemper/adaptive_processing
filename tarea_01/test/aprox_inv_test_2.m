% Testbench to obtain the LMS estimator of x given y
% Test 2
%   rho = 0.5
%   m   = 25
%   tol = 10^-4
%   sigma belongs to [0.1, 5]
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
mat_size  = 25;
rho       = 0.5;
sigma_sqr = (0.1 : 0.1 : 5).^2;
tolerance = 10^-4;

error_mat = NaN(1, length(sigma_sqr));

% Call solution
for idx_sigma = 1 : length(sigma_sqr)
    % Call solution to linear estimator of x given y
    [matrix_k, error] = solucion_problA(mat_size, rho, sigma_sqr(idx_sigma), tolerance);
    % Get error into vector
    error_mat(idx_sigma) = error;
end

figure;
stem(sigma_sqr, error_mat);
ylim([0 5])
xlabel("Std Dev \sigma");
ylabel("General error e_k");
title("Test 2: Std Dev \sigma vs general error e_k")
