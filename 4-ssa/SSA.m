%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Function: SSA.m
%  Purpose : Singular Spectrum Analysis: trajectory matrix, SVD, principal
%            components, EOFs and BK lag-covariance (Broomhead and King,
%            1986).
%  ------------------------------------------------------------------------
%  Adapted and applied by : Motahareh Esfandyari-Kaloukan
%  Original implementation: Hamed Karimi (see credit below)
%  ========================================================================

function [r, A, E, L, Np, C_BK] = SSA(time, x, M)

%% SSA: Singular Spectrum Analysis:
% Input:
%   time: Time Argument Vector (Nx1)
%      x: Time Series i.e. Signal (Nx1)
%      M: Window Length (Scalar)
% Output:
%      r: SSA Modes (NxM)
%      A: Principal Components i.e. PCs
%      E: Empirical Orthogonal Functions
%      L: Eigen Values (From SVD)
%     Np: Row Length of the Trajectorry Matrix; Trajectory Matrix: X (Np x M)
%   C_BK: BK Lag-Covariance Matrix: Broomhead and King (1986)

%% Written by Hamed Karimi, M.Sc.
%  Scientific Assistant at Technical University of Munich (TUM)
%% START:
x = detrend(x) ;
N = length(x) ;
Np = N - M + 1 ;

for j = 1:M
    X(:, j) = x(j:Np+j-1) ;
end

C_BK = (1/Np)*X'*X ;
[E, L, ~] = svd(C_BK, 'econ') ;
A = X*E ;

t = 1:length(time) ;
t = t' ;

[idx1, ~] = find(t<=M-1 & t>=1   ) ;
[idx2, ~] = find(t<=Np  & t>=M   ) ;
[idx3, ~] = find(t<=N   & t>=Np+1) ;

h = waitbar(0, 'Reconstruction') ;
for k = 1:M
    for t = 1:N
        i1 = ismember(t, idx1) ;
        i2 = ismember(t, idx2) ;
        i3 = ismember(t, idx3) ;
        [~, idx] = find([i1, i2, i3]==1) ;
        switch idx
            case 1
                Mt = t ;
                Lt = 1 ;
                Ut = t ;
                r(t, k) =  (1/Mt)*[flip(A(t-Ut+1:t-Lt+1, k))]'*E(Lt:Ut, k) ;
            case 2
                Mt = M ;
                Lt = 1 ;
                Ut = M ;
                r(t, k) =  (1/Mt)*[flip(A(t-Ut+1:t-Lt+1, k))]'*E(Lt:Ut, k) ;
            case 3
                Mt = N-t+1 ;
                Lt = t-N+M ;
                Ut = M     ;
                r(t, k) =  (1/Mt)*[flip(A(t-Ut+1:t-Lt+1, k))]'*E(Lt:Ut, k) ;
        end
    end
    waitbar(k/M)
end
close(h)
end
