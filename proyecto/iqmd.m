% IQMD algorithm
function [A, B] = iqmd(r, Rxx, Ryx)
  % Problem: Iterative quadratic minimum distance
  %  A(k+1)*(B'(k)*Rxx*B(k)) = Ryx*B(k)
  %  (A'(k+1)*A(k+1))*B'(k+1)*Rxx = A'(k+1)Ryx
  
  % Initial computation
  R0 = sqrtm(Rxx);           % Rxx^(1/2)
  R1 = pinv(R0);             % Rxx^(-1/2)
  
  % Note: if a full-rank matrix is computed, its rank equals to columns number
  #VT0 = rand(r); % Full-rank random matrix
  #B0  = R1 * VT0;
  B0  = rand(r);
  
  % Initial values
  A  = 0;
  B  = B0;
  
  % Set a high value to K to ensure convergence of RRWF
  K = 1000;
  for k=1:K
    % Aopt calculation
    B1 = Ryx * B;
    B2 = ctranspose(B) * Rxx * B;
    A  = B1 * pinv(B2);
    % Bopt calculation
    A1 = ctranspose(A) * A;
    A2 = ctranspose(A) * Ryx;
    B  = ctranspose(pinv(A1) * A2 * pinv(Rxx));
  end
endfunction