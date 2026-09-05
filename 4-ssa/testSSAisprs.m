%% ========================================================================
%  GNSS-TS-SignalProcessing : Signal Processing of GNSS Coordinate Time Series
%  ------------------------------------------------------------------------
%  Script  : testSSAisprs.m
%  Purpose : SSA analysis of station P242 with offset significance testing,
%            prepared for the ISPRS submission.
%  ------------------------------------------------------------------------
%  Author  : Motahareh Esfandyari-Kaloukan
%  ========================================================================

%% Singular Spectrum Analysis:

clc; clear; close all; format long g;

% Load data
load p242 t1 v
load GNSS_Analysis_p242 scap c Error N Qy Qw Qf A time

T = t1;

%% Offset detection:
alpha = 0.02;
threshold = chi2inv(1 - alpha, 1);
sim_num = 7;
it = 1:sim_num;

% Perform offset detection
[OFF, A] = offset_Uni(A, v, Qy, T, T, threshold, 0, it);

% Adjust design matrix A
A = A(:, 7:end);

% Ensure Qy is positive definite before inversion
if rcond(Qy) < 1e-12
    warning('Qy is close to singular or badly scaled. Using pseudo-inverse for stability.');
    Qi = pinv(Qy);
else
    Qi = inv(Qy);
end

% Compute xcap using numerically stable method
xcap = (A' * Qi * A) \ (A' * Qi * v);

% Compute fitted values and residuals
ycap = A * xcap;
ecap = v - ycap;

% Plot original data and fitted values
figure(3)
plot(T, v, 'LineWidth', 1, 'Color', [0.13 0.12 0.87]); grid on;
hold on;
plot(T, ycap, 'LineWidth', 1, 'Color', 'r');
hold off;
XTickLabel = 2005:3:2023;
XTick = T(1):1095:T(end);
set(gca, 'XTick', XTick, 'XTickLabel', XTickLabel);
set(gca, 'FontName', 'Times New Roman', 'LineWidth', 1.5, 'FontWeight', 'bold', 'FontSize', 12);
title('GNSS Time Series - P242 (Noise estimation & Offset detection)');
xlabel('Time (years)');
ylabel('Vertical (mm)');

%% Outlier detection using moving mean
TF = isoutlier(ecap, 'movmean', 500);
figure(4)
subplot(2,1,1)
plot(T, ecap, T(TF), ecap(TF), 'x', 'LineWidth', 1, 'Color', [0.13 0.12 0.87]); grid on;
legend('Data', 'Outlier');
set(gca, 'FontName', 'Times New Roman', 'LineWidth', 1.5, 'FontWeight', 'bold', 'FontSize', 12);
XTickLabel = 2005:3:2023;
XTick = T(1):1095:T(end);
set(gca, 'XTick', XTick, 'XTickLabel', XTickLabel);
title('GNSS Time Series - P242');
xlabel('Time (years)');
ylabel('Vertical (mm)');

% Replace outliers with NaN and interpolate
ecap(TF) = NaN;
ecap = fillmissing(ecap, 'linear');

% Repeat outlier detection with a larger window
TF = isoutlier(ecap, 'movmean', 2000);
figure(5)
subplot(2,1,1)
plot(T, ecap, T(TF), ecap(TF), 'x', 'LineWidth', 1, 'Color', [0.13 0.12 0.87]); grid on;
legend('Data', 'Outlier');
set(gca, 'FontName', 'Times New Roman', 'LineWidth', 1.5, 'FontWeight', 'bold', 'FontSize', 12);
XTickLabel = 2005:3:2023;
XTick = T(1):1095:T(end);
set(gca, 'XTick', XTick, 'XTickLabel', XTickLabel);
title('GNSS Time Series - P242 (Outlier detection)');
xlabel('Time (years)');
ylabel('Vertical (mm)');

% Replace outliers with NaN and interpolate
ecap(TF) = NaN;
ecap = fillmissing(ecap, 'linear');

%% Singular Spectrum Analysis:

L = 1095;  % Window length
[y, r, vr] = ssadow(ecap, L);

% Plot original and reconstructed time series
figure(6);
subplot(2,1,1);
plot(T, ecap, 'LineWidth', 1, 'Color', [0.13 0.12 0.87]); grid on;
hold on;
plot(T, y, 'LineWidth', 1, 'Color', 'r');
hold off;
set(gca, 'FontName', 'Times New Roman', 'LineWidth', 1.5, 'FontWeight', 'bold', 'FontSize', 12);
XTickLabel = 2005:3:2023;
XTick = T(1):1059:T(end);
set(gca, 'XTick', XTick, 'XTickLabel', XTickLabel);
title('GNSS Time Series - P242');
xlabel('Time (years)');
ylabel('Original & Reconstructed Time Series');

% Plot residuals
subplot(2,1,2);
plot(T, r, 'LineWidth', 1, 'Color', [0.207843137 0.796078431 0.517647059]); grid on;
set(gca, 'FontName', 'Times New Roman', 'LineWidth', 1.5, 'FontWeight', 'bold', 'FontSize', 12);
XTickLabel = 2005:3:2023;
XTick = T(1):1059:T(end);
set(gca, 'XTick', XTick, 'XTickLabel', XTickLabel);
title('Residuals Time Series');
xlabel('Time (years)');
ylabel('Residuals');
