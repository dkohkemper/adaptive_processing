% *************************************************************************
% TEST 3: Solves linear model y=Hx+v and plots
%         rho vs general error e_k
%         m     = 50
%         sigma = 1
%         tol   = 10^-4
%         rho belongs to [0.01, 0.99]
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
mat_size  = 50;
rho       = (0.01 : 0.01 : 0.99);
sigma_sqr = 1;
tolerance = 10^-2;

error_mat = NaN(1, length(rho));

test_mat  = [1 0 2; -1 5 0; 0 3 -9];
matrix_a_inv = aprox_inv(test_mat, tolerance);

% Call solution
for idx_rho = 1 : length(rho)
    % Call solution to linear estimator of x given y
    [matrix_k, error] = solucion_problA(mat_size, rho(idx_rho), sigma_sqr, tolerance);
    % Get error into vector
    error_mat(idx_rho) = error;
end

figure(3);
stem(rho, error_mat);
xlabel("Param \rho");
ylabel("General error e_k");
title("Test 3: Param \rho vs general error e_k")
