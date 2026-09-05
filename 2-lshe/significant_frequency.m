%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : significant_frequency.m
%  Purpose : Detects the statistically significant frequencies of a
%            detrended station series and saves them per station.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc; clear; close all; format long g;

%% Reading data

load GNSS_Analysis__deterended_P242
xt = xt(1:3500);
 T = T(1:3500);

%% Noise estimation:

t1 = T;

m = length(xt);
w1 = 2*pi/365.25;
w2 = 2*w1;

Epsilon = 1e-2;

A = [ones(m,1) t1 sin(t1*w1) cos(t1*w2) sin(2*t1*w1) cos(2*t1*w2)];

Qw = WhiteNoise(m);
Qf = FlickerNoise(t1,m);

s0 = [1]';
Q(:,:,1)=Qw;
 Q(:,:,2)=Qf;

[scap, c, Error, N]=Linear_LS_VCE(s0, Q, Epsilon, xt, A);
p=length(s0); s=s0;
Qy = zeros(m);
    for k = 1:p
        Qy=Qy+s(k)*Q(:,:,k);
    end

clear T
%% Detect significant frequency

sample = 0.0027;
m = length(xt) ;
T(1, :) = 2 * mean(diff(t1)) ;
TT = t1(end) - t1(1) ; j = 1 ; alpha = 0.1 ;
while T(j, :) < TT
    T(j + 1, :) = T(j, :) * (1 + alpha*T(j, :)/TT) ; j = j + 1 ;
end

T(end, :) = [] ;

h = waitbar(0, 'Spectral values are being computed, please wait...') ;
w = 2*pi./T ;
a = [ones(size(xt, 1), 1), t1] ;
 invA = a'; invQ = Qy^(-1);
for i = 1:size(w, 1)
    if rcond(invA*invQ*a) < 1e-20
        Aj = [cos(w(i, :)*t1), sin(w(i, :)*t1)] ;
        P(i, :) = NaN ;
    else
        PAo = eye(m) - a*(a'*Qy^(-1)*a)^(-1)*a'*Qy^(-1) ;
        ecap0 = PAo*xt ;
        Aj = [cos(w(i, :)*t1), sin(w(i, :)*t1)] ;
        P(i, :) = ecap0'*Qy^(-1)*Aj*(Aj'*Qy^(-1)*PAo*Aj)^(-1)*Aj'*Qy^(-1)*ecap0 ;
    end
    waitbar(i/size(w, 1)) ;
end
close(h)
[idx, ~] = find(isnan(P)==1) ;
P(idx, :) = [] ;
T(idx, :) = [] ;
P_sort = sort(P) ; [~, IDX] = ismember(P_sort, P) ;
w2 = w(IDX) ; T_sort = T(IDX) ;

 AA= a;
 DW = [] ; DT = [] ; i = 1 ;
h = waitbar(0, 'Signal detection is in proccesing, please wait...') ;
for kk = 1:size(w, 1)
    k = size(w, 1) - kk + 1 ;
    Ak = [cos(w2(k, :)*t1), sin(w2(k, :)*t1)] ;
    if rcond([a, Ak]'*invQ*[a, Ak]) < 1e-15
        a = a ;
    else
        PAo  = eye(m) - a*(a'*Qy^(-1)*a).^(-1)*a'*Qy^(-1) ;
        ecap_0 = PAo*xt ;
        PAko = eye(m) - [a, Ak]*([a, Ak]'*invQ*[a, Ak])^(-1)*[a, Ak]'*Qy^(-1);
        ecap_a = PAko*xt ;
        [m, n] = size(a) ;
        sigcap_a = ecap_a'*Qy^(-1)*ecap_a/(m - n - 2) ;
        T2(i, :) = ecap_0'*Qy^(-1)*Ak*(Ak'*Qy^(-1)*PAo*Ak)^(-1)*Ak'*Qy^(-1)*ecap_0/...
            (2*sigcap_a);

        F(i, :) = finv(1-0.01/2, 2, m - n - 2) ;

        if T2(i) > F(i)

            a = [a, Ak] ;
            DW = [DW; w2(k, :)] ; DT = [DT; T_sort(k, :)] ;%break
        end
         i = i + 1 ;
    end
    waitbar(kk/size(w, 1))
end
close(h)
save Significatn_frequency2_P242 DW DT T2 P
