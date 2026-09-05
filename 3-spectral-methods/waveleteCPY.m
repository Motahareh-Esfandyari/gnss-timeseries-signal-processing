%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : waveleteCPY.m
%  Purpose : Continuous wavelet transform of a detrended series, scalogram
%            with period axis in years and cone of influence.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc; clear; close all; format long g;

%% Reading data

load GNSS_Analysis__deterended_toiy; v = r;
t = 1:length(v);

%% Wavelete transform

figure(1)
fs = 1/(1/365.25);
[wt, f] = cwt(v, fs);
image('XData', t, 'YData', f, 'CData', abs(wt), 'CDataMapping', 'scaled');
ylim([-1 5]); colormap jet; caxis([0 6])
axis tight;
c = colorbar ;
set(gca, 'YScale', 'log');
XTickLabel = 2007:3:2022;
XTick = t(1):1095.75:t(end);
set(gca, 'XTick', XTick);
set(gca, 'XTickLabel', XTickLabel);

set(gca, 'fontname', 'times new roman', 'LineWidth', 1.5, 'fontweight', 'bold', 'fontsize', 12);
title("GNSS Time Series TOIY"); xlabel("Time (years)"); ylabel("Frequency (CPY)");

% for j = 1:length(xplot2)
% end
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end
% xline(365,'-','fontweight','bold','fontsize',7,'color','r');
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end
% xline(731,'-','fontweight','bold','fontsize',7,'color','r');
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end
% xline(1096,'-','fontweight','bold','fontsize',7,'color','r');
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end
% xline(1461,'-','fontweight','bold','fontsize',7,'color','r');
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end
% xline(1826,'-','fontweight','bold','fontsize',7,'color','r');
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end
% xline(2192,'-','fontweight','bold','fontsize',7,'color','r');
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end
% xline(2557,'-','fontweight','bold','fontsize',7,'color','r');
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end
% xline(2922,'-','fontweight','bold','fontsize',7,'color','r');
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end
% xline(3287,'-','fontweight','bold','fontsize',7,'color','r');
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end
% xline(3653,'-','fontweight','bold','fontsize',7,'color','r');
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end
% xline(4018,'-','fontweight','bold','fontsize',7,'color','r');
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end
% xline(4383,'-','fontweight','bold','fontsize',7,'color','r');
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end
% xline(4748,'-','fontweight','bold','fontsize',7,'color','r');
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end
% xline(5114,'-','fontweight','bold','fontsize',7,'color','r');
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end
% xline(5479,'-','fontweight','bold','fontsize',7,'color','r');
%
% for j = 1:length(xplot1)
% end
% for j = 1:length(xplot1)
% end
% xline(5844,'-','fontweight','bold','fontsize',7,'color','r');

% yline(48.8028,'-',"48.8028" + " CPY", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');

yline(1.00068,'-',"365" + " Days", 'fontweight', 'bold', 'fontsize', 12, 'color', 'black');
% % yline(2.10144,'-',"173.81" + " Days", 'fontweight', 'bold', 'fontsize', 7, 'color', 'w');
% yline(2, '-',"2" + "CPY"+ "(182.62" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(3, '-',"3" + "CPY"+ "(121.75" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(4, '-',"4" + "CPY"+ "(91.31" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(5, '-',"5" + "CPY"+ "(73.05" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(6, '-',"6" + "CPY"+ "(60.87" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(7, '-',"7" + "CPY"+ "(52.17" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(8, '-',"8" + "CPY"+ "(45.65" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(9, '-',"9" + "CPY"+ "(40.58" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(10, '-',"10" + "CPY"+ "(36.52" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(26.7975055, '-',"26.8" + "CPY"+ "(13.63" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(57.070313125, '-',"26.8" + "CPY"+ "(6.4" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
%
% yline(66.77330895795247,'-',"66.77" + "CPY"+ "(5.4" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(130.4464285714286, '-',"175.6" + "CPY"+ "(2.08" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(0.5, '-',"0.5" + "CPY"+ "(730.5" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(0.3, '-',"0.3" + "CPY"+ "(1095.5" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(0.25, '-',"0.25" + "CPY"+ "(1461" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(0.2, '-',"0.2" + "CPY"+ "(1826.25" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
%yline(1.04059829, '-',"1.04" + "CPY"+ "(351" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(1.352777777777778, '-',"1.35" + "CPY"+ "(270" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(2.501712328767123, '-',"2.5" + "CPY"+ "(146" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(0.832004555808656, '-',"0.83" + "CPY"+ "(439" + " Days)", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
