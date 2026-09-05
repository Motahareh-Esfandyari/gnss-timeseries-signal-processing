%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Function: WhiteNoise.m
%  Purpose : White noise cofactor matrix (identity).
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

function [Qw] = WhiteNoise(m)
Qw = eye(m) ;
end
