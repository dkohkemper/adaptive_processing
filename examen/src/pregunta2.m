% *************************************************************************
% Script that gives solution to problem:
%
%     min     E[|| s - B_1 C_1 x_1 - B_2 C_2 x_2 - ... - B_L C_L x_L||^2]
% B_1 ... B_L
% C_1 ... C_L
%
% Developers:   Daniel Kohkemper, Costa Rica Institute of Technology
%               Fabricio Quirós,  Ridgerun
% Date:         December, 2019
% *************************************************************************
clc;
clear;
fclose("all");

ro       = 0.4;
sigma    = 2;
dim      = 30;
tol      = 10^-4;
max_iter = 1000;
k        = 15;
k1       = k;
k2       = k;

% Generate s matrix
s_mat = rand(dim, dim);
% Generate s exponential covariance matrix
R_ss = exp_cov_mat(ro, sigma, dim);

% Generate v1 and v1 random vectors
v1_mat = rand(dim, 1);
v2_mat = rand(dim, 1);

% Generate v1 and v2 covariance matrixes
R_v1v1 = 0.25 * eye(dim);
R_v2v2 = 0.75 * eye(dim);

% Generate A1 and A2
A1_mat = triadiag_mat(dim);
A2_mat = triadiag_mat(dim);

% Generate random C_i and B_i initial matrixes
B1_mat = rand(dim, k1);
B2_mat = rand(dim, k2);
C1_mat = rand(k1, dim);
C2_mat = rand(k2, dim);

% Declare vectors
error_vec =[];
min_vec   =[];

% Initialize the covariance matrixes
R_x1x1 = A1_mat * R_ss * transpose(A1_mat) + R_v1v1;
R_x2x2 = A2_mat * R_ss * transpose(A2_mat) + R_v2v2;
R_x1x2 = A1_mat * R_ss * transpose(A2_mat);
R_x2x1 = A2_mat * R_ss * transpose(A1_mat);
R_sx1  = R_ss   * A1_mat';
R_sx2  = R_ss   * A2_mat';
R_x2s  = A2_mat * R_ss;

% Loop
for k = 1 : max_iter

    % Calculate aditional covariance matrixes
    mat1 = C2_mat' * (C2_mat * R_x2x2 * C2_mat')^(-1);
    mat2 = mat1 * C2_mat;
    R_ee = R_x1x1 - R_x1x2 * mat2 * R_x2x1;
    R_vv = R_ss   - R_sx2  * mat2 * R_x2s;
    R_ve = R_sx1  - R_sx2  * mat2 * R_x2x1;

    % Obtain eigenvalues matrix
    temp_mat = R_ve * R_ee^(-1) * R_ve';
    [u_vec, lambda] = eig(temp_mat);

    % Calculate initial values of B1, B2, C1, C2
    C1_mat_n = u_vec(: , 1:k1)' * R_ve * R_ee^(-1);
    C2_mat_n = u_vec(: , 1:k1)' * R_ve * R_ee^(-1);
    B1_mat_n = u_vec(: , 1:k1);
    B2_mat_n = (R_sx2 - B1_mat * C1_mat * R_x1x2) * mat1;

    % Calculate norms
    norm_B1 = frob_norm((B1_mat_n - B1_mat));
    norm_B2 = frob_norm((B2_mat_n - B2_mat));
    norm_C1 = frob_norm((C1_mat_n - C1_mat));
    norm_C2 = frob_norm((C2_mat_n - C2_mat));

    % Calculate total error
    tot_error = 0.25 * (norm_B1 + norm_B2 + norm_C1 + norm_C2);
    % Generate error vector
    error_vec = [error_vec, tot_error];

    % Update matrixes
    C1_mat = C1_mat_n;
    C2_mat = C2_mat_n;
    B1_mat = B1_mat_n;
    B2_mat = B2_mat_n;

    % Update covariance matrixes
    R_x1x1 = A1_mat * R_ss * A1_mat' + R_v1v1;
    R_x2x2 = A2_mat * R_ss * A2_mat' + R_v2v2;
    R_x1x2 = A1_mat * R_ss * A2_mat';
    R_x2x1 = A2_mat * R_ss * A1_mat';
    R_sx1  = R_ss   * A1_mat';
    R_sx2  = R_ss   * A2_mat';
    R_x2s  = A2_mat * R_ss;

    if tot_error < tol
        break
    end
end

tot_error

% Generate the following graphs
%   error vs iterations
%   min vs iterations
%   min vs k

figure(1);
plot(1:k, error_vec);
xlabel("Dimension m");
ylabel("General error e_k");
title("Test 1: Dimension m vs general error e_k")
