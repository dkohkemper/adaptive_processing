% Calculates the Frobenius norm of a matrix
% The Frobenius norma of a matrix is given by:
%   ||A||_F = (trace(A A*))^{1/2}
%           = [sum(j=1, m) sum(k=1, n) |A_{j,k}|^2]^{1/2}
%
% Source: http://esfm.egormaximenko.com/linalg/Frobenius_norm_es.pdf
%
% Parameters:
%   input         input_mat
%
%   output        output_mat
%
% Developer:    Daniel Kohkemper
% Date:         October, 2019
% *************************************************************************
function output_mat = frob_norm (input_mat)

    mat_1 = input_mat * cmplx_transp(input_mat);
    mat_2 = trace(mat_1);
    
    output_mat = sqrt(mat_2);
end