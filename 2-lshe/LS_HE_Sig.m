%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Function: LS_HE_Sig.m
%  Purpose : LS-HE variant evaluating a fixed set of candidate periods,
%            used for the significance tests in the paper.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

function [DW, DT, T2, P] = LS_HE_Sig(t1, xt, Qy, sample)

m = length(xt) ;
Tn(1, :) = 2 * mean(diff(t1)) ;
TT = t1(end) - t1(1) ; j = 1 ; alpha = 0.1 ;
while Tn(j, :) < TT
    Tn(j + 1, :) = Tn(j, :) * (1 + alpha*Tn(j, :)/TT) ; j = j + 1 ;
end

Tn(end, :) = [] ;

w = 2*pi./Tn ;
a = [ones(size(xt, 1), 1), t1] ;
invA = a'; invQ = Qy^(-1);
stimp = inv(invA*invQ*a);
for i = 1:size(w, 1)
    if rcond(invA*invQ*a) < 1e-20
        Aj = [cos(w(i, :)*t1), sin(w(i, :)*t1)] ;
        P(i, :) = NaN ;
    else
        PAo = eye(m) - a*stimp*invA*invQ ;
        ecap0 = PAo*xt ;
        Aj = [cos(w(i, :)*t1), sin(w(i, :)*t1)] ;
        P(i, :) = ecap0'*invQ*Aj*(Aj'*invQ*PAo*Aj)^(-1)*Aj'*invQ*ecap0 ;
    end

end

[idx, ~] = find(isnan(P)==1) ;
P(idx, :) = [] ;
T(idx, :) = [] ;
P_sort = sort(P) ; [~, IDX] = ismember(P_sort, P) ;
w2 = w(IDX) ; T_sort = Tn(IDX) ;

 AA= a;
 DW = [] ; DT = [] ; i = 1 ;

for kk = 1:size(w, 1)
    k = size(w, 1) - kk + 1 ;
    Ak = [cos(w2(k, :)*t1), sin(w2(k, :)*t1)] ;
    if rcond([a, Ak]'*invQ*[a, Ak]) < 1e-15
        a = a ;
    else
        [m, n] = size(a) ;
        PAo  = eye(m) - a*inv(invA*invQ*a)*invA*invQ ;
        ecap_0 = PAo*xt ;
        PAko = eye(m) - [a, Ak]*([a, Ak]'*invQ*[a, Ak])^(-1)*[a, Ak]'*invQ ;
        ecap_a = PAko*xt ;
        sigcap_a = ecap_a'*invQ*ecap_a/(m - n - 2) ;
        T2(i, :) = ecap_0'*invQ*Ak*(Ak'*invQ*PAo*Ak)^(-1)*Ak'*invQ*ecap_0/...
            (2*sigcap_a);
        F(i, :) = finv(1-0.01/2, 2, m - n - 2) ;

        if T2(i) > F(i)

            a = [a, Ak] ;
            DW = [DW; w2(k, :)] ; DT = [DT; T_sort(k, :)] ;%break
        end
         i = i + 1 ;
    end

end

 end
