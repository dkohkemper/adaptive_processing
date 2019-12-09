% RRWF base approach

%
% Problem:   Trrwff = trun-r{R1}*R0
%
%

%
% Overview: Reduced rank wiener filter using SVD directly, considering a
% variable rank as input of this function.
%
% Author: Eng. Fabricio Quiros-Corella
%


function [err, T] = rrwf(r, Ryx, Rxx)
  % Initial computation
  Ryy = Ryx;
  Rxy = Ryx';
  R0 = pinv(Rxx);            % Rxx^(-1)
  R1 = sqrtm(R0);            % Rxx^(-1/2)
  R2 = Ryx * R1';            % Ryx*(Rxx^(-1/2))^H
  [U, S, V] = svd(R2);       % Singular Value Descomposition (trun-r)
  
  % RRWF variable rank computation
  Ur        = U(:,1:r);      % U: matrix of r-columns
  Sr        = S(1:r,1:r);    % S: matrix rxr
  Vr        = V(:,1:r);      % V: matrix r-columns
  trunr_R2  = Ur*Sr*Vr';     % trun-r{Ryx*Rxx^(-1/2)^H} 
  T         = trunr_R2 * R1; % RRWF
  
  % Error calculation
  eigval = diag(Sr);
  err = abs(trace(Ryy) - sum(eigval)); % Error value
end
