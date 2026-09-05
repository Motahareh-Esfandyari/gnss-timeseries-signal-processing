%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : LS_H.m
%  Purpose : Driver script: runs LS-HE on a detrended station series and
%            plots the power spectrum.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc; clear; close all; format long g;

load GNSS_Analysis2_P242
load GNSS_Analysis__deterended2_P242

y = xt;
sample = 0.0027 ; Alpha = 0.01 ;

T1(1, :) = 2 * sample ; m = length(xt) ;
TT = T(end) - T(1) ; j = 1 ; alpha = 0.5 ;
while T1(j, :) < TT
    T1(j + 1, :) = T1(j, :) * (1 + alpha*T1(j, :)/TT) ; j = j + 1 ;
end

T1(end, :) = [] ;

w = 2*pi./T1 ;
a = [ones(size(y, 1), 1), T] ; A = a ;
h = waitbar(0, 'Spectral values are being computed, please wait...') ;
for i = 1:size(w, 1)
    if rcond(A'*A) < 1e-2
        Aj = [cos(w(i, :)*T), sin(w(i, :)*T)] ;
        P(i, :) = NaN ;
    else
        PAo = eye(m) - A*(A'*A)^(-1)*A' ; ecap0 = PAo*y ;
        Aj = [cos(w(i, :)*T), sin(w(i, :)*T)] ;
        P(i, :) = ecap0'*Aj*(Aj'*PAo*Aj)^(-1)*Aj'*ecap0 ;
    end
    waitbar(i/size(w, 1)) ;
end
close(h)

[idx, ~] = find(isnan(P)==1) ; P(idx, :) = [] ; T1(idx, :) = [] ;

P_sort = sort(P) ; [~, IDX] = ismember(P_sort, P) ;
w2 = w(IDX) ; T_sort = T1(IDX) ;

AA = A ; DW = [] ; DT = [] ; i = 1 ;
h = waitbar(0, 'Signal detection is in proccesing, please wait...') ;
for kk = 1:size(w, 1)
    k = size(w, 1) - kk + 1 ;
    Ak = [cos(w2(k, :)*T), sin(w2(k, :)*T)] ;
    if rcond([A, Ak]'*[A, Ak]) < 1e-15
        A = A ;
    else
        [m, n] = size(A) ;
        PAo  = eye(m) - A*(A'*A)^(-1)*A' ; ecap_0 = PAo*y ;
        PAko = eye(m) - [A, Ak]*([A, Ak]'*[A, Ak])^(-1)*[A, Ak]' ;
        ecap_a = PAko*y ;
        sigcap_a = ecap_a'*ecap_a/(m - n - 2) ;
        T2(i, :) = ecap_0'*Ak*(Ak'*PAo*Ak)^(-1)*Ak'*ecap_0/...
            (2*sigcap_a);
        F(i, :) = finv(1-Alpha/2, 2, m - n - 2) ;
        if T2(i) > F(i)
            A = [A, Ak] ;
            DW = [DW; w2(k, :)] ; DT = [DT; T_sort(k, :)] ;%break
        end
         i = i + 1 ;
    end
    waitbar(kk/size(w, 1))
end
close(h)
xcap = inv(A'*A)*A'*y ;
ycap = A*xcap ;
