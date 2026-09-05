%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : newplotoccurance.m
%  Purpose : Monthly occurrence plot of the 5.4-day signal for groups G1
%            and G2.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc; clear; close all;

% Data for 5.4 days (G1 & G2) - Monthly
a = [20;14;18;21;23;12;14;15;21;26;22;20];  % G1 (5.4 days)
b = [3;13;6;13;7;8;7;10;9;8;15;5];          % G2 (5.4 days)

% Data for the custom plot (c and d) - where c is for G1 and d is for G2
c = [4,6,13,9,9,10,12,9,12,12,8,12,12,6,8,3]; % G1 (custom data)
d = [11,16,11,17,10,13,12,20,14,24,23,15,12,11,17,15]; % G2 (custom data)

% **Figure 1: Monthly Data for 5.4 days (G1 & G2) - Bar Chart**
figure(1)
bar(1:12, [a b], 'grouped')  % Plot G1 and G2 as grouped bars
ylim([1 30])
xticks(1:12)
xticklabels({'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'})
set(gca, 'fontname', 'times new roman', 'LineWidth', 2, 'fontweight', 'bold', 'fontsize', 14)
ylabel('Frequency Occurrence')  % Label y-axis
legend('5.4 days (G1)', '5.4 days (G2)')
title('5.4 Days Period - Monthly Data')

% **Figure 2: Custom Data for G1 (c) and G2 (d) - Bar Chart**
figure(2)
bar(1:16, [d' c'], 'grouped')  % Plot G1 (c) and G2 (d) as grouped bars
ylim([1 30])
xticks(1:16)
xticklabels({'2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022'})
set(gca, 'fontname', 'times new roman', 'LineWidth', 2, 'fontweight', 'bold', 'fontsize',14)
ylabel('Frequency Occurrence')  % Label y-axis
legend('G1 (Custom)', 'G2 (Custom)')
title('Custom Data (G1 & G2) - Yearly Data')
