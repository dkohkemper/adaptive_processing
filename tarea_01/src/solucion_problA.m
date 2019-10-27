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
function [matrix_k, error] = solucion_problA(matrix_str, mat_size, ro, sigma_sqr, tolerance)

    % Init variables, to be deleted
    matrix_k = [];
    error    = [];    
    mat_size  = mat_size;
    ro        = ro;
    sigma_sqr = sigma_sqr;
    matrix_str = matrix_str;
    
    % Check if tolerance is positive, else output error
    if (tolerance < 0)
        error("ERROR: Tolerance is negative.");
        return;
    end
    
    % Use inverse matrix function in the calculations
    % matrix_a_inv = aprox_inv(test_mat, tolerance)
    
    % TODO: Implement approximation -> output matrix_k
    
    % TODO: Calculate error -> output error
end