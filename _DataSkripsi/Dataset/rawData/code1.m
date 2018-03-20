
close all;
clear;
clc;

% static
fs = 200;
[b,a] = butter(2,[49 51]/(fs/2), 'stop');           % Notch
[h,g] = butter(2,[1 50]/(fs/2), 'bandpass');   % Filter awal 1-50 Hz
[d,c] = butter(2,[10.5 11.5]/(fs/2), 'bandpass');   % Merah - 11 Hz
[f,e] = butter(2,[12.5 13.5]/(fs/2), 'bandpass');   % Biru  - 13 Hz

% durasi
durasiAwal = 27;
durasiAkhir = 32;
chAwal = 1;
chAkhir = 4;
%% [Awal Akhir,...]
% Jeda = [0 3, 8 11, 16 19, 24 27, 32 35, 40 43]
% Merah = [3 8, 19 24, 35 40]
% Biru  = [11 16, 27 32, 43 48]


dataRaw = load('subjek2b_2.txt');

for j=chAwal:chAkhir
    data(:,j)=dataRaw(600:length(dataRaw),j); % potong data jeda di awal
end

for j=chAwal:chAkhir
    dataN(:,j)=filter(b,a,data(:,j)); % dataN = data Notched
end

% ----------------------------
for j=chAwal:chAkhir
    dataN(:,j)=filter(h,g,dataN(:,j)); % dataN = data Notched + BP 1 - 50 Hz
end

% for j=chAwal:chAkhir
% 	pN = dataN(:,j) - min(dataN(:,j)); % Normalisasi
% 	pN = pN ./ max(pN(:));
% 	dataN(:,j) = pN;
% end

% -----------------------------
t = [0:length(data)-1]/fs;
figure; plot(t, dataN);

awal = durasiAwal*fs+1;
akhir = durasiAkhir*fs;

dataP = dataN(awal:akhir,:); % dataP = data Potong
tP = [0:length(dataP)-1]/fs; % tP = time Potong
tP = tP+durasiAwal; % Menyesuaikan letak potongan data
for j=chAwal:chAkhir
    dataM(:,j)=filter(d,c,dataP(:,j));
    dataB(:,j)=filter(f,e,dataP(:,j));
end

% Figure Time Domain
figure; plot(tP, dataP);
figure; plot(tP, dataM);
figure; plot(tP, dataB);

% FFT

AkP = abs(fft(dataP))/length(dataP);
kP = 0:1:length(dataP)-1;
fP = kP*fs/length(dataP);

AkM = abs(fft(dataM))/length(dataM);
kM = 0:1:length(dataM)-1;
fM = kM*fs/length(dataM);

AkB = abs(fft(dataB))/length(dataB);
kB = 0:1:length(dataB)-1;
fB = kB*fs/length(dataB);

% Figure Frequency Domain
figure; plot(fP, AkP); xlim([1 50]);
% figure; plot(fM, AkM); xlim([10 14]);% title({'Frequency Domain';'Fokus Merah(3-8s)';'BP : 10.5-11.5 Hz'});
% figure; plot(fB, AkB); xlim([10 14]);% title({'Frequency Domain';'Fokus Merah(3-8s)';'BP : 12.5-13.5 Hz'});



% % PSD - Mudin
% %% datatemp = data
% Pxx = abs(fft(datatemp)).^2/length(datatemp)/fs;
% Hspd = dspdata.psd(Pxx(1:length(Pxx)/2), 'Fs',fs);

% %rata-rata PSD
% rataPSD{j,i} = avgpower(Hpsd);