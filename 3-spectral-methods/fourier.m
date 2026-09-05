%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : fourier.m
%  Purpose : FFT amplitude spectrum of a detrended series, frequency axis
%            in cycles per year.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc; clear; close all; format long g;

load GNSS_Analysis__deterended2_TOIY; v = r;
t = 1:length(v);
%% Fourier
Y = fft(v);
dt = mean(diff(t));
fs = 1/(1/365.25);

L = length(v);
ft = fs*(0:L/2)/L;
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
P1 = P1.^2;
T = (1./ft)/60/60/24;

figure(1)

plot(ft, P1,'LineWidth',2, 'color',[125,0,251]/255)
xlabel('Frequency (CPY)','fontweight','bold','fontsize',10)
ylabel('PSD (mm^2/CPY)','fontweight','bold','fontsize',10)
title('Fourier spectrum - TOIY','fontweight','bold','fontsize',14)
set(gca, 'XScale', 'log','LineWidth', 1)
set(gca, 'fontname', 'times new roman', 'LineWidth', 1.5, 'fontweight', 'bold', 'fontsize', 12);
% % xline(1.00068,'-',"1.00068" + "CPY"+"365" + " Days", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(0.6875,'-',"0.6875" + "CPY"+"531.27" + " Days", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(0.124979,'-',"0.1249" + "CPY"+"2922.4" + " Days", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
xline(2.10144,'-',"2.10144" + "CPY"+"173.81" + " Days", 'fontweight', 'bold', 'fontsize', 10, 'color', 'black');
xline(1,'-',"1" + "CPY"+"365.25" + " Days", 'fontweight', 'bold', 'fontsize', 10, 'color', 'black');
xline(0.125,'-',"0.125" + "CPY"+"2436.6" + " Days", 'fontweight', 'bold', 'fontsize', 10, 'color', 'black');
% xline(4.1875,'-',"4.1875" + "CPY"+"87.22" + " Days", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
%xline(0.1875,'-',"0.1875" + "CPY"+"1948" + " Days", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
xline(0.375,'-',".375" + "CPY"+"974" + " Days", 'fontweight', 'bold', 'fontsize', 10, 'color', 'black');
% xline(2, '-',"2" + "CPY"+ "(182.62" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(3, '-',"3" + "CPY"+ "(121.75" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(4, '-',"4" + "CPY"+ "(91.31" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(5, '-',"5" + "CPY"+ "(73.05" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(6, '-',"6" + "CPY"+ "(60.87" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(7, '-',"7" + "CPY"+ "(52.17" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(8, '-',"8" + "CPY"+ "(45.65" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(9, '-',"9" + "CPY"+ "(40.58" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(10, '-',"10" + "CPY"+ "(36.52" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(26.7975055, '-',"26.8" + "CPY"+ "(13.63" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(66.77330895795247,'-',"66.77" + "CPY"+ "(5.4" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(130.4464285714286, '-',"175.6" + "CPY"+ "(2.08" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(0.5, '-',"0.5" + "CPY"+ "(730.5" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(0.3, '-',"0.3" + "CPY"+ "(1095.5" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
xline(0.25, '-',"0.25" + "CPY"+ "(1461" + " Days)", 'fontweight', 'bold', 'fontsize', 10, 'color', 'black');
% xline(0.2, '-',"0.2" + "CPY"+ "(1826.25" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(1.352777777777778, '-',"1.35" + "CPY"+ "(270" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(2.501712328767123, '-',"2.5" + "CPY"+ "(146" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% xline(0.832004555808656, '-',"0.83" + "CPY"+ "(439" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
%xline(0.112091, '-',"0.11" + "CPY"+ "(3258.5" + " Daysl)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');

% xline((1/(366*86400))*1e9,'--',"366"+" days",'color',[238,0,0]/255)
% xline((1/(730*86400))*1e9,'--',"730"+" days",'color',[238,0,0]/255)
% xline((1/(1026*86400))*1e9,'--',"1026"+" days",'color',[238,0,0]/255)
% xline((1/(2555*86400))*1e9,'--',"2555"+" days",'color',[238,0,0]/255)
set(gca, 'YLim', [0, 33])
figure(2)

plot(T, P1, 'color',[125,0,251]/255)
xlabel('Period (day)','fontweight','bold','fontsize',10)
ylabel('PSD','fontweight','bold','fontsize',10)
title('Fourier spectrum - P210','fontweight','bold','fontsize',14)
set(gca, 'XScale', 'log','LineWidth', 1)
xline(366,'--',"366"+" days",'color',[238,0,0]/255)
xline(730,'--',"730"+" days",'color',[238,0,0]/255)
xline(1026,'--',"1026"+" days",'color',[238,0,0]/255)
xline(2555,'--',"2555"+" days",'color',[238,0,0]/255)

set(gca, 'YLim', [0, 30])
% stft(v)
%spectrogram(v,64,16)
