% SOLUCION_PROBLA Solves a linear model y = Hx+v
%   [K, E_k] = SOLUCION_PROBLA(A_SIZE, RHO, VAR, TOL) Given the values of
%   of matrix size A_SIZE, rho value RHO, variance VAR and tolerance TOL,
%   solves the optimum K vector that minimizes the general error
%
%   The LMS linear estimator of x given y may be evaluated with the following
%   two expressions:
%
%   hat_{x} = R_x H* [R_v + H R_x H*]^{-1} y
%
%   hat_{x} = [(R_x)^{-1} + H* (R_v)^{-1} H]^{-1} H* (R_v)^{-1} y
%
%   where MMSE = [(R_x)^{-1} + H* (R_v)^{-1} H]^{-1}
%
% Developer:    Daniel Kohkemper
% Date:         October, 2019
% *************************************************************************
function [matrix_k, error_k] = solucion_problA(mat_size, ro, sigma_sqr, tolerance)

    % Generate matrixes to be used in the linear model solution
    matrix_str = gen_matrix(mat_size, ro, sigma_sqr);

    % Unfold struct variables
    X_cov_mat = matrix_str.X_cov_mat;
    V_cov_mat = matrix_str.V_cov_mat;
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

    % Calculate Ryy
    Y_cov_mat = mat_A * X_cov_mat * cmplx_transp(mat_A) + V_cov_mat;    
    % Calculate error
    error_k = trace(X_cov_mat - matrix_k * Y_cov_mat * cmplx_transp(matrix_k));
end