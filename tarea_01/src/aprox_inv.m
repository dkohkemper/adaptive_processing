% Calculate the inverse of a matrix
% Algoritm obtained from "A family of iterative methods for computing the approximate inverse of a
% square matrix and inner inverse of a non-square matrix"
% Given an input matrix A, the inverse X is calculated using the condition ||AX^(k) - I_m|| < tol
% Parameters:
%   input         matrix_a
%                 tolerance
%
%   output        matrix_a_inv
%
% Developer:    Daniel Kohkemper
% Date:         October, 2019
% *************************************************************************
function matrix_a_inv = aprox_inv(matrix_a, tolerance)

    % Check if tolerance is positive, else output error
    if (tolerance < 0)
        error("ERROR: Tolerance is negative.");
        return;
    end
    
    % Generate identity matrix size m
    ident_mat = eye(length(matrix_a));
    % Calculate upper limit of alpha
    upper_lim = 2 / norm(matrix_a)^2;
    % Calculate alpha using a random number and upper limit
    alpha = upper_lim * rand;
    % Calculate first approximation
    V_0 = alpha * cmplx_transp(matrix_a);
    % Calculate error
    error_k = frob_norm(matrix_a * V_0 - ident_mat);
    % Assing first approximation to V_q
    V_q = V_0;
    % Iterate to find the approximation given the tolerance
    while (error_k > tolerance)
        % Calculate next V_q
        V_q_next = V_q * (3 * ident_mat - 3 * matrix_a * V_q + (matrix_a * V_q)^2);
        % Update V_q
        V_q = V_q_next;
        % Get error of approximation
        error_k = frob_norm(matrix_a * V_q_next - ident_mat);
    end
    % Output matrix inverse approximation
    matrix_a_inv = V_q_next;
end