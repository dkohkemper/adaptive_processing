% Calculates the complex transpose of a matrix
%
% Parameters:
%   input         input_mat
%
%   output        output_mat
%
% Developer:    Daniel Kohkemper
% Date:         October, 2019
% *************************************************************************
function output_mat = cmplx_transp(input_mat)

    % Get complex transpose
    output_mat = conj(transpose(input_mat));
end