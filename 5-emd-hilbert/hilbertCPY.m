%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : hilbertCPY.m
%  Purpose : Hilbert spectrum variant used for the paper figures.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc; clear; close all; format long g;

%% reading data

load Data200 t1 v
load impiricaal_mode_decomposition_p572 imf residual info
%% Hilbert Transform
fs =1/(1/365.25)

hht(imf(:,:),fs)
set(gca, 'YScale', 'log');
colormap jet;
% caxis([0 6]);

xTickLabel = 2007:3:2022;
xTick = 0:3:17;
set(gca, 'xTick', xTick ,'LineWidth',1)
set(gca, 'xTickLabel', xTickLabel)

set(gca,'fontname','times new roman','LineWidth',1.5,'fontweight','bold','fontsize',11)
xlabel('Time (years)'); ylabel('Frequency (CPY)'); title('Hilbert Spectrum - P572');
ylim([0 10])
%caxis([0 6])

% for j = 1:length(xplot1)
%     jm(j) = xline(xplot1(j),'-','fontweight','bold','fontsize',7,'color','black')
% end
%
% for j = 1:length(xplot1)
%     jk(j) = xline(xplot1(j),'-','fontweight','bold','fontsize',7,'color','r')
% end
%yline(36.4949,'-',"36.49"+"CPY"+",10 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(26.7975055,'-',"26.79"+"CPY"+",13.63 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(67.6388889,'-',"67.63"+"CPY"+",5.4 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(24.7475935,'-',"24.74"+"CPY"+",14.76 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(130.457143,'-',"130.457143"+"CPY"+",2.8 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(10,'-',"10"+"CPY"+",36.25 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(15.2072,'-',"15.2072"+"CPY"+",24.02 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(9,'-',"6"+"CPY"+",40.58 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(8,'-',"8"+"CPY"+", 45.65"+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(7,'-',"7"+"CPY"+", 52.17"+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(6,'-',"6"+"CPY"+",60.87 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(5,'-',"5"+"CPY"+",73.05 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(4.77616,'-',"4.77"+"CPY"+", 76.4735"+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(4,'-',"4"+"CPY"+", 91.31"+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(3,'-',"3"+"CPY"+", 121.75"+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(2,'-',"2"+"CPY"+",182.62 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(2.5,'-',"2.5"+"CPY"+", 146"+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(1.35,'-',"1.35"+"CPY"+",270 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(1.0668,'-',"1.06"+"CPY"+",342.37 "+"Days",'fontweight','bold','fontsize',7,'color','black')

% yline(0.83,'-',"0.83"+"CPY"+",439 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(0.5,'-',"0.5"+"CPY"+",730.5 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(0.3,'-',"0.3"+"CPY"+", 1095.5"+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(0.25,'-',"0.25"+"CPY"+",1461 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(0.2,'-',"0.2"+"CPY"+", 1826.25"+"Days",'fontweight','bold','fontsize',7,'color','black')
%yline(0.191667,'-',"0.19"+"CPY"+", 1905.64"+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(1.00068,'-',"365" + " Days", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(2.10144,'-',"173.81" + " Days", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(2, '-',"2" + "CPY"+ ",182.62" + " Days", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% yline(0.5,'-',"0.5 "+"CPY"+",730.5"+"Days",'fontweight','bold','fontsize',7,'color','black')
%yline(175.600962,'-',"8 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(1,'-',"1"+"CPY"+",365.25 "+"Days",'fontweight','bold','fontsize',7,'color','black')
