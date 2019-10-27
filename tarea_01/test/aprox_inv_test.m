clc;
clear;
close('all');
addpath 'src';

% Set constants
mat_size  = 4;
ro        = 0.8;
sigma_sqr = 0.7;

% Set X covariance matrix
X_cov_mat = ones(mat_size, mat_size) * ro;
X_cov_mat = X_cov_mat - diag(diag(X_cov_mat)) + eye(mat_size, mat_size);
% Set V covariane matrix
V_cov_mat = sigma_sqr^2 * eye(mat_size, mat_size);
% Set random V vector, with zero mean and unit variance
v_vector = randn(mat_size, 1);
v_vector = (v_vector - mean(v_vector(:))) ./ var(v_vector(:));
% Set matrix A
mat_A     = full(gallery('tridiag', mat_size, 1, 3, 1));

test_mat  = [1 0 2; -1 5 0; 0 3 -9];
tolerance = 0.001;

matrix_a_inv = aprox_inv(test_mat, tolerance)