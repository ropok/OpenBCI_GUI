% Dari Ambil data mentah sampai plotting untuk berbagai Freq
clc;
clear;
close all;

%%Variabel
% N = Netral 	: Putih
% L = Left		: Merah
% R = Right 	: Biru
fs = 200;		% Sesuai ganglion pakai 200Hz
t = [0:399]/fs;
% Manajemen Folder
folder = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_jalerse\';
folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_jalerse\_Frekuensi\';
folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_jalerse\_FFT\';
files = dir([folder '*.txt']);
Kode = 'jalerse_1';

%% Filter
% BandPass Filter = BP1 - BP2;
BP1 = 9;
BP2 = 15;
%limit untuk Frekuensi (Hz)
BPlim1 = 13;
BPlim2 = 15;
%Limit untuk dB
dBlim1 = 0;
dBlim2 = 1.5;
%Limit untuk sekon
slim1 = 1.5;
slim2 = 3.5;

% Notch Filter 50 Hz
[b,a] = butter(2,[49 51]/(fs/2), 'stop');
% BandPass Filter
[d,c] = butter(2,[BP1 BP2]/(fs/2), 'bandpass');

%% Ambil sesuai kelas
durasi_P = 3 ; % Durasi dari Putih
durasi_MB = 5 ; % Durasi dari Merah juga Biru
detik_P = [8 16 24 32 40] ;
detik_M = [3 19 35];
detik_B = [11 27 43];

%% Temp
tempP = [];
tempM = [];
tempB = [];


% Untuk Plotting
tP = [0:(fs*durasi_P)-1]/fs; 
tMB = [0:(fs*durasi_MB)-1]/fs;
CHlist = {'CH1-Fp1' 'CH2-Fp2' 'CH3-C3' 'CH4-C4'};
KelasList = {'Putih' 'Merah' 'Biru'};

%% Ambil data dari folder, filter dan simpan dalam bentuk .mat
% csvread('D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_jalerse\jalerse11.txt');
% load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_jalerse\jalerse11.txt');
for i=1:length(files)
	csvread([folder files(i).name]);
	for i=1:4
		ans(:,i)=filter(b,a,ans(:,i));
		ans(:,i)=filter(d,c,ans(:,i));
	end
	save([folder sprintf('%s%d.mat',Kode,i)],'ans');
end

%% Potong Data per kelas
% Kelas Putih
for h=1:5
	load([folder sprintf('%s%d.mat',Kode,h)]);
	for j=1:4
		for i=1:length(detik_P)
			awal = detik_P(i)*fs+1;
			akhir = awal + (durasi_P*fs) - 1;
			temp = ans(awal:akhir,j);
			tempP = vertcat(tempP,temp);
		end
		putih(:,j) = tempP;	
		tempP = [];
	end
	for j=1:4
		for i=1:length(detik_M)
			awal = detik_M(i)*fs+1;
			akhir = awal + (durasi_MB*fs) - 1;
			temp = ans(awal:akhir,j);
			tempM = vertcat(tempM,temp);
		end
		merah(:,j) = tempM;
		tempM = [];
	end
	for j=1:4
		for i=1:length(detik_B)
			awal = detik_B(i)*fs+1;
			akhir = awal + (durasi_MB*fs) - 1;
			temp = ans(awal:akhir,j);
			tempB = vertcat(tempB,temp);
		end
		biru(:,j) = tempB;
		tempB = [];
	end
save([folder sprintf('%s%d_p.mat',Kode,h)],'putih');
save([folder sprintf('%s%d_m.mat',Kode,h)],'merah');
save([folder sprintf('%s%d_b.mat',Kode,h)],'biru');
end

for j=1:4
	tempP = [];
	tempB = [];
	tempM = [];
	for i=0:(length(putih)/(fs*durasi_P))-1
		awal = (durasi_P*fs*i)+1;
		akhir = (durasi_P*fs*i)+(durasi_P*fs);
		tempP = horzcat(putih(awal:akhir,j));
		mean(tempP,2);
		save([folder sprintf('MeanP_CH%d.mat',j)],'ans');
	end

	for i=0:(length(merah)/(fs*durasi_MB))-1
		awal = (durasi_MB*fs*i)+1;
		akhir = (durasi_MB*fs*i)+(durasi_MB*fs);
		tempM = horzcat(merah(awal:akhir,j));
		mean(tempM,2);
		save([folder sprintf('MeanM_CH%d.mat',j)],'ans');
		tempB = horzcat(biru(awal:akhir,j));
		mean(tempB,2);
		save([folder sprintf('MeanB_CH%d.mat',j)],'ans');
	end
end

%% Load Data Mean
for i=1:4
	dataMean{1,i} = load([folder sprintf('MeanP_CH%d.mat',i)]);
	dataMean{2,i} = load([folder sprintf('MeanM_CH%d.mat',i)]);
	dataMean{3,i} = load([folder sprintf('MeanB_CH%d.mat',i)]);
end

%% Plotting Per Kanal Frekuensi vs Waktu
for i=1:4
	figure(i);
	plot(tP, dataMean{1,i}.ans, tMB, dataMean{2,i}.ans, tMB, dataMean{3,i}.ans);
	legend('Putih','Merah','Biru'); 
	title(CHlist{i});
	xlabel('\fontsize{8}detik (s)');	
	xlim([slim1 slim2]);
	print([folder1 sprintf('%s_%d-%d',CHlist{i},BP1,BP2)],'-dpng');
end

% %% FFT Per Kanal
% for i=1:4 % kanal
% 	figure(i+4) % Biar bisa Barengan sama Plot
% 	for j=1:3 % kelas
% 		Ak = abs(fft(dataMean{j,i}.ans))/length(dataMean{j,i}.ans);
% 		k = 0:1:length(dataMean{j,i}.ans)-1;
% 		f = k*fs/length(dataMean{j,i}.ans);
% 		subplot(3,1,j); plot(f,Ak);
% 		xlabel('\fontsize{8}Hz');
% 		ylabel('\fontsize{8}dB');
% 		title(['\fontsize{12}' KelasList{j} '\fontsize{9}' CHlist{i}]);
% 		xlim([BPlim1 BPlim2]);
% 		% ylim([dBlim1 dBlim2]);
% 	end
% 	print([folder2 sprintf('FFT %s_%d-%d',CHlist{i},BPlim1,BPlim2)],'-dpng');
% end

% %% FFT Per Kanal  (Tanpa Putih)
% for i=1:4 % kanal
% 	figure(i+4) % Biar bisa Barengan sama Plot
% 	for j=2:3 % kelas
% 		Ak = abs(fft(dataMean{j,i}.ans))/length(dataMean{j,i}.ans);
% 		k = 0:1:length(dataMean{j,i}.ans)-1;
% 		f = k*fs/length(dataMean{j,i}.ans);
% 		subplot(2,1,j-1); plot(f,Ak);
% 		xlabel('\fontsize{8}Hz');
% 		ylabel('\fontsize{8}dB');
% 		title(['\fontsize{12}' KelasList{j} '\fontsize{9}' CHlist{i}]);
% 		xlim([BPlim1 BPlim2]);
% 		ylim([dBlim1 dBlim2]);
% 	end
% 	print([folder2 sprintf('FFT %s_%d-%d',CHlist{i},BPlim1,BPlim2)],'-dpng');
% end

%% FFT Per Kelas
for j=1:3
	figure(j+4)
	for i=1:4
		Ak = abs(fft(dataMean{j,i}.ans))/length(dataMean{j,i}.ans);
		k = 0:1:length(dataMean{j,i}.ans)-1;
		f = k*fs/length(dataMean{j,i}.ans);
		subplot(4,1,i); plot(f,Ak);
		xlabel('\fontsize{8}Hz');
		ylabel('\fontsize{8}dB');
		title(['\fontsize{12}' KelasList{j} '\fontsize{9}' CHlist{i}]);
		xlim([BPlim1 BPlim2]);
		ylim([dBlim1 dBlim2]);
	end
	print([folder2 sprintf('FFT_Warna %s_%d-%d',KelasList{j},BPlim1,BPlim2)],'-dpng');
end

% %% FFT Campur 
% 	for i=1:4
% 		Ak = abs(fft(dataMean{j,i}.ans))/length(dataMean{j,i}.ans);
% 		k = 0:1:length(dataMean{j,i}.ans)-1;
% 		f = k*fs/length(dataMean{j,i}.ans);
% 		subplot(4,1,i); plot(f,Ak);
% 		xlabel('\fontsize{8}Hz');
% 		ylabel('\fontsize{8}dB');
% 		title(['\fontsize{12}' KelasList{j} '\fontsize{9}' CHlist{i}]);
% 		xlim([BPlim1 BPlim2]);
% 		ylim([dBlim1 dBlim2]);
% 	end