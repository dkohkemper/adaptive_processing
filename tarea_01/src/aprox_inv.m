% Calculate the inverse of a matrix
% Algoritm obtained from "A family of iterative methods for computing the approximate inverse of a
% square matrix and inner inverse of a non-square matrix"
% Given an input matrix A, the inverse X is calculated using the condition ||AX^(k) - I_m|| < tol
% Parameters:
%   input         matrix_a
%                 tolerance
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

    % Calculate matrix inverse
    % TODO: Implement algorithm
    matrix_a_inv = inv(matrix_a);
end