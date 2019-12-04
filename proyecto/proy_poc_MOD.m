clc
clear all
close all

% Proof of concept - RRWF
%
% Problem:   min   E[|x - Fy|^2] ; rank(F) <= r < min(m,n)
%           F(mxn)

% 1) Variables definition
% iterMax: maximum number of iterations
% x(mx1): target signal (i-index)
% v(nx1): random noise (j-index)
% y(nx1): observation, reference signal 
% F: RRWF
% Fy: reconstructed signal, estimation
% r: pre-defined rank
m = 100;
n = m;

% 2) Build covariance matrix Rvv and Rvv
Rvv = eye(n);
for i=1:m
  for j=1:n
    if i == j
      Rxx(i,j) = 1;
    else
      Rxx(i,j) = 0.5;
    end
  end
end


% 3) Initial computation
err_data = [];
Rxy = Rxx; % orthogonal
Ryx = Rxy';
Ryy = Rxx + 0.1*Rvv; % orthogonal

% 4) RRWF using SVD
R0 = pinv(Ryy);           % Rxx^(1/2)
R1 = sqrtm(R0);             % Rxx^(-1/2)
R2 = Rxy * R1';            % Ryx*(Rxx^(-1/2))^H
[U, S, V] = svd(R2);       % Singular Value Descomposition (trun-r)
  
for r=1:m
  % RRWF computation

  Ur        = U(:,1:r);      % U: matrix of r-columns
  Sr        = S(1:r,1:r);    % S: matrix rxr
  Vr        = V(:,1:r);      % V: matrix r-columns
  trunr_R2  = Ur*Sr*Vr';     % trun-r{Ryx*Rxx^(-1/2)^H} 
  F         = trunr_R2 * R1; % RRWF
  
  % Error calculation
  sing_val = diag(Sr)                     % Eigenvalues
  err = trace(Rxx) - sum(sing_val); % Error value
  err_data  = [err_data, err];
end


% 5) Results: rank vs error plot for both RRWF approaches
figure(1);
plot(1:r, err_data);
title('RRWF filter - Rank vs Error');
grid on;


