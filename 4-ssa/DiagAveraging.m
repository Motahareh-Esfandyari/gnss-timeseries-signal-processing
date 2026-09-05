%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Function: DiagAveraging.m
%  Purpose : Diagonal (Hankel) averaging that turns a reconstructed
%            trajectory matrix back into a series.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

function v = DiagAveraging(A)
[n, m] = size(A) ;
i = 1 ;
for d = -(n-1):(m-1)
    v(i, :) = mean(diag(flipud(A), d)) ;
    i = i + 1 ;
end
end
