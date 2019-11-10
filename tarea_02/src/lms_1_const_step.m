% LMS_1_CONST_STEP 
%   [K, W_VEC] = lms_1_const_step(D_VAR, U_VEC, W_INIT, TOL, ITER_MAX) solves problem
%   min_{w}E[|d-uw|^{2}]
%   
%   d_var:    random variable
%   u_vec:    random row vector size 1xn
%   w_init:   initial w vector w^{(-1)}
%   tol:      tolerance
%   iter_max: max number of iterations
%
%   idx_k:    number of iterations achieved
%   w_vector: constant column vector size nx1
%   error:    approximation error
%   min_val:  approximated minimum value
%
% *************************************************************************
function [idx_k, w_vector, error, min_val] = lms_1_const_step(d_var, u_vec, w_init_vec, tol, iter_max)
    
    % TODO: Delete, put here just to avoid messages 
    d_var      = d_var;
    u_vec      = u_vec;
    w_init_vec = w_init_vec;
    tol        = tol;
    iter_max   = iter_max;
    
    % TIP: Use (||w^{k} - w^{k-1}||_2 < tol) or (idx_k == iter_max) to stop algorithm
    
    % TODO:
    % Calculate error: e_{k} = ||w^{k} - w^{k-1}||_2
    % Calculate min value
    
    % Output variables
    idx_k    = 0;
    w_vector = [];
    error    = 0;
    min_val  = 0;
end