% RRWF IQMD approach

%
% Problem:
%       A(k+1)*(B'(k)*Rxx*B(k)) = Ryx*B(k)
%      (A'(k+1)*A(k+1))*B'(k+1)*Rxx = A'(k+1)Ryx
%

%
% Overview: Computing reduced rank Wiener filter using
% Iterative quadratic minimum distance (IQMD) algorithm
%
% Author: Eng. Fabricio Quiros-Corella
%


function [err, T] = iqmd(r, Ryx, Rxx)
  % Initial computation
  Ryy = Ryx;
  Rxy = Ryx';
  R0 = pinv(Rxx);            % Rxx^(-1)
  R1 = sqrtm(R0);            % Rxx^(-1/2)
  R2 = Ryx * R1;             % Ryx*(Rxx^(-1/2))
  [U, S, V] = svd(R2);       % Singular Value Descomposition (trun-r)
  Vr = V(:,1:r);             % V: matrix r-columns
  T0 = rand(r);              % T(0): full-rank matrix
  
  % Initial condition
  B0 = R1*Vr*T0;
  
  % Initial values
  A  = 0;
  B  = B0;
  
  % Iteration number
  K = 10;
  for k=1:K
    % Aopt calculation
    B1 = Ryx * B;
    B2 = B' * Rxx * B;
    A  = B1 * pinv(B2);              % Ak  = Ryx B(k-1) [B(k-1)^H Rxx B(k-1)]^-1
    % Bopt calculation
    A1 = A' * A;
    A2 = A' * Ryx;
    BH  = pinv(A1) * A2 * pinv(Rxx); % Bk^H = (Ak^H Ak)^-1 (Ak^H Ryx) (Rxx)^-1
    B = BH';
  end
  T = A * BH; % RRWF
  
  % Error calculation
  err = abs(trace(Ryy - (Ryx*T') - (T*Rxy) + (T*Rxx*T')));
endfunction