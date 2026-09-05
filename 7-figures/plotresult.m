%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : plotresult.m
%  Purpose : Bar charts of the detected-period occurrences per month for
%            the station groups.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc; clear; close all;

a=[20;14;18;21;23;12;14;15;21;26;22;20];
b=[3;13;6;13;7;8;7;10;9;8;15;5];
e=[15;16;23;11;13;19;14;15;16;18;13;14;13;6;1;11];
g=[8;6;5;8;5;9;7;6;14;5;8;6;8;1;4;4];

figure(1)
plot(a,'LineWidth',2,'color',[0.13 0.12 0.87])
ylim([1 30])
xticks([1 2 3 4 5 6 7 8 9 10 11 12]);
xticklabels({'Jan', 'Feb', 'March', 'April', 'May','June','July','Augu','Sept','Oct', 'Nov','Dec'})
set(gca,'fontname','times new roman','LineWidth',2,'fontweight','bold','fontsize',12)
hold on
plot(b,'LineWidth',2,'color',[0.86 0.36 0.08])
legend

d = [11,16,11,17,10,13,12,20,14,24,23,15,12,11,17,15];
c = [4,6,13,9,9,10,12,9,12,12,8,12,12,6,8,3];
f = [4;5;3;2;6;3;6;3;2;6;2;5;14;3;8;5];
h = [6;0;2;3;9;5;3;1;9;2;2;5;3;5;5;1];

figure(2)
plot(d,'LineWidth',2,'color',[0.13 0.12 0.87])
ylim([1 30])
xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17]);
xticklabels({'2007', '2008', '2009', '2010', '2011','2012','2013','2014','2015','2016', '2017','2018','2019','2020','2021','2022'})
set(gca,'fontname','times new roman','LineWidth',2,'fontweight','bold','fontsize',12)
hold on
plot(c,'LineWidth',2,'color',[0.86 0.36 0.08])

legend
