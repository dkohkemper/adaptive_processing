%TRIADIAG_MAT Generate random triadiagonal matrix
%
% Developer:    Daniel Kohkemper
% Date:         December, 2019
% *************************************************************************
function mat = triadiag_mat(size)

    % Initialize matrix with zeros
    mat = zeros(size);
    
    for i = 1 : size
        for j = 1 : size
            % assign value to diagonal
            if (i == j)
                mat(i, j) = randn;
                
                if(j < size)
                    mat(i, j + 1) = randn;
                end
                
                if (i < size)
                   mat(i + 1, j) = rand;
                    break;
                end
            end            
        end
    end
    


end

