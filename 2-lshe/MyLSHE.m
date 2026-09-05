%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Function: MyLSHE.m
%  Purpose : LS-HE variant with a user-supplied covariance matrix Qy,
%            returns the detected frequencies/periods and the spectrum.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

function [DW, DT, T, P] = MyLSHE(t1, xt, Qy, sample)
T(1, :) = 2 * sample ; m = length(xt) ;
TT = t1(end) - t1(1) ; j = 1 ; alpha = 0.1 ;
while T(j, :) < TT
    T(j + 1, :) = T(j, :) * (1 + alpha*T(j, :)/TT) ; j = j + 1 ;
end

T(end, :) = [] ;

w = 2*pi./T ;
a = [ones(size(xt, 1), 1), t1] ;
h = waitbar(0, 'Spectral values are being computed, please wait...') ;
for i = 1:size(w, 1)
        PAo = eye(m) - a*(a'*Qy^(-1)*a)^(-1)*a'*Qy^(-1) ; ecap0 = PAo*xt ;
        Aj = [cos(w(i, :)*t1), sin(w(i, :)*t1)] ;
        P(i, :) = ecap0'*Qy^(-1)*Aj*(Aj'*Qy^(-1)*PAo*Aj)^(-1)*Aj'*Qy^(-1)*ecap0 ;
     waitbar(i/size(w, 1)) ;
end
close(h)

P_sort = sort(P) ; [~, IDX] = ismember(P_sort, P) ;
w2 = w(IDX) ; T_sort = T(IDX) ;

AA = a ; DW = [] ; DT = [] ; i = 1 ;
h = waitbar(0, 'Signal detection is in proccesing, please wait...') ;
for kk = 1:size(w, 1)
        [m, n] = size(a) ;
        PAo  = eye(m) - a*(a'*Qy^(-1)*a)^(-1)*a'*Qy^(-1) ; ecap_0 = PAo*xt ;
        PAko = eye(m) - [a, Ak]*([a, Ak]'*Qy^(-1)*[a, Ak])^(-1)*[a, Ak]'*Qy^(-1) ;
        ecap_a = PAko*xt ;
        sigcap_a = ecap_a'*Qy^(-1)*ecap_a/(m - n - 2) ;
        T2(i, :) = ecap_0'*Qy^(-1)*Ak*(Ak'*Qy^(-1)*PAo*Ak)^(-1)*Ak'*Qy^(-1)*ecap_0/...
            (2*sigcap_a);
        F(i, :) = finv(1-0.01/2, 2, m - n - 2) ;
        if T2(i) > F(i)
            a = [a, Ak] ;
            DW = [DW; w2(k, :)] ; DT = [DT; T_sort(k, :)] ;%break
        end
         i = i + 1 ;

    waitbar(kk/size(w, 1))
end
close(h)

end
