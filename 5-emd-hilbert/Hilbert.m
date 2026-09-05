%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : Hilbert.m
%  Purpose : Hilbert transform of the IMFs: instantaneous frequency and the
%            Hilbert spectrum of the decomposition.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc; clear; close all; format long g;

%% reading data

load Data242 t1 v
load impiricaal_mode_decomposition_p242 imf residual info
%% Hilbert Transform
IMFn = imf;
dt = mean(diff(t1)) ;
fs = 1/dt/(60*60*24*365.25) ;
mn = 31557.6;

hht(IMFn)

set(gca, 'YScale', 'log')
t = 1:length(t1);

colormap jet
%caxis([0 6]);
xTickLabel = 2006:2:2023;
xTick = t(1):730.5:t(end);
set(gca, 'xTick', xTick ,'LineWidth',1)
set(gca, 'xTickLabel', xTickLabel)
set(gca,'fontname','times new roman','LineWidth',1.5,'fontweight','bold','fontsize',10)
xlabel('Time (years)')
ylabel('Period (year)')
title('Hilbert Spectrum - p217')
% for j = 1:length(xplot1)
%     jm(j) = xline(xplot1(j),'-','fontweight','bold','fontsize',7,'color','black')
% end
%
% for j = 1:length(xplot1)
%     jk(j) = xline(xplot1(j),'-','fontweight','bold','fontsize',7,'color','r')
% end
yline(0.0147843943,'-',"5.4 "+"Days",'fontweight','bold','fontsize',7,'color','black')
%yline(8/365.25,'-',"8 "+"Days",'fontweight','bold','fontsize',7,'color','black')
yline(0.0056947296372348,'-',"2.08 "+"Days",'fontweight','bold','fontsize',7,'color','black')
yline(1,'-',"365.25 "+"Days",'fontweight','bold','fontsize',7,'color','black')
