% Dari Ambil data mentah sampai plotting untuk berbagai Freq
clc;
clear;
close all;

%%Variabel
% N = Netral 	: Putih
% L = Left		: Merah (11 Hz)
% R = Right 	: Biru (13 Hz)
fs = 200;		% Sesuai ganglion pakai 200Hz
t = [0:399]/fs;
% Manajemen Folder
folder = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_jalerse\';
folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_jalerse\_Frekuensi\';
folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_jalerse\_FFT\';
files = dir([folder '*.txt']);
Kode = 'jalerse_1';
% warna_putih = [0.9290 0.6940 0.1250];
% warna_merah = [0.6350 0.0780 0.1840];
% warna_biru =  [0.3010 0.7450 0.9330];
%% Filter
% % BandPass Filter = BP1 - BP2;
% BP1 = 9;
% BP2 = 15;
%limit untuk Frekuensi (Hz)
BPlim1 = 9;
BPlim2 = 15;
%Limit untuk dB
dBlim1 = 0;
dBlim2 = 0.02;
%Limit untuk x di time-domain
% slim1 = 0.5;
% slim2 = 4.5;
%Limit untuk y di time-domain
ylim1 = 0;
ylim2 = 0.6;

% Notch Filter 50 Hz
[b,a] = butter(2,[49 51]/(fs/2), 'stop');
% BandPass Filter
[d,c] = butter(2,[9 15]/(fs/2), 'bandpass');

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
tP = [0:((fs*durasi_P)-1)]/fs; 
tMB = [0:((fs*durasi_MB)-1)]/fs;
CHlist = {'CH1-Fp1' 'CH2-Fp2' 'CH3-C3' 'CH4-C4'};
KelasList = {'Putih' 'Merah' 'Biru'};
warnaPlotList = {'k' 'r' 'b'};

% Smoothing - Moving Average
span = 0.9;
span2 = 0.1;
sMethod = 'moving';

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


for j=1:3
	for i=1:4
		dataMean{j,i}.ans - min(dataMean{j,i}.ans);
		ans = ans ./ max(ans(:));
		% save([folder sprintf('norm%s_CH%d.mat',KelasList{j},i)], 'ans');
		dataNorm{j,i}=ans;
	end
end
save([folder 'dataNorm.mat'], 'dataNorm');

% Smoothing Session (Moving Average)
for i=1:4
	dataNormMA{1,i} = smooth(tP, dataNorm{1,i}, span, sMethod);
	dataNormMA{2,i} = smooth(tMB, dataNorm{2,i}, span, sMethod);
	dataNormMA{3,i} = smooth(tMB, dataNorm{3,i}, span, sMethod);
end

% %% Plotting Per Kanal (Time Domain)
% for i=1:4
% 	figure(i);
% 	% set('defaultAxesColorOrder',[warna_putih; warna_merah; warna_biru]);
% 	% plot(tP,dataNorm{1,i},'k' , tMB,dataNorm{2,i},'r' , tMB,dataNorm{3,i},'b'); % Tanpa MA
% 	subplot(2,1,1);
% 	plot(tP,dataNorm{1,i},'k' , tMB,dataNorm{2,i},'r' , tMB,dataNorm{3,i},'b' , tP,dataNormMA{1,i},'k-', tMB,dataNormMA{2,i}, 'r-', tMB,dataNormMA{3,i},'b-'); % dengan MA
% 	title(CHlist{i});
% 	% plot(tP, dataNorm{1,i}, tMB, dataNorm{2,i}, tMB, dataNorm{3,i}, tP, dataNormMA{1,i}, 'c-', tMB, dataNormMA{2,i}, 'm-', tMB, dataNormMA{3,i}, 'y-');
% 	subplot(2,1,2);
% 	plot(tP, dataNormMA{1,i},'k' , tMB,dataNormMA{2,i},'r' , tMB,dataNormMA{3,i},'b'); % MA saja
% 	xlabel('\fontsize{8}detik (s)');	
% 	% xlim([slim1 slim2]);
% 	% ylim([ylim1 ylim2]);
% 	legend('Putih','Merah','Biru' , 'Location','southoutside' , 'Orientation','horizontal');
% 	print([folder1 sprintf('%s_9-15_MA',CHlist{i})],'-dpng');
% end

% %% FFT Per Kanal (Frequency Domain - Gabung satu kotak plot)
% for i=1:4 % kanal
% 	figure(i+4) % Biar bisa Barengan sama Plot
% 	for j=1:3 % kelas
% 		Ak = abs(fft(dataNorm{j,i}))/length(dataNorm{j,i});
% 		k = 0:1:length(dataNorm{j,i})-1;
% 		f = k*fs/length(dataNorm{j,i});
% 		hold on; 
% 		plot(f,Ak,warnaPlotList{j});
% 		% set(gca, 'ytick', 0:1e5:18e-3);
% 	end
% 	hold off;	
% 	xlabel('\fontsize{8}Hz');
% 	ylabel('\fontsize{8}dB');
% 	title(['\fontsize{9}' CHlist{i}]);
% 	xlim([BPlim1 BPlim2]);
% 	% ylim([dBlim1 dBlim2]);
% 	legend('Merah','Biru' , 'Location','northeast' , 'Orientation','horizontal');
% 	print([folder2 sprintf('FFT %s_%d-%d',CHlist{i},BPlim1,BPlim2)],'-dpng');
% end

%% FFT Per Kanal (Frequency Domain)
for i=1:4 % kanal
	figure(i+4) % Biar bisa Barengan sama Plot
	for j=1:3 % kelas
		Ak = abs(fft(dataNorm{j,i}))/length(dataNorm{j,i});
		k = 0:1:length(dataNorm{j,i})-1;
		f = k*fs/length(dataNorm{j,i});
		subplot(3,1,j); plot(f,Ak);
		xlabel('\fontsize{8}Hz');
		ylabel('\fontsize{8}dB');
		title(['\fontsize{12}' KelasList{j} '\fontsize{9}' CHlist{i}]);
		xlim([BPlim1 BPlim2]);
		% ylim([dBlim1 dBlim2]);
	end
	print([folder2 sprintf('FFT %s_%d-%d',CHlist{i},BPlim1,BPlim2)],'-dpng');
end


% %% FFT Per Kelas
% for j=1:3
% 	figure(j+4)
% 	for i=1:4
% 		Ak = abs(fft(dataNorm{j,i}))/length(dataNorm{j,i});
% 		k = 0:1:length(dataNorm{j,i})-1;
% 		f = k*fs/length(dataNorm{j,i});
% 		subplot(4,1,i); plot(f,Ak);
% 		xlabel('\fontsize{8}Hz');
% 		ylabel('\fontsize{8}dB');
% 		title(['\fontsize{12}' KelasList{j} '\fontsize{9}' CHlist{i}]);
% 		xlim([BPlim1 BPlim2]);
% 		ylim([dBlim1 dBlim2]);
% 	end
% 	print([folder2 sprintf('FFT_Warna %s_%d-%d',KelasList{j},BPlim1,BPlim2)],'-dpng');
% end

% %% FFT Campur 
% 	for i=1:4
% 		Ak = abs(fft(dataNorm{j,i}))/length(dataNorm{j,i});
% 		k = 0:1:length(dataNorm{j,i})-1;
% 		f = k*fs/length(dataNorm{j,i});
% 		subplot(4,1,i); plot(f,Ak);
% 		xlabel('\fontsize{8}Hz');
% 		ylabel('\fontsize{8}dB');
% 		title(['\fontsize{12}' KelasList{j} '\fontsize{9}' CHlist{i}]);
% 		xlim([BPlim1 BPlim2]);
% 		ylim([dBlim1 dBlim2]);
% 	end

% %% FFT Per Kanal  (Tanpa Putih)
% for i=1:4 % kanal
% 	figure(i+4) % Biar bisa Barengan sama Plot
% 	for j=2:3 % kelas
% 		Ak = abs(fft(dataNorm{j,i}))/length(dataNorm{j,i});
% 		k = 0:1:length(dataNorm{j,i})-1;
% 		f = k*fs/length(dataNorm{j,i});
% 		subplot(2,1,j-1); plot(f,Ak);
% 		xlabel('\fontsize{8}Hz');
% 		ylabel('\fontsize{8}dB');
% 		title(['\fontsize{12}' KelasList{j} '\fontsize{9}' CHlist{i}]);
% 		xlim([BPlim1 BPlim2]);
% 		ylim([dBlim1 dBlim2]);
% 	end
% 	print([folder2 sprintf('FFT %s_%d-%d',CHlist{i},BPlim1,BPlim2)],'-dpng');
% end
