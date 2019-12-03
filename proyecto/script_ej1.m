# Tecnológico de Costa Rica
# Escuela de Ingeniería Electrónica
# Maestría científica con enfásis en Procesamiento Digital de Señales
# 
# Métodos matemáticos para PDS
# Tarea 4
#
# Ing. Fabricio Quirós Corella
#

#RRWF (Reduced Rank Wiener filter)
% 'mxn' matrix Trrwf;
% pre-specified rank 'r';
% r: minimizes the following distance
% y(mx1): senhal de entrada
% x(nx1): senhal reconstruida
% signal;
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


% Preguntas: paper 1
#2. Empleando el k-esimo valor de las matrices A y B, esto se refiere a la k-esima fila o columna?
%Aunque se sabe que A(mxr) y B(nxr), entonces deberia ser for k=1:r (??).
#1. T(0) hace referencia al filtro de Wiener propiamente, en su valor inicial? 

#T(0) matriz aleatoria de full-rank r < min(m,n) (como especifica) el articulo
#A(k) se refiera a la k-esima matriz
#Matrices unitarias: U'U = UU' = I

clc
clear all
close all

%Filtro de Wiener de rango reducido empleando el algoritmo IQMD

% Matriz de covarianza Eyy
M = 20; % filas
N = M; % columnas
L = N; % tamaño identidad
for i=1:M
  for j=1:N
    if (i == j)
      Eyy(i,j) = 1;
    else
      Eyy(i,j) = 0.5;
    end
  end
end

%Matriz de covarianza Exy
Exy = Eyy;
%Matriz de covarianza Eyx
Eyx = Exy';
%Matriz de covarianza Exx
sigma2 = 0.75;
Eee = eye(L);
Exx = Eyy + sigma2*Eee;

%Inicializacion
err = []; % Error asociado
err_dir = []; % Error asociado
err_iqmd = []; % Error asociado

% Rango variable
for r=1:L
  % RRWF mediante el calculo directo para r = 1,2,...,L
  [Tdir, err_tmp_dir] = rrwf(r, Exx, Eyx);
  % RRWF mediante el algoritmo IQMD 
  [Tiqmd, err_tmp_iqmd] = rrwf_iqmd(L, Exx, Eyx); %para r = 20
  err_tmp = abs(norm(Tdir) - norm(Tiqmd)/norm(Tdir));
  % Error
  err_dir = [err_dir, err_tmp_dir];
  err_iqmd = [err_iqmd, err_tmp_iqmd];
  err = [err_tmp, err];
end
%Grafico r vs error
figure(1);
plot(1:L, err_dir);
title('RRWF directo - Rango "r" vs Error');
grid on;

figure(2);
plot(1:L, err_iqmd);
title('RRWF IQMD - Rango "r" vs Error');
grid on;

figure(3);
plot(1:L, err);
title('Rango "r" vs Error');
grid on;

  
