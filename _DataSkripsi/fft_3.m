clc;
clear;

fs = 200;
load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\J25.txt');
signal = J25(:,1);
N = length(signal);
X_mags = abs(fft(signal));
bin_vals = [0:N-1];
fax_Hz = bin_vals*fs/N;
N_2 = ceil(N/2);
plot(fax_Hz(1:N_2), X_mags(1:N_2))
xlabel('Frequency (Hz)')
ylabel('Magnitude');
title('Single-sided Magnitude spectrum (Hertz)');
axis tight