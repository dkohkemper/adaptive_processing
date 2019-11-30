% LMS_4_E_NLMS_POW_NORM
%   [K, W_VEC] = lms_4_e_nlms_pow_norm(D_VAR, U_VEC, W_INIT, MU, EPSILON, BETA, TOL, ITER_MAX) solves problem
%   min_{w}E[|d-uw|^{2}]
%
%   d_var:    random variable
%   u_vec:    random row vector size 1xn
%   w_init:   initial w vector w^{(-1)}
%   mu:       step-size constant
%   epsilon:  regularizaton parameter
%   beta:     scalar constant (0 < beta <= 1)
%   tol:      tolerance
%   iter_max: max number of iterations
%
%   idx_k:        number of iterations achieved
%   w_vector:     constant column vector size nx1
%   error_vec:    approximation error
%   min_val_vec:  approximated minimum value
%
% Developers:   Daniel Kohkemper, Costa Rica Institute of Technology
%               Fabricio Quirós,  Ridgerun
% Date:         November, 2019
% *************************************************************************
function [idx_k, w_vector, error_vec, min_val_vec] = ...
    lms_4_e_nlms_pow_norm(d_var, u_vec, w_init, mu, epsilon, beta, tol, iter_max)
    % Declare output vectors
    error_vec   = [];
    min_val_vec = [];
    % Init w_vector
    w_vector = w_init;
    % Init p_i
    p_i = 0;

    for idx_k = 1 : length(d_var)
        % Calculate estimation error
        e_i = (d_var(idx_k) - u_vec(idx_k, :) * w_vector);
        p_i = beta * p_i + (1 - beta) * norm(u_vec(idx_k, :))^2;
        factor = mu / (epsilon + p_i);
        % Calculate w vector
        w_next = w_vector + factor * ctranspose(u_vec(idx_k, :)) * e_i;
        % Calculate error e_{k} = ||w^{k} - w^{k-1}||_2
        error_val   = norm(w_next - w_vector);
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

        % Update w vector value
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
