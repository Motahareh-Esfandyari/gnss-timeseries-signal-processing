%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : stftz.m
%  Purpose : STFT variant with the window settings used for the paper
%            figures.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

clc; clear; close all; format long g;

% Load the detrended time series
load GNSS_Analysis__deterended_p210; % Replace with your file as needed

Fs = 1;   % Sampling frequency: 1 sample per day
window_length = 50; % Shortened window length to capture more variations
overlap = floor(window_length / 2); % Ensure overlap is an integer
nfft = 180; % Moderate number of FFT points for better balance

% Apply STFT
[s, f, t_s] = stft(y, Fs, 'Window', hamming(window_length), 'OverlapLength', overlap, 'FFTLength', nfft);

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
time_vector = linspace(2007, 2023, length(t_s));

% Plotting STFT in 2D space (Time vs Interpolated Frequency)
figure;
imagesc(time_vector, f_interp, s_interp); % Use interpolated values for the magnitude of the STFT
set(gca, 'YDir', 'normal', ...
         'FontName', 'Times New Roman', ...
         'LineWidth', 1.5, ...
         'FontWeight', 'bold', ...
         'FontSize', 12);

xlabel('Years', 'FontWeight', 'bold', 'FontSize', 10);
ylabel('Frequency (CPY)', 'FontWeight', 'bold', 'FontSize', 10);
title('GNSS time series - P210');
colorbar;

% Adjust color limits to enhance visibility
caxis([0 max(s_interp(:)) * 0.9]); % Limit color axis to 90% of max value
colormap(jet); % Use a different colormap for better distinction

% Set x-ticks to show years from 2007 to 2023
xticks(2007:3:2023); % Set x-ticks from 2007 to 2023
