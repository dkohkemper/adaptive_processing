% Solve a linear model
% Given a random vector x wich belongs to R^{m} with zero mean E[x] = 0_m and covariance matrix
% R_{xx} which belongs to R^{m x m} given by a constant covariance matrix with parameter ro which
% belongs to ]0,1[. Consider an observation vector y = Ax + n, where A belongs to R^{m x m} and it is
% a tridiagonal matrix and n is a random vector which belongs to R^{m} and has zero mean E[n] = 0_m and
% covariance matrix R_vv = sigma_sqr I_m, with I_m being the identity matrix of m-th order.
% Vectors x and n are orthogonal.
% Calculate the linear estimator of x given y.
%
% The LMS linear estimator of x given y may be evaluated with the following two expressions:
%
% hat_{x} = R_x H* [R_v + H R_x H*]^{-1} y
%
% hat_{x} = [(R_x)^{-1} + H* (R_v)^{-1} H]^{-1} H* (R_v)^{-1} y
%
% where MMSE = [(R_x)^{-1} + H* (R_v)^{-1} H]^{-1}
% 
% Parameters:
%   input         mat_size
%                 ro
%                 sigma_sqr
%                 tolerance
%
%   output        matrix_k
%                 error
%
% Developer:    Daniel Kohkemper
% Date:         October, 2019
% *************************************************************************
function [matrix_k, error] = solucion_problA(mat_size, ro, sigma_sqr, tolerance)

    % Init variables, to be deleted
    error = [];    
    
    % Generate matrixes to be used in the linear model solution
    matrix_str = gen_matrix(mat_size, ro, sigma_sqr);

    % Unfold struct variables
    X_cov_mat = matrix_str.X_cov_mat;
    V_cov_mat = matrix_str.V_cov_mat;
    v_vector  = matrix_str.v_vector;
    mat_A     = matrix_str.mat_A;
    y_vector  = matrix_str.y_vector;

    % Check if tolerance is positive, else output error
    if (tolerance < 0)
        error("ERROR: Tolerance is negative.");
        return;
    end

    % Calculate matrix_k
    mat_1    = aprox_inv(X_cov_mat, tolerance);
    mat_2    = cmplx_transp(mat_A) * aprox_inv(V_cov_mat, tolerance) * mat_A;
    MMSE     = aprox_inv((mat_1 + mat_2), tolerance);
    matrix_k = MMSE * cmplx_transp(mat_A) * aprox_inv(V_cov_mat, tolerance);

    % Obtain estimate of x variable
    x_estimate = matrix_k * y_vector;
    
    % Calculate error
    mat_1 = x_estimate - matrix_k * y_vector;
    error = (norm(mat_1))^2;
end