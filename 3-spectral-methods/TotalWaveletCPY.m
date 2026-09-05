%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : TotalWaveletCPY.m
%  Purpose : Wavelet scalograms of all stations of a group in one figure,
%            used for the group comparison in the paper.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc; clear; close all; format long g;

%% LOAD DATA
load GNSS_Analysis__deterended_p069; xt1 = r;  %group2
load GNSS_Analysis__deterended_p074; xt2 = r;
load GNSS_Analysis__deterended_p075; xt3 = r;
load GNSS_Analysis__deterended_p572; xt4 = r;
load GNSS_Analysis__deterended2_TOIY; xt5 = r;
t = 1:length(r);

%% performanc Wavelete

fs = 1/(1/365.25);

xTotal = (xt1 + xt2 + xt3 + xt4 + xt5)/5;

[wt1, f1] = cwt(xt1, fs);
[wt2, f2] = cwt(xt2, fs);
[wt3, f3] = cwt(xt3, fs);
[wt4, f4] = cwt(xt4, fs);
[wt5, f5] = cwt(xt5, fs);
[WtTotal1, f] = cwt(xTotal, fs);

WtTotal2 = (wt1 + wt2 + wt3 + wt4 + wt5)/5;
fTotal = f1 + f2 + f3 + f4 +f5;

image('XData', t, 'YData', f1, 'CData', abs(WtTotal1), 'CDataMapping', 'scaled');
ylim([-1 5]); colormap jet;
%caxis([0 6])
axis tight;
c = colorbar ;
set(gca, 'YScale', 'log');
XTickLabel = 2007:3:2022;
XTick = t(1):1095.75:t(end);
set(gca, 'XTick', XTick);
set(gca, 'XTickLabel', XTickLabel);
set(gca, 'fontname', 'times new roman', 'LineWidth', 1.5, 'fontweight', 'bold', 'fontsize', 12);
title("Average wavelet spectrum-Group 2 (P069, P074, P075, P572, TOIY)");
xlabel("Time (years)"); ylabel("Frequency (CPY)");

% for j = 1:length(xplot2)
% end
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end

% yline(128.794,'-',"2.83" + " Days", 'fontweight', 'bold', 'fontsize', 5, 'color', 'black');
% yline(138.038,'-',"2.64" + " Days", 'fontweight', 'bold', 'fontsize', 5, 'color', 'black');
% yline(147.945,'-',"2.46" + " Days", 'fontweight', 'bold', 'fontsize', 5, 'color', 'black');
% yline(158.524,'-',"2.304" + " Days", 'fontweight', 'bold', 'fontsize', 5, 'color', 'black');
% yline(112.122,'-',"3.25" + " Days", 'fontweight', 'bold', 'fontsize', 5, 'color', 'black');
% yline(104.613,'-',"3.491" + " Days", 'fontweight', 'bold', 'fontsize', 5, 'color', 'black');
% yline(97.607,'-',"3.742" + " Days", 'fontweight', 'bold', 'fontsize', 5, 'color', 'black');
% yline(60.845,'-',"6.078" + " Days", 'fontweight', 'bold', 'fontsize', 5, 'color', 'black');
%
% yline(45.5355,'-',"8.02" + " Days", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(26.1533,'-',"13.96" + " Days", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(34.5095,'-',"10.58" + " Days", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(17.2547,'-',"21.16" + " Days", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');

% yline(1,'-',"365.25" + " Days", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% % yline(2, '-',"2" + "CPY"+ "(182.62" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'w');
% yline(3.118241321, '-',"3" + "CPY"+ "(121.75" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(4.157655094, '-',"4" + "CPY"+ "(91.31" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(5.197068867, '-',"5" + "CPY"+ "(73.05" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(6.236482641, '-',"6" + "CPY"+ "(60.87" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(7.275896414, '-',"7" + "CPY"+ "(52.17" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% % yline(11.3839, '-',"11.38" + "CPY"+ "(32.08" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(8.315310188, '-',"8" + "CPY"+ "(45.65" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(9.35473461, '-',"9" + "CPY"+ "(40.58" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(12, '-',"12" + "CPY"+ "(36.52" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(10, '-',"10" + "CPY"+ "(36.52" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(26.7975055, '-',"26.8" + "CPY"+ "(13.63" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(57.070313125, '-',"26.8" + "CPY"+ "(6.4" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(66.77330895795247,'-',"66.77" + "CPY"+ "(5.4" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(130.4464285714286, '-',"175.6" + "CPY"+ "(2.08" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(0.5, '-',"0.5" + "CPY"+ "(730.5" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(0.3, '-',"0.3" + "CPY"+ "(1095.5" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(0.25, '-',"0.25" + "CPY"+ "(1461" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
%yline(0.2, '-',"0.2" + "CPY"+ "(1826.25" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
%yline(1.04059829, '-',"1.04" + "CPY"+ "(351" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(1.23878, '-',"1.23" + "CPY"+ "(294.84" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(1.352777777777778, '-',"1.35" + "CPY"+ "(270" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(2.501712328767123, '-',"2.5" + "CPY"+ "(146" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(0.832004555808656, '-',"0.83" + "CPY"+ "(439" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(7.0076, '-',"7.007" + "CPY"+ "(52.12" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(12.009, '-',"12.2009" + "CPY"+ "(30.41" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(8.04962, '-',"8.04" + "CPY"+ "(45.37" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
%yline(0.437975, '-',"0.437975" + "CPY"+ "(833.951" + " Days)", 'fontweight', 'bold', 'fontsize', 10, 'color', 'black');
