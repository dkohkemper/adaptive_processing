% CMPLX_TRANSP Calculates the complex transpose of a matrix
%   OUT = CMPLX_TRANSP(IN) calculates the complex transpose OUT of matrix IN
%
% Developer:    Daniel Kohkemper
% Date:         October, 2019
% *************************************************************************
function output_mat = cmplx_transp(input_mat)
    % Get complex transpose
    output_mat = conj(transpose(input_mat));
end