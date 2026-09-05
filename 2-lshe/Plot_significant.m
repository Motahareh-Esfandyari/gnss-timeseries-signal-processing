%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : Plot_significant.m
%  Purpose : Loads and displays the detected significant periods of a
%            station.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc; clear; close all; format long g;

load Significatn_frequency_P033
dt1 = DT;
dw1 = DW;
clear DT DW

load Significatn_frequency_P067
dt2 = DT;
dw2 = DW;
clear DT DW
