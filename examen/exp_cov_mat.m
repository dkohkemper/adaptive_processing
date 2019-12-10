% EXP_COV_MAT Generates a exponential covariance matrix
%
% Developer:    Daniel Kohkemper
% Date:         December, 2019
% *************************************************************************
function mat = exp_cov_mat(ro, sigma, dim)

    % Create matrix of dimension dim
    mat = zeros(dim, dim); 
    % Fill matrix with values
    for i = 1 : dim
        for j = 1 : dim
            mat(i,j) = ro^(abs(i-j));
        end        
    end
    % Multiply matrix times sigma squared
    mat = mat * sigma^2;
end