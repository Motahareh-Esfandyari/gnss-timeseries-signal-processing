%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : EMD.m
%  Purpose : Empirical Mode Decomposition of a detrended station series,
%            plots the IMFs and saves them for the Hilbert step.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc; clear; close all; format long g;

%% Reading data
load GNSS_Analysis__deterended2_p242
t1 = 1:length(v);
t = t1;
%% Empirical mode decomposition

[imf, residual, info] = emd(v, 'SiftRelativeTolerance', 0.1,...
    'MaxNumImf', 100,...0
    'Display', 1,...
    'Interpolation', 'pchip') ;

figure(1) ;

k = fix(size(imf, 2)/5) ;

if mod(k, 5)~=0
    k = k + 1 ;
end
t = length(t);
subplot(5, 1, 1)
plot(t1, v,'LineWidth',1.5, 'color',[0.13,0.12,0.87])
XTickLabel = 2007:3:2023 ;
XTick = t1(1):1095.75:t1(end);
set(gca, 'XTick', XTick)
set(gca, 'XTickLabel', XTickLabel)
set(gca,'fontname','times new roman','LineWidth',2,'fontweight','bold','fontsize',12)
xlabel('Time (years)')
ylabel('Vertical (mm)') ;
title('GNSS time series - p242')

for ii = 2:k+1
    i = ii-1 ;
    if i==1
        for j = 1:4
            subplot(5, 1, j+1)
            plot(t1, imf(:, j),'LineWidth',1.5, 'color',[0.13,0.12,0.87])
            XTickLabel = 2007:3:2023 ;
            XTick = t1(1):1095.75:t1(end);
            set(gca, 'XTick', XTick)
            set(gca, 'XTickLabel', XTickLabel)
            set(gca,'fontname','times new roman','LineWidth',2,'fontweight','bold','fontsize',12)
            xlabel('Time (years)')
            ylabel(['IMF ', num2str(j)])
        end
    else
        c = 0 ;
        figure(ii)
        for j = 5*i-5:5*i-1
            if j>size(imf, 2)
                break
            end
            c = c + 1 ;
            subplot(5, 1, c)
            plot(t1, imf(:, j),'LineWidth',1.5, 'color',[0.13,0.12,0.87])
            XTickLabel = 2007:3:2023 ;
            XTick = t1(1):1095.75:t1(end);
            set(gca, 'XTick', XTick)
            set(gca, 'XTickLabel', XTickLabel)
            set(gca,'fontname','times new roman','LineWidth',2,'fontweight','bold','fontsize',12)
            xlabel('Time (years)')
            ylabel(['IMF ', num2str(j)])
        end
    end
end

if c==5
    figure(ii+1)
    plot(t1, residual,'LineWidth',1.5, 'color',[0.13,0.12,0.87])
    XTickLabel = 2007:3:2023 ;
    XTick = t1(1):1095.75:t1(end);
    set(gca, 'XTick', XTick)
    set(gca, 'XTickLabel', XTickLabel)
    set(gca,'fontname','times new roman','LineWidth',2,'fontweight','bold','fontsize',12)
    xlabel('Time (years)')
    ylabel('Residual')
else
    subplot(5, 1, c+1)
    plot(t1, residual,'LineWidth',1.5, 'color',[0.13,0.12,0.87])
    XTickLabel = 2007:3:2023 ;
    XTick = t1(1):1095.75:t1(end);
    set(gca, 'XTick', XTick)
    set(gca, 'XTickLabel', XTickLabel)
    set(gca,'fontname','times new roman','LineWidth',2,'fontweight','bold','fontsize',12)
    xlabel('Time (years)')
    ylabel('Residual')
end

save Data200 t1 v
save impiricaal_mode_decomposition_p200 imf residual info
%% Hilbert Transform
figure(20)
fs =1/(1/365.25)

hht(imf(:,10),fs)

set(gca, 'YScale', 'log')

c = colorbar ;
colormap jet
%caxis([0 6]);

xlabel('Time (years)')
xTickLabel = 2007:3:2022;
xTick = 0:3:17;
set(gca, 'xTick', xTick ,'LineWidth',1.5)
set(gca, 'xTickLabel', xTickLabel)

set(gca,'fontname','times new roman','LineWidth',2,'fontweight','bold','fontsize',12)
xlabel('Time (years)'); ylabel('Frequency (CPY)'); title('Hilbert Spectrum - p242 (IMF(10))');
ylim([0 10])

% for j = 1:length(xplot1)
%     jm(j) = xline(xplot1(j),'-','fontweight','bold','fontsize',7,'color','black')
% end
%
xplot1 = 0:30.4166667:6517
for j = 1:length(xplot1)
    jk(j) = xline(xplot1(j),'-','fontweight','bold','fontsize',12,'color','r')
end
% yline(26.7975055,'-',"26.79"+"CPY"+",13.63 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(66.773309,'-',"66.77"+"CPY"+",5.4 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(24.7475935,'-',"24.74"+"CPY"+",14.76 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% % yline(66.773309,'-',"66.77"+"CPY"+",5.4 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% % yline(10,'-',"10"+"CPY"+",36.25 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% % yline(9,'-',"6"+"CPY"+",40.58 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% % yline(8,'-',"8"+"CPY"+", 45.65"+"Days",'fontweight','bold','fontsize',7,'color','black')
% % yline(7,'-',"7"+"CPY"+", 52.17"+"Days",'fontweight','bold','fontsize',7,'color','black')
% % yline(6,'-',"6"+"CPY"+",60.87 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% % yline(5,'-',"5"+"CPY"+",73.05 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% % yline(4,'-',"4"+"CPY"+", 91.31"+"Days",'fontweight','bold','fontsize',7,'color','black')
% % yline(3,'-',"3"+"CPY"+", 121.75"+"Days",'fontweight','bold','fontsize',7,'color','black')
%  yline(2,'-',"2"+"CPY"+",182.62 "+"Days",'fontweight','bold','fontsize',7,'color','black')
%  yline(2.5,'-',"2.5"+"CPY"+", 146"+"Days",'fontweight','bold','fontsize',7,'color','black')
%  yline(1.35,'-',"1.35"+"CPY"+",270 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% % yline(0.83,'-',"0.83"+"CPY"+",439 "+"Days",'fontweight','bold','fontsize',7,'color','black')
%  yline(0.5,'-',"0.5"+"CPY"+",730.5 "+"Days",'fontweight','bold','fontsize',7,'color','black')
%  yline(0.3,'-',"0.3"+"CPY"+", 1095.5"+"Days",'fontweight','bold','fontsize',7,'color','black')
% % yline(0.25,'-',"0.25"+"CPY"+",1461 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% % yline(0.2,'-',"0.2"+"CPY"+", 1826.25"+"Days",'fontweight','bold','fontsize',7,'color','black')
% %
% % yline(2, '-',"2" + "CPY"+ ",182.62" + " Days", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black');
% % yline(0.5,'-',"0.5 "+"CPY"+",730.5"+"Days",'fontweight','bold','fontsize',7,'color','black')
% % % yline(175.600962,'-',"8 "+"Days",'fontweight','bold','fontsize',7,'color','black')
% yline(1,'-',"1"+"CPY"+",365.25 "+"Days",'fontweight','bold','fontsize',7,'color','black')
