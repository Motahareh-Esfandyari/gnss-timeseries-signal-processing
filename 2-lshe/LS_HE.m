%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Function: LS_HE.m
%  Purpose : Least-Squares Harmonic Estimation: spectrum + Fisher-test
%            signal detection (Amiri-Simkooei, 2007).
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

function [DW, DT, T, P] = LS_HE(t, y, Qy, sample)

T(1, :) = 2 * sample ; m = length(y) ;
TT = t(end) - t(1) ; j = 1 ; alpha = 0.1 ;
while T(j, :) < TT
    T(j + 1, :) = T(j, :) * (1 + alpha*T(j, :)/TT) ; j = j + 1 ;
end

T(end, :) = [] ;

w = 2*pi./T ;
a = [ones(size(y, 1), 1), t] ; A = a ;
h = waitbar(0, 'Spectral values are being computed, please wait...') ;
for i = 1:size(w, 1)
    if rcond(A'*Qy^(-1)*A) < 1e-20
        Aj = [cos(w(i, :)*t), sin(w(i, :)*t)] ;
        P(i, :) = NaN ;
    else
        PAo = eye(m) - A*(A'*Qy^(-1)*A)^(-1)*A'*Qy^(-1) ; ecap0 = PAo*y ;
        Aj = [cos(w(i, :)*t), sin(w(i, :)*t)] ;
        P(i, :) = ecap0'*Qy^(-1)*Aj*(Aj'*Qy^(-1)*PAo*Aj)^(-1)*Aj'*Qy^(-1)*ecap0 ;
    end
    waitbar(i/size(w, 1)) ;
end
close(h)

P_sort = sort(P) ; [~, IDX] = ismember(P_sort, P) ;
w2 = w(IDX) ; T_sort = T(IDX) ;

AA = A ; DW = [] ; DT = [] ; i = 1 ;
h = waitbar(0, 'Signal detection is in proccesing, please wait...') ;
for kk = 1:size(w, 1)
    k = size(w, 1) - kk + 1 ;
    Ak = [cos(w2(k, :)*t), sin(w2(k, :)*t)] ;
    if rcond([A, Ak]'*Qy^(-1)*[A, Ak]) < 1e-15
        A = A ;
    else
        [m, n] = size(A) ;
        PAo  = eye(m) - A*(A'*Qy^(-1)*A)^(-1)*A'*Qy^(-1) ; ecap_0 = PAo*y ;
        PAko = eye(m) - [A, Ak]*([A, Ak]'*Qy^(-1)*[A, Ak])^(-1)*[A, Ak]'*Qy^(-1) ;
        ecap_a = PAko*y ;
        sigcap_a = ecap_a'*Qy^(-1)*ecap_a/(m - n - 2) ;
        T2(i, :) = ecap_0'*Qy^(-1)*Ak*(Ak'*Qy^(-1)*PAo*Ak)^(-1)*Ak'*Qy^(-1)*ecap_0/...
            (2*sigcap_a);
        F(i, :) = finv(1-0.01/2, 2, m - n - 2) ;
        if T2(i) > F(i)
            A = [A, Ak] ;
            DW = [DW; w2(k, :)] ; DT = [DT; T_sort(k, :)] ;%break
        end
         i = i + 1 ;
    end
    waitbar(kk/size(w, 1))
end
close(h)

end
