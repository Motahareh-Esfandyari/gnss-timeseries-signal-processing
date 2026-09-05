%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : plotDet.m
%  Purpose : Plots a detrended station series.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc; clear; close all; format long g

load('GNSS_Analysis__deterended_P217.mat');
figure(1)
plot(T,xt,'LineWidth',1,'color',[0.13 0.12 0.87])
XTickLabel = 2006:3:2022 ;
XTick = T(1):1095:T(end);
%(XTickLabel-t(1))
set(gca, 'XTick', XTick)
set(gca, 'XTickLabel', XTickLabel)
set(gca,'fontname','times new roman','LineWidth',1.5,'fontweight','bold','fontsize',12)
title('Detrended GNSS Time Series - P217 Station'); xlabel('Time(years)'); ylabel('Vertical(mm)');
