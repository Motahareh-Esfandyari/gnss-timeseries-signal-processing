%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : emd1.m
%  Purpose : EMD driver reading a NOTA csv directly (station P595 example).
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clear
clc
close all
format long g

[time,north,east,ver] = readvars('P595.cwu.igs14.csv');
t = juliandate(time,'modifiedjuliandate')
d = yyyymmdd(time)

%% outlier
xnor = ver;
aoutlier1 = T3Sigma(xnor);
aoutlier2 = T5Sigma(xnor);
TF = isoutlier(xnor);          %,'movmean',500
fidx = find(TF==1);
xnor(TF==1) = nan;
%xline(390,'magenta' , ' GAP')

%% GAPFilling
m1 = min(t(:));    %% the start of recording data
m2 = max(t(:));    %% the end of recording data

% A = zeros(m2 - m1,1);   %% as the time interval is equal to one, a matrix without gap is created
% T = d + m1 - 1;     %% this is optimal time without gap

T = m1 : m2;
T = T';
t1 = m1 :m2;
t1 = t1';
%%%% from the next step we are going to fing cells which are gaps %%%%
gap = diff(t);
idx = find(gap > 1);   %%% this shpws where a gap is located

F = 0;
LL = zeros(numel(idx) + 1 ,1);

for i = 1 : numel(idx)

    idxx(i) = idx(i) + F;
    LL (i + 1) = t(idx(i) + 1) - t (idx(i)) - 1 ;
    F = sum(LL);

end

for i = 1: numel(idx)
    L = t(idx(i) + 1) - t(idx(i));
    t1 (idxx(i) + 1 : idxx(i) + L - 1 , 1) =  nan;
    T (idxx(i) + 1 : idxx(i) + L - 1 , 1) =   T (idxx(i) + 1 : idxx(i) + L - 1 , 1);
end

%%%% ver
v = zeros(numel(t1),1);
v(:) = nan;

for i = 1 : numel(t1)

    if isnan(t1(i)) == 1
        continue
    end

    k = find( t == t1 (i) );
    v (i) = ver(k);

end
v = fillgaps(v);

%% EMD-Hibert Spectrum:
dt = mean(diff(T));
fs = 1./(dt*24*60*60) ;

[imf, residual, info] = emd(v, 'SiftRelativeTolerance', 0.0001,...
    'MaxNumImf', 100,...
    'Display', 1,...
    'Interpolation', 'pchip') ;

figure(1) ;

t = T ;

k = fix(size(imf, 2)/5) ;

if mod(k, 5)~=0
    k = k + 1 ;
end

subplot(5, 1, 1)
plot(t, v)
xlabel('Time [years]')
ylabel('Water level') ;
title('Water level')

for ii = 2:k+1
    i = ii-1 ;
    if i==1
        for j = 1:4
            subplot(5, 1, j+1)
            plot(T, imf(:, j))
            xlabel('Time [years]')
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
            plot(T, imf(:, j))
            xlabel('Time [years]')
            ylabel(['IMF ', num2str(j)])
        end
    end
end

if c==5
    figure(ii+1)
    plot(T, residual)
    xlabel('Time [years]')
    ylabel('Residual')
else
    subplot(5, 1, c+1)
    plot(T, residual)
    xlabel('Time [years]')
    ylabel('Residual')
end

save Data T v fs
save IMFs imf residual info

figure(9)
hht(imf, fs)
