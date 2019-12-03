% Reduced rank wiener filter using SVD directly
function [T, err] = rrwf(r, Rxx, Ryx)
  % Problem: 
  %  Trrwff = trun-r{R1}*R0
  %  Variable rank, r
  
  % Initial computation
  R0 = sqrtm(Rxx);           % Rxx^(1/2)
  R1 = pinv(R0);             % Rxx^(-1/2)
  R2 = Ryx * R1';            % Ryx*(Rxx^(-1/2))^H
  
  % RRWF computation
  [U, S, V] = svd(R2);       % Singular Value Descomposition (trun-r)
  Ur        = U(:,1:r);      % U: matrix of r-columns
  Sr        = S(1:r,1:r);    % S: matrix rxr
  Vr        = V(:,1:r);      % V: matrix r-columns
  trunr_R2  = Ur*Sr*Vr';     % trun-r{Ryx*Rxx^(-1/2)^H} 
  T         = trunr_R2 * R1; % RRWF
  
  % Error calculation
  lambda = eig(T);                     % Eigenvalues
  err = trace(Rxx) - sum(lambda(1:r)); % Error value
end
