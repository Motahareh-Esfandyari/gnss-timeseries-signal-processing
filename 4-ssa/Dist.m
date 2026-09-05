%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Function: Dist.m
%  Purpose : Cosine-type distance between two vectors, used for grouping
%            SSA components.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

function [d] = Dist(x, y)
d = 1 - (x'*y)/(norm(x)*norm(y)) ;
end
