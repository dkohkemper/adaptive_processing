% Example 2 - RRWF using IQMD

%
% Problem:   min   E[|y - Tx|^2] ; rank(F) <= r < min(m,n)
%           F(mxn)

%
% Overview: Application script which computes the Reduced-Rank Wiener Filter
% (RRWF), using the IQMD algorithm with a fixed rank value, to recover a noised
% audio signal already known.
%
% Author: Eng. Fabricio Quiros-Corella
%


% 1) Variables definition
% y(mx1): reference audio signal (i-index)
% x(nx1): poluted saudio ignal (j-index)
% v(nx1): random white noise signal
% T: RRWF
% Tx: reconstructed or estimated audio signal
% R: full-rank fixed
clc
clear all
close all

% 2) Audio pre-processing
audio = 'smoke_on_the_water_sample.wav';
ch1   = 'smoke_on_the_water_left_ch.wav';
pol   = 'smoke_on_the_water_poluted.wav';
rec1  = 'smoke_on_the_water_recovered_1.wav';
rec2  = 'smoke_on_the_water_recovered_2.wav';
[y, fs] = audioread(audio);
factor = 2;                       % Audio processing factor in order to extract
l = length(y) / factor;           % only certain amount of audio samples from
y = y(1:l,1);                     % left audio channel.
audiowrite(ch1, y, fs);           % Create wav file of left audio channel signal

% 3) Algorithm initialization
err_opt = [];
err_aprox = [];
s = 100*factor;                        % No. of samples for vector matrix
m = l/s;
n = m;
R = min(m,s);

% 4) Y(mxs): reference vector samples matrix
i = 1;
for j=1:s
  Y(:,j) = y(i:j*m,1);
  i = j*m + 1;
end

% 5) X(nxs): noised vector samples matrix
V = randn(n,s);                        % V(nxs): random white noise matrix
X = Y + V;                             % Eq. 23 on written report
i = 1;
for j=1:s                              % y(nx1): poluted audio signal
  x(i:j*n,1) = X(:,j);
  i = j*n + 1;
end
audiowrite(pol, x, fs);                % Create wav file of noised audio signal

% 6) Covariance matrix aproximation: Ryx, Rxy and Rxx
Ryx = (1/s)*(Y*X');                    % Eq. 3 on written report
Rxx = (1/s)*(X*X');                    % Eq. 4 on written report


% 5) RRWF optimal filter
% Fixed rank computation
[err_rrwf, Trrwf] = rrwf(R, Ryx, Rxx); % Eq. 9 on written report

% Reference error
err_opt = [err_opt, err_rrwf];         % Eq. 20 on written report


% 6) RWWF IQMD-approximated filter
% Fixed rank computation
[err_iqmd, Tiqmd] = iqmd(R, Ryx, Rxx); % Eq. 12-13-14-15 on written report

% Error of interest
err_aprox  = [err_aprox, err_iqmd];


% 7) Audio RRWF filtering: estimation matrix
Y1 = Trrwf*X;                          % Eq. 22 on written report
Y2 = Tiqmd*X;                          % Eq. 22 on written report

% 8) Reconstructed audio reference signal
i = 1;
for j=1:s
  y1(i:j*m,1) = Y1(:,j);
  y2(i:j*m,1) = Y2(:,j);
  i = j*m + 1;
end
audiowrite(rec1, y1, fs);              % Create audio file of retrieved signals
audiowrite(rec2, y2, fs);

% 9) Results: final error values
fprintf('Optimal Reference RRWF approach -  Error value: %d\n', err_opt(end));
fprintf('      IQMD RRWF approach        -  Error value: %d\n', err_aprox(end));

% 10) Results: original audio signal
figure(1);
plot(1:length(y), y');
title('Smoke on the water WAV file - reference audio signal');
xlabel('time-index');
ylabel('sample value');
grid on;

% 11) Results: synthesized audio signal - Optimum Reference RRWF approach
figure(2);
plot(1:length(y1), y1');
title('RRWF optimal filter - synthesized audio signal');
xlabel('time-index');
ylabel('sample value');
grid on;

% 12) Results: synthesized audio signal - IQMD RRWF approach
figure(3);
plot(1:length(y2), y2');
title('RRWF IQMD-approximated filter - synthesized audio signal');
xlabel('time-index');
ylabel('sample value');
grid on;