% FROB_NORM Calculates the Frobenius norm of a matrix
%   FROB_NORM = FROB_NORM (IN) calculates the Frobenius norm FROB_NORM of
%   input matrix IN
%   The Frobenius norm of a matrix is given by:
%   ||A||_F = (trace(A A*))^{1/2}
%           = [sum(j=1, m) sum(k=1, n) |A_{j,k}|^2]^{1/2}
%
%   Source: http://esfm.egormaximenko.com/linalg/Frobenius_norm_es.pdf
%
% Developer:    Daniel Kohkemper
% Date:         October, 2019
% *************************************************************************
function frob_norm = frob_norm (input_mat)
    val_1 = input_mat * cmplx_transp(input_mat);
    val_2 = trace(val_1);
    frob_norm = sqrt(val_2);
end