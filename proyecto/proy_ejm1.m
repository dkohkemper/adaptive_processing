# Tecnológico de Costa Rica
# Escuela de Ingeniería Electrónica
# Maestría científica con enfásis en Procesamiento Digital de Señales
# 
# Procesamiento Adaptativo
# Proyecto Final
#
# Ing. Fabricio Quirós Corella
#

#################### RRWF (Reduced Rank Wiener filter) #########################
% 'mxn' matrix Trrwf;
% pre-specified rank 'r';
% r: minimizes the following distance
% y(mx1): input signal
% x(nx1): reconstructed signal
%
%       Jrrwf(T) = E{norm(y-Tx,2)^2}
%
% E: statistical expectaction;
% r < min(m,n);
%
%       Trrwf = trun-r{RyxRxx^-1/2^H}Rxx^-1/2
%
% ^H: conjugate transpose;
% E{xx}: convariance matrix;
% E{yx}: covariance matrix;
% Rxx = E{xx^H}; Ryx = E{xy^H};
% trun-r: rank-r SVD truncation;
% Rxx^-1/2: pinv(Rxx^1/2);
%
#IQMD Algorithm
% rank-r matrix T -> AB^H; 
% A(mxr): reconstruction matrix
% B(nxr): compression matrix
%
%       Jrrwf(A,B) = E{norm(y-AB^H*x,2)^2}
%       Trrwf = AoptBopt^H
% B(k) of Bopt
% A(k+1) of Aopt is obtained by
% minimizing Jrrwf(A,B) with respecto to B;
% Given A(k+1), the new estimate B(k+1)
% is obtained by minimizing Jrrwf(A,B) with
% respect to B;
% EQUATIONS:
% Init conditions: B(0)
% (1)
% A(k+1)(B^H(k)RxxB(k)) = RyxB(k)
% (2)
% (A^H(k+1)A(k+1))B^H(k+1)Rxx = A^H(k+1)Ryx
%
% ->Globally and exponentially convergent
% to the RRWF;
% SVD of RyxRxx^-1/2;

% T = AoptBopt^H

% y: 'mx1' reference signal 
% x: 'nx1' reconstructed signal
% s: samples; more samples, better aprox Exx, less error
% T-RRWF: 'mxn' matrix that minimizes the distance between y-x
################################################################################

clc
clear all
close all

% Reduced-rank Wiener filter using IQMD algorithm

% 1) Input parameters
% y(mx1): reference signal
% x(nx1): reconstructed signal 
y      = ctranspose(csvread("y.csv"));  % known-vector, stored in CSV file (index-k)
size(y) % Result verification
s      = 25;                % extract certain number of observations (samples)
y      = y(1:s);
size(y) % Result verification
m      = length(y);
n      = m;                 % IQMD implementation assumes n = m (square matrix)
#n      = 50;               % Result verification
x      = randn(n,1);        % normal distribution random signal (index-j)
% Note: reconstructed signal x, has zero mean and variance one
size(x) % Result verification


% 2) Build covariance matrix Rxx
% Rxx = E[xx^H] (mxn)
#for j=1:n
#  for k=1:m
#    Rxx(j,k) = mean(x(k)*x(j));
#  end
#end
Rxx = (1/s)*(x*ctranspose(x));
size(Rxx) % Result verification

% 3) Build covariance matrix Ryx
% Ryx = E[yx^H] (mxn)
#Ryx = mean(y.*ctranspose(x));
#for j=1:n
#  for k=1:m
#    Ryx(j,k) = mean(y(k)*x(j));
#  end
#end
Ryx = (1/s)*(y*ctranspose(x));
size(Ryx) % Result verification


% 4) RRWF via direct calculation
% Trrwf = trun-r{Ryx Rxx^-1/2^H} Rxx^-1/2
err = 1;
tol = 1e-05;
err_dir = []; % Direct cal. error
r = 0; % Variable rank
while (r < min(m,n))
  r=r+1;
  [Tdir, err] = rrwf(r, Rxx, Ryx);
  err 
  err_dir = [err_dir, err];
end

% 5) RRWF via IQMD calculation
% Trrwf = AoptBopt^H
#err_iqmd  = []; % IQMD cal. error
#R = n;          % Pre-defined rank value
#for l=1:min(m,n)
#  [Tiqmd, err] = rrwf_iqmd(R, Rxx, Ryx);
#  err_iqmd = [err_iqmd, err];
#end

% 5) Results: rank vs error plot for both RRWF approaches
figure(1);
plot(1:r, err_dir);
title('RRWF directo - Rango "r" vs Error');
grid on;

#figure(2);
#plot(1:r, err_iqmd);
#title('RRWF IQMD - Rango "r" vs Error');
#grid on;