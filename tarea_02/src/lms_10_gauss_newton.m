% LMS_10_GAUSS_NEWTON
%   [K, W_VEC] = lms_10_gauss_newton(D_VAR, U_VEC, W_INIT, TOL, ITER_MAX) solves problem
%   min_{w}E[|d-uw|^{2}]
%   
%   d_var:    random variable
%   u_vec:    random row vector size 1xn
%   w_init:   initial w vector w^{(-1)}
%   alpha:    alpha small factor (0 < alpha < 0.1)
%   epsilon:  regularizaton parameter
%   lambda:   forgetting factor
%   mu:       step-size constant
%   tol:      tolerance
%   iter_max: max number of iterations
%
%   idx_k:    number of iterations achieved
%   w_vector: constant column vector size nx1
%   error_vec:    approximation error
%   min_val_vec:  approximated minimum value
%
% *************************************************************************
function [idx_k, w_vector, error_vec, min_val_vec] = lms_10_gauss_newton(d_var, u_vec, w_init, alpha, epsilon, lambda, mu, tol, iter_max)
    % Init constants
    [s, n] = size(u_vec);
    lambda_1 = lambda^-1;
    P_1 = (epsilon^-1)*eye(n);
    % Init w_vector
    w_vector = w_init;
    % Init P matrix
    P_matrix = P_1;
    % Declare output vectors
    error_vec   = [];
    min_val_vec = [];
    
    for idx_k = 1 : s
        % Calculate estimation (a-posteriori) error
        e_i = (d_var(idx_k) - u_vec(idx_k, :) * w_vector);
        % Calculate P matrix
        P_sub  = (lambda_1 * P_matrix * ctranspose(u_vec(idx_k, :)) * u_vec(idx_k, :) * P_matrix) / ...
                 ((1 - alpha)/alpha + lambda_1 * u_vec(idx_k, :) * P_matrix * ctranspose(u_vec(idx_k, :)));
        P_next = (lambda_1/1 - alpha)*(P_matrix - P_sub);
        % Calculate w vector
        w_next = w_vector + mu * P_next * ctranspose(u_vec(idx_k, :)) * e_i;
        % Calculate error e_{k} = ||w^{k} - w^{k-1}||_2
        error_val = norm(w_next - w_vector);
        error_vec = [error_vec, error_val];
        % Calculate min_value
        R_dk_dk = d_var(idx_k) * ctranspose(d_var(idx_k));
        R_dk_uk = d_var(idx_k) * ctranspose(u_vec(idx_k, :));
        R_uk_uk = ctranspose(u_vec(idx_k, :)) * u_vec(idx_k, :);
        min_val = R_dk_dk - ...
                  ctranspose(R_dk_uk)  * w_vector - ...
                  ctranspose(w_vector) * R_dk_uk + ...
                  ctranspose(w_vector) * R_uk_uk * w_vector;
        % Append min_val to output vector
        min_val_vec = [min_val_vec, min_val];

        % Update P matrix
        P_matrix = P_next;
        % Update w vector
        w_vector = w_next;

        % Break if tolerance is reached (||w^{k} - w^{k-1}||_2 < tol)
        if(error_vec(end) < tol)
            fprintf('Tolerance reached (error=%d < tol=%d)\n', error_val, tol);
            fprintf('Num of iterations: %d\n', idx_k);
            fprintf('Min value: %d\n', min_val);
            w_vector
            break;
        end
        % Break loop if max iteration number is reached
        if(idx_k == iter_max)
            fprintf('Max iterations reached (%d = %d)\n', idx_k, iter_max);
            fprintf('Min value: %d\n', min_val);
            fprintf('Error: %d\n', error_val);
            w_vector
            break
        end
    end
end