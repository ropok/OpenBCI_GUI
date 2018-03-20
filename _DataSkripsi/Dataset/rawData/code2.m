
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
% === SETELAH DIPOTONG 3 Detik Awal ===
% 3*200 = 600 (Fs)
% Jeda = [5 8, 13 16, 21 24, 29 32, 37 40]
% Merah = [0 5, 16 21, 32 37]
% Biru  = [8 13, 24 29, 40 45]
% vline([0 5 16 21 32 37], 'r');
% vline([8 13 24 29 40 45], 'b');


% ----------------------------------- Basic PreProcessing ------Input: dataRaw-------
dataRaw = load('subjek5a_1.txt');
tRaw = [0:length(dataRaw)-1]/fs;
for j=chAwal:chAkhir
    dataN(:,j)=filter(b,a,dataRaw(:,j)); % dataN = data Notched
end
for j=chAwal:chAkhir
    dataNBp(:,j)=filter(h,g,dataN(:,j)); % dataN = data Notched + BP 1 - 50 Hz
end
% -------------------------------------------------------- -----Output: dataNBp-------

for j=chAwal:chAkhir
    dataP(:,j) = dataNBp(601:length(dataNBp),j); % potong data 3 detik awal (3*200 = 600) - Fs=200Hz
end
tP = [0:length(dataP)-1]/fs;


% function Hpsd = PSD(data)
%     %% PSD - Power Spectral Density
%     Pxx = abs(fft(data)).^2/length(data)/fs;
%     Hpsd = dspdata.psd(Pxx(1:length(Pxx)/2), 'Fs',fs);
%     % %rata-rata PSD
%     % rataPSD{j,i} = avgpower(Hpsd);
% end
% figure;plot(Hpsd.Frequencies,Hpsd.Data);

% for j=chAwal:chAkhir
%     data(:,j)=dataRaw(600:length(dataRaw),j); % potong data jeda di awal  
% end

% for j=chAwal:chAkhir
%     dataN(:,j)=filter(b,a,data(:,j)); % dataN = data Notched
% end

% % ----------------------------
% for j=chAwal:chAkhir
%     dataN(:,j)=filter(h,g,dataN(:,j)); % dataN = data Notched + BP 1 - 50 Hz
% end


% for j=chAwal:chAkhir
%     dataRaw(:,j) = dataR(601:length(dataR),j); % potong data 3 detik awal (3*200 = 600) - Fs=200Hz
% end
% % detik_P = [8 16 24 32 40];
% durasi = 5;
% detik_M = [3 19 35];
% detik_B = [11 27 43];

% %% 2. Potong Data
% %% Potong Data per kelas
% % Kelas Putih
% for h=startqData:endqData
% 	load([folder sprintf('%s%d.mat',Kode,h)]);
% 	for j=1:4
% 		for i=1:length(detik_P)
% 			awal = detik_P(i)*fs+1;
% 			akhir = awal + (durasi*fs) - 1;
% 			temp = ans(awal:akhir,j);
% 			tempP = vertcat(tempP,temp);
% 		end
% 		putih(:,j) = tempP;	
% 		tempP = [];
% 	end
% % Kelas Merah
% 	for j=1:4
% 		for i=1:length(detik_M)
% 			awal = detik_M(i)*fs+1;
% 			akhir = awal + (durasi*fs) - 1;
% 			temp = ans(awal:akhir,j);
% 			tempM = vertcat(tempM,temp);
% 		end
% 		merah(:,j) = tempM;
% 		tempM = [];
% 	end
% % Kelas Biru
% 	for j=1:4
% 		for i=1:length(detik_B)
% 			awal = detik_B(i)*fs+1;
% 			akhir = awal + (durasi*fs) - 1;
% 			temp = ans(awal:akhir,j);
% 			tempB = vertcat(tempB,temp);
% 		end
% 		biru(:,j) = tempB;
% 		tempB = [];
% 	end
% save([folder sprintf('%s%d_p.mat',Kode,h)],'putih');
% save([folder sprintf('%s%d_m.mat',Kode,h)],'merah');
% save([folder sprintf('%s%d_b.mat',Kode,h)],'biru');
% end