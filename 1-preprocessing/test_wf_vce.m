%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : test_wf_vce.m
%  Purpose : Small driver testing the white + flicker VCE on simulated
%            data.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc
clear
close all
VCE_method='A_FULL'
m=10*365;
sigma_w=0.005; sigma_f=0.016;
[time,dec_year,y,S_str,offset_index,offset_value,y_signal,y_noise,y_trend,Ys,Q_y]=data_simulation(m,sigma_w^2,sigma_f^2,[1.356;0.001;-0.002;-0.003;-0.001;-0.002]);
[Qx,SIGMA(:,1)]=LSVCE_wf(y,VCE_method);
