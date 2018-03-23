% Plotting PSD pisah per kanal
close all;
clear;
clc;

% static
fs = 200;
[b,a] = butter(2,[49 51]/(fs/2), 'stop');           % Notch
[h,g] = butter(2,[0.1 50]/(fs/2), 'bandpass');   % Filter awal 1-50 Hz
[d,c] = butter(2,[10.5 11.5]/(fs/2), 'bandpass');   % Merah - 11 Hz
[f,e] = butter(2,[12.5 13.5]/(fs/2), 'bandpass');   % Biru  - 13 Hz

% durasi
chAwal = 1;
chAkhir = 4;
%% [Awal Akhir,...]
% Jeda = [0 3, 8 11, 16 19, 24 27, 32 35, 40 43]
% Merah = [3 8, 19 24, 35 40]
% Biru  = [11 16, 27 32, 43 48]
% === SETELAH x 200 Hz ===
% Jeda = [1 600, 1601 2200, 3201 3800, 4801 5400, 6401 7000, 8001 8600]
% Merah = [601 1600, 3801 4800, 7001 8000]
% Biru  = [2201 3200, 5401 6400, 8601 length(Biru)]
% vline([0 5 16 21 32 37], 'r');
% vline([8 13 24 29 40 45], 'b');


% ----------------------------------- Basic PreProcessing ------Input: dataRaw------------
dataRaw = load('subjek5a_10.txt');
tRaw = [0:length(dataRaw)-1]/fs;
for j=chAwal:chAkhir
    dataN(:,j)=filter(b,a,dataRaw(:,j)); % dataN = data Notched
end
for j=chAwal:chAkhir
    dataNBp(:,j)=filter(h,g,dataN(:,j)); % dataN = data Notched + BP 1 - 50 Hz
end
% -------------------------------------------------------- -----Output: dataNBp------------

% ----------------------------------- BandPass M B ---------------Input: dataNBp------------
for j=chAwal:chAkhir
    dataPM(:,j)=filter(d,c,dataNBp(:,j)); % dataPM = BP 10.5 - 11.5 Hz
end
for j=chAwal:chAkhir
    dataPB(:,j)=filter(f,e,dataNBp(:,j)); % dataPB = BP 12.5 - 13.5 Hz
end
% -------------------------------------------------------- -----Output: dataPM dataPB-------



% ----------------------------------- Plotting 10.5-13.5 Hz -----Input: dataPM dataPB-------
% --- Potong Data
M1 = PSD(dataPM(601:1600,:)); M2 = PSD(dataPM(3801:4800,:)); M3 = PSD(dataPM(7001:8000,:));
B1 = PSD(dataPM(2201:3200,:)); B2 = PSD(dataPM(5401:6400,:)); B3 = PSD(dataPM(8601:length(dataPM),:));

M4 = PSD(dataPB(601:1600,:)); M5 = PSD(dataPB(3801:4800,:)); M6 = PSD(dataPB(7001:8000,:));
B4 = PSD(dataPB(2201:3200,:)); B5 = PSD(dataPB(5401:6400,:)); B6 = PSD(dataPB(8601:length(dataPB),:));

maxDataM = max([max(M1.data) max(M2.data) max(M3.data) max(M4.data) max(M5.data) max(M6.data)]);
maxDataB = max([max(B1.data) max(B2.data) max(B3.data) max(B4.data) max(B5.data) max(B6.data)]);
maxData = max([maxDataM maxDataB]);

% --- Plotting Merah
figure();
subplot(2,1,1);
plot(M1.Frequencies, M1.Data, 'y', ...
     M2.Frequencies, M2.Data, 'm', ...
     M3.Frequencies, M3.Data, 'c'     );
xlim([10.5 13.5]); ylim([0 maxData]); xlabel('Frequency (Hz)'); ylabel('data');
title({'Power Spectral Density';'Fokus : Merah';'BP: 10.5-11.5 Hz'});
legend('3-8s','19-24s','35-40s' , 'Location','best' , 'Orientation','vertical');
subplot(2,1,2);
plot(M4.Frequencies, M4.Data, 'y', ...
     M5.Frequencies, M5.Data, 'm', ...
     M6.Frequencies, M6.Data, 'c'     );
xlim([10.5 13.5]); ylim([0 maxData]); xlabel('Frequency (Hz)'); ylabel('data');
title('BP: 12.5-13.5 Hz');

% --- Plotting Biru
figure();
subplot(2,1,1);
plot(B1.Frequencies, B1.Data, 'y', ...
     B2.Frequencies, B2.Data, 'm', ...
     B3.Frequencies, B3.Data, 'c'     );
xlim([10.5 13.5]); ylim([0 maxData]); xlabel('Frequency (Hz)'); ylabel('data');
title({'Power Spectral Density';'Fokus : Biru';'BP: 10.5-11.5 Hz'});
legend('11-16s','27-32s','43-48s' , 'Location','best' , 'Orientation','vertical');
subplot(2,1,2);
plot(B4.Frequencies, B4.Data, 'y', ...
     B5.Frequencies, B5.Data, 'm', ...
     B6.Frequencies, B6.Data, 'c'     );
xlim([10.5 13.5]); ylim([0 maxData]); xlabel('Frequency (Hz)'); ylabel('data');
title('BP: 12.5-13.5 Hz');

% 	subplot(2,1,1);
% 	plot(tP,dataMean{1,i}.ans,'k' , tMB,dataMean{2,i}.ans,'r' , tMB,dataMean{3,i}.ans,'b' , tP,dataNormMA{1,i},'k-', tMB,dataNormMA{2,i}, 'r-', tMB,dataNormMA{3,i},'b-'); % dengan MA


% plotPSD(M_N,'Merah'); xlim([9 15]);
% plotPSD(B_N,'Biru'); xlim([9 15]);
%     figure;plot(data.Frequencies,data.Data);
%     title({'Power Spectral Density';sprintf('Fokus: %s',Sdata);sprintf('Avgpower : %d Hz', rataPSD)});
%     xlabel('Frequency (Hz)'); ylabel('data');
%     print(sprintf('PSD_%s',Sdata),'-dpng');


% ----------------------------Output: M[1 2 3] B[1 2 3] - M[4 5 6] B[4 5 6] -------
% ----------------------------Output: 2 plot------------------------------- -------