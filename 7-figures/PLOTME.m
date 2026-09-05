%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : PLOTME.m
%  Purpose : Plots a station series with its fitted model and offsets.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc; clear; close all; format long g;

load GNSS_Analysis__deterended_P242 r y OFF T xcap v
t=T;
figure(1);
title('GNSS time series - p242'); xlabel('Time (years)'); ylabel('Original time series & Trend');
plot(T,v,'LineWidth',1.5,'color',[0.13 0.12 0.87]); grid on;
set(gca,'fontname','times new roman','LineWidth',2.5,'fontweight','bold','fontsize',17);
XTickLabel = 2007:3:2022 ;
XTick = t(1):1059:t(end);
%(XTickLabel-t(1))
set(gca, 'XTick', XTick)
set(gca, 'XTickLabel', XTickLabel)
xlabel('Time (years)'); ylabel('Raw time series (mm)');title('GNSS time series - p242');
plot(T,r,'LineWidth',1.5,'color',[0.207843137 0.796078431 0.517647059]); grid on;
set(gca,'fontname','times new roman','LineWidth',2.5,'fontweight','bold','fontsize',17)
XTickLabel = 2007:3:2022 ;
XTick = t(1):1059:t(end);
%(XTickLabel-t(1))
set(gca, 'XTick', XTick)
set(gca, 'XTickLabel', XTickLabel)
