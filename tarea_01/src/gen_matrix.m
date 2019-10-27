% Generates diverse matrixes to be used in the solution of a linear model
%
% Parameters:
%   input         matrix_str
%                 mat_size
%                 ro
%                 sigma_sqr
%
%   output        matrix_str
%
% Developer:    Daniel Kohkemper
% Date:         October, 2019
% *************************************************************************
function matrix_str = gen_matrix(mat_size, ro, sigma_sqr)

    % Set X covariance matrix
    X_cov_mat = ones(mat_size, mat_size) * ro;
    matrix_str.X_cov_mat = X_cov_mat - diag(diag(X_cov_mat)) + eye(mat_size, mat_size);
    % Set V covariane matrix
    matrix_str.V_cov_mat = sigma_sqr^2 * eye(mat_size, mat_size);
    % Set random V vector, with zero mean and unit variance
    v_vector = randn(mat_size, 1);
    matrix_str.v_vector = (v_vector - mean(v_vector(:))) ./ var(v_vector(:));
    % Set matrix A
    matrix_str.mat_A = full(gallery('tridiag', mat_size, 1, 3, 1));
    % Set observation matrix y
    matrix_str.y_vector = randn(mat_size, 1);
end