% Example 1 - RRWF using IQMD

%
% Problem:   min   E[|y - Tx|^2] ; rank(F) <= r < min(m,n)
%           F(mxn)

%
% Overview: Basic example script to demonstrate and verify the expected 
% functionality Reduced-Rank Wiener Filter (RRWF) using an IQMD algorithm, by
% evaluating different rank values and the associated error. 
%
% Author: Eng. Fabricio Quiros-Corella
%


% 1) Variables definition
% y(mx1): reference signal (i-index)
% x(nx1): poluted signal (j-index)
% v(nx1): random noise signal
% T: RRWF
% Tx: reconstructed or estimated signal
% r: variable rank
% R: full-rank fixed
% var_v: noise variance
clc
clear all
close all

% 2) Algorithm initialization
err_opt = [];
err_aprox = [];
m = 20;
n = m;
R = min(m,n);
var_v = 0.2;

% 3) Covariance matrix: Rvv and Ryy
Rvv = var_v*eye(n);                      % Eq. 16 on written report
for i=1:m                                % Eq. 17 on written report
  for j=1:n
    if i == j
      Ryy(i,j) = 1;
    else
      Ryy(i,j) = 0.5;
    end
  end
end

% 4) Convariance matrix: Ryx and Rxx
Ryx = Ryy;                               % Eq. 18 on written report
Rxx = Ryy + Rvv;                         % Eq. 19 on written report

% 5) RRWF optimal filter
for r=1:R
  % Variable rank computation
  [err_rrwf, Trrwf] = rrwf(r, Ryx, Rxx); % Eq. 9 on written report
  
  % Reference error
  err_opt = [err_opt, err_rrwf];         % Eq. 20 on written report
end

% 6) RWWF IQMD-approximated filter
for r=1:R
  % Variable rank computation
  [err_iqmd, Tiqmd] = iqmd(r, Ryx, Rxx); % Eq. 12-13-14-15 on written report
  
  % Error of interest
  err_aprox  = [err_aprox, err_iqmd];    % Eq. 21 on written report
end

% 7) Results: final error values
fprintf('Optimal Reference RRWF approach -  Error value: %d\n', err_opt(end));
fprintf('      IQMD RRWF approach        -  Error value: %d\n', err_aprox(end));

% 8) Results: rank vs error plot - Optimum Reference RRWF approach
figure(1);
plot(1:R, err_opt);
title('RRWF optimal filter - Rank vs Error');
xlabel('r');
ylabel('error_{opt}');
grid on;

% 9) Results: rank vs error plot - IQMD RRWF approach
figure(2);
plot(1:R, err_aprox);
title('RRWF IQMD-approximated filter - Rank vs Error');
xlabel('r');
ylabel('error_{aprox}');
grid on;