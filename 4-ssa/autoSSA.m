%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Function: autoSSA.m
%  Purpose : SSA with automatic grouping of the components and
%            reconstruction of the dominant modes.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

function [y, Power_y, xi, Power, Z, T, D] = autoSSA(x, r, L)

%% AUTOSSA

N = length(x) ;
K = N - L + 1 ;

for j = 1:K
    X(:, j) = x(j:j+L-1, :) ;
end

R = rank(X) ;

[u, s, v] = svd(X, 'econ') ; sig = diag(s) ;
Power = sig./sum(sig).*100 ;

for i = 1:R
    Xi = sig(i)*u(:, i)*[v(:, i)]' ;
    xi(:, i) = DiagAveraging(Xi) ;
    i
end
clc

k = 0 ;
h = waitbar(0, 'Clustering...') ;
for i = 1:R
    for j = 1:R
        a = xi(:, i) ;
        b = xi(:, j) ;
        D(i, j) = 1 - (a'*b)/(norm(a)*norm(b)) ;
        k = k + 1 ;
        waitbar(k/(R*R))
    end
end
close(h)

k = 1 ;
for j = 1:R
    for i = j+1:R
        a = xi(:, i) ;
        b = xi(:, j) ;
        Y(:, k) = 1 - (a'*b)/(norm(a)*norm(b)) ;
        k = k + 1 ;
    end
end

Z = linkage(Y) ;

T = cluster(Z, 'maxclust', r) ;

for k = 1:r
    [i, ~] = find(T==k) ;
    I(k).Idx = i ;
end

y = zeros(length(x), r) ;
for k = 1:r
    if length(I(k).Idx)==1
        y(:, k) = xi(:, I(k).Idx) ;
        Power_y(k, :) = Power(I(k).Idx) ;
    else
        y(:, k) = [sum([xi(:, I(k).Idx)]')]' ;
        Power_y(k, :) = sum(Power(I(k).Idx)) ;
    end
end

end
