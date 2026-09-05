%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : simulation.m
%  Purpose : Simulates a 10-year daily series with white + flicker noise,
%            trend, harmonics and offsets, and validates the detection
%            chain on it.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc; clear; close all; format long g;

m = 10*365;
time = 1:m;

t=time./365.25;
dec_year=time;
sigma_w=0.005; sigma_f=0.016;

Qw=eye(m,m);
Qf=makePL(1,t-t(1)+0.0027);
Qf=Qf*((365.25)^(1/4))^-2;
Q_y=sigma_w*Qw+sigma_f*Qf;
R=chol(Q_y);
rng(1);                                                    %% this line is for repeatability of the random vector
yr=randn(m,1);
y=R'*yr;
stdy=std(y);
y_noise=y;
x_cap = [1.356;0.001;-0.002;-0.003;-0.001;-0.002]

freq=[1,2,1*365.25/351.4,2*365.25/351.4,3*365.25/351.4,4*365.25/351.4,5*365.25/351.4,6*365.25/351.4,7*365.25/351.4,8*365.25/351.4,365.25/13.63,365.25/14.76  365.25/6.4];
x_cap = [1.356;0.001;-0.002;-0.003;-0.001;-0.002;-1.21766837248534;1.38847695413599;0.25719755495076;0.4333621592978];
freq=freq(1:(size(x_cap,1)-2)/2);
A(:,1) = ones(length(t),1);
A(:,2) = t;
xcap_trend=x_cap(1:2);
y_trend=A*xcap_trend;
y=y_noise+y_trend;

%
% for j = 1:length(t)
% end
T = zeros(size(t));
T(1:730:end) = 1; T(1) = 0;
T = T'; t = t';

num_offsets = 5;
k = [-0.0921766837248534;0.0838847695413599;-0.0125719755495076;0.0104333621592978;0.0237327528359561];
%

for j = 1:length(A)
    for i = 1:size(freq,2)
         np1(j) = 2*exp(0.3*sin(t(j)));    %4*t(j);
        nf1(j) = (365.25/5.4)*t(j);
        nf2(j) = (365.25/2.8)*t(j);
        A(:,2*i+1) = 15*sin(2*pi*freq(i)*t);
        A(:,2*i+2) = 15*cos(2*pi*freq(i)*t);
        A(:,2*i+3) = 10*sin(2*pi*freq(i)*t);
        A(:,2*i+4) =10*cos(2*pi*freq(i)*t);
        A(:,2*i+5) = 2*sin(2*pi*freq(i)*t);
        A(:,2*i+6) = 2*cos(2*pi*freq(i)*t);
    end

end

A(:,7:10) = zeros(length(t),4);
A(730:end,7) = 1; A(1460:end,8) = 1; A(2190:end,9) = 1; A(2920:end,10) = 1;
A(:,7) = A(:,7)*k(1); A(:,8) = A(:,8)*k(2); A(:,9) = A(:,9)*k(3); A(:,10) = A(:,10)*k(4);
A(:,1:2)=[];
xcap=x_cap(3:end);
y_anual=A(:,1:2)*xcap(1:2);
y_semianual=A(:,3:4)*xcap(3:4);
 y_v_annual = A(:,9:10);   %.*(0.002*randn(length(t),1));
y_offset = A(:,5:8)*xcap(5:8);
y_signal=7*y_anual+y_semianual;
yfinal = y + y_signal;
figure
subplot(3,1,1)
plot(time,y,'LineWidth',1,'color',[0.13 0.12 0.87])
title('trend+noise')
set(gca,'fontname','times new roman','LineWidth',1.5,'fontweight','bold','fontsize',12)

subplot(3,1,2)
hold on
title('Annual frequency')
plot(time,y_anual,'LineWidth',1,'color',[0.13 0.12 0.87])
set(gca,'fontname','times new roman','LineWidth',1.5,'fontweight','bold','fontsize',12)

subplot(3,1,3)
hold on
plot(time,y_semianual,'LineWidth',1,'color',[0.13 0.12 0.87])
title('semi-annual frequency')
set(gca,'fontname','times new roman','LineWidth',1.5,'fontweight','bold','fontsize',12)

% %title(' frequency')
% %legend('Annual signal','Semi annual signal')
set(gca,'fontname','times new roman','LineWidth',1.5,'fontweight','bold','fontsize',12)
xlabel('time(days)'); ylabel('vertical(mm)');
figure(2)
plot(time,yfinal,'LineWidth',1,'color',[0.13 0.12 0.87])
xlabel('time(days)'); ylabel('vertical(mm)');
title('Simulated time series')
set(gca,'fontname','times new roman','LineWidth',1.5,'fontweight','bold','fontsize',12)

% xline(730,'-', "NO.1"+" Offset", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black')
% xline(1460,'-', "NO.2 Offset", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black')
% xline(2190,'-', "NO.3 Offset", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black')
% xline(2920,'-', "NO.4 Offset", 'fontweight', 'bold', 'fontsize', 7, 'color', 'black')
