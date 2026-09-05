%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : STFT.m
%  Purpose : Short-Time Fourier Transform spectrogram of a station series.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc; clear; close all; format long g;

% Load the detrended time series
load GNSS_Analysis__deterended_toiy; % Replace with your file as needed

Fs = 1;   % Sampling frequency: 1 sample per day
window_length = 365.25; % Window length (50 days)
overlap = floor(window_length / 2); % Ensure overlap is an integer
nfft = 1024; % Moderate number of FFT points for better balance

% Create a Gabor window (Gaussian)
sigma = window_length / 40; % Standard deviation for the Gaussian window
t_gauss = (-window_length/2 : window_length/2 - 1)';
gabor_window = exp(-0.5 * (t_gauss / sigma).^2);

% Apply STFT with Gabor window
[s, f, t_s] = stft(y, Fs, 'Window', gabor_window, 'OverlapLength', overlap, 'FFTLength', nfft);

% Convert frequency to cycles per year
f_cycles_per_year = f * 365.25;

% Filter out negative frequencies (keep only positive frequencies)
positive_frequencies = f >= 0; % Only keep non-negative frequencies
f_filtered = f_cycles_per_year(positive_frequencies);
s_filtered = s(positive_frequencies, :);

% Interpolate the STFT results for better visualization
f_interp = linspace(min(f_filtered), max(f_filtered), 500); % Interpolated frequency vector
s_interp = interp1(f_filtered, abs(s_filtered), f_interp, 'linear', 'extrap'); % Interpolate STFT results

% Create a time vector corresponding to the years
time_vector = linspace(2007, 2022, length(t_s)); % Adjusted to 2022

% Plotting STFT in 2D space (Time vs Interpolated Frequency)
figure;
imagesc(time_vector, f_interp, s_interp); % Use interpolated values for the magnitude of the STFT
set(gca, 'YDir', 'normal', ...
         'FontName', 'Times New Roman', ...
         'LineWidth', 1.5, ...
         'FontWeight', 'bold', ...
         'FontSize', 17);

xlabel('Time (Years)', 'FontWeight', 'bold', 'FontSize', 17);
ylabel('Frequency (CPY)', 'FontWeight', 'bold', 'FontSize', 17);
title('GNSS time series - TOIY');
colorbar;

% Adjust color limits to enhance visibility
caxis([0 max(s_interp(:)) * 0.9]); % Limit color axis to 90% of max value
colormap(jet); % Use a different colormap for better distinction

% Set x-ticks to show years from 2007 to 2022, excluding 2023
xticks(2007:3:2022); % Set x-ticks from 2007 to 2022
