%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Function: data_simulation.m
%  Purpose : Function that generates synthetic GNSS-like series (noise,
%            trend, harmonics, offsets) with known ground truth.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

function [time,dec_year,y,S_str,offset_index,offset_value,y_signal,y_noise,y_trend,Ys,Q_y]=data_simulation(m,sigma_w,sigma_f,x_cap)
%%%%%%%%%%%%%%%%%
% m: data length
% sigma_w: variance component of white noise in m^2
% sigma_f: variance component of flicker noise in m^2
% x_cap: vector of [y0, r, a1, b1,...]
%%%%%%%%%%%%%%%%%%%
close all
S_str='simulated_data'
t=1:m;
time=t./365.25;
dec_year=time;
Qw=eye(m,m);
Qf=makePL(1,time-time(1)+0.0027);
Qf=Qf*((365.25)^(1/4))^-2;
Q_y=sigma_w*Qw+sigma_f*Qf;
R=chol(Q_y);
rng('default');
rng(1);                                                    %% this line is for repeatability of the random vector
yr=randn(m,1);
y=R'*yr;
stdy=std(y);
y_noise=y;
freq=[1,2,1*365.25/351.4,2*365.25/351.4,3*365.25/351.4,4*365.25/351.4,5*365.25/351.4,6*365.25/351.4,7*365.25/351.4,8*365.25/351.4,365.25/13.63,365.25/14.76];

freq=freq(1:(size(x_cap,1)-2)/2);
A(:,1)=ones(length(time),1);
A(:,2)=time;
xcap_trend=x_cap(1:2);
y_trend=A*xcap_trend;
% y_trend=0*y_trend; %%without any trend if you want to keep the trend comment this line
y=y+y_trend;

for i=1:size(freq,2)
A(:,2*i+1)=cos((2*pi*freq(i))*time);
A(:,2*i+2)=sin((2*pi*freq(i))*time);
end
A(:,1:2)=[];
xcap=x_cap(3:end);
y_anual=A(:,1:2)*xcap(1:2);
y_semianual=A(:,3:4)*xcap(3:4);
y_signal=y_anual+y_semianual;
Ys=xcap'.*A;

figure
subplot(2,1,1)
plot(time,y)
title('trend+noise')
legend(['sigma w=' num2str(sigma_w) '  sigma f=' num2str(sigma_f) '  std=' num2str(stdy) ])
subplot(2,1,2)
hold on
plot(time,y_anual)
hold on
plot(time,y_semianual)
title('signal')
legend('Annual signal','Semi annual signal')

y=y+A*xcap;

%GAP
y_signal(500:500:2000,:)=nan;y_trend(500:500:2000,:)=nan;
y_signal(2500:2507,:)=nan;y_trend(2500:2507,:)=nan;

offset_index=[];offset_value=[];
 Ak_offset=tril(ones(m));    %this tow lines simulate offset
 n_offset=round(10*rand(1,1))+2;
 offset_index=round(m*rand(n_offset,1));
 offset_value=[3*stdy*(2*rand(n_offset,1)-1)];
 for i=1:n_offset
 y=y+offset_value(i)*Ak_offset(:,offset_index(i)); %this tow lines simulate offset
 end

figure
plot(time,y,'color',[0.5,0.5,0.5])
hold on
plot(time,y_trend+y_signal,'r','linewidth',2)

legend('Trend+Annual+ Semiannual signals+ (W+FL) noise','Trend+Annual+ Semiannual signals')
xlabel('Time (year)')
ylabel('Simulated data (m)')
