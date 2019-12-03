% Reduced rank wiener filter using IQMD algorithm
function [T, err] = rrwf_iqmd(r, Rxx, Ryx)
  % Problem: 
  %  Trrwff = Aopt*Bopt
  %  Variable rank, r
  
  % RRWF computation
  [A, B] = iqmd(r, Rxx, Ryx); % IQMD implementation
  T = A * ctranspose(B);      % RRWF
  
  % Error calculation
  lambda = eig(T);                     % Eigenvalues
  err = trace(Rxx) - sum(lambda(1:r)); % Error value
end