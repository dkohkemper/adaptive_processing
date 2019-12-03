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
R = 20;
m = 100;
n = m;
x = rand(m,1);
v = randn(n,1);
y = x + v;

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
#F = rand(m,n);
tol = 1e-05;
err_data = [];
Rxy = Rxx; % orthogonal
Ryx = Rxy';
Ryy = Rxx + 0.75*Rvv; % orthogonal

% 4) RRWF using SVD
R0 = sqrtm(Ryy);           % Rxx^(1/2)
R1 = pinv(R0);             % Rxx^(-1/2)
R2 = Rxy * R1';            % Ryx*(Rxx^(-1/2))^H

for r=1:R
  % RRWF computation
  [U, S, V] = svd(R2);       % Singular Value Descomposition (trun-r)
  Ur        = U(:,1:r);      % U: matrix of r-columns
  Sr        = S(1:r,1:r);    % S: matrix rxr
  Vr        = V(:,1:r);      % V: matrix r-columns
  trunr_R2  = Ur*Sr*Vr';     % trun-r{Ryx*Rxx^(-1/2)^H} 
  F         = trunr_R2 * R1; % RRWF
  
  % Error calculation
  sing_val = diag(Sr);                     % Eigenvalues
  err = trace(Rxx) - sum(sing_val(1:r)); % Error value
  err_data  = [err_data, err];
end
err

% 5) Results: rank vs error plot for both RRWF approaches
figure(1);
plot(1:r, err_data);
title('RRWF filter - Rank vs Error');
grid on;


% 2) Build covariance matrix Rxy
% Rxy = E[xy^H] (mxn)
#ExyH = x*y';
#for i=1:m
#  for j=1:n
#    Rxy(i,j) = mean(ExyH(i,j));
#  end
#end

% 3) Build covariance matrix Ryy
% Ryy = E[yy^H] (mxn)
#EyyH = y*y';
#for i=1:m
#  for j=1:n
#    Ryy(i,j) = mean(EyyH(i,j));
#  end
#end


% 4) Optimum filter
#tol = 1e-05;
#err_data = [];
#F0 = rand(m,n);

#for k=1:iterMax
#  F = Rxy*pinv(Ryy);
#  err = norm(F - F0);
#  err_data = [err_data, err];
#  if(err_data(end) < tol)
#    break;
#  end
#end