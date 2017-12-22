% Dari Ambil data mentah sampai plotting untuk berbagai Freq
%%%%%%%%%%%%%%%%%%%%% CONTENTS %%%%%%%%%%%%%%%%%%%%%
%% 0. Load File
%% 1. Filter Data
%% 2. Potong Data + Normalisasi
%% 3. Ekstraksi Ciri

%% 3. Mean - Rata rata
%% 4. Load Data Mean
%% 5. Normalisasi
%% 6. Smoothing (Moving Average)
%% 7. Time Domain
%% 8. Frequency Domain
%% 9. Scattering
%%%%%%%%%%%%%%%%%%%%% .JALERSE %%%%%%%%%%%%%%%%%%%%%

%%% %%%
% dataNorm{1,:} = putih
% dataNorm{2,:} = merah
% dataNorm{3,:} = biru
%%% %%%

close all;
clear;
clc;

%%%%%%%%%%%%%%%%%%%%% VARIABEL %%%%%%%%%%%%%%%%%%%%%
% N = Netral 	: Putih
% L = Left		: Merah (11 Hz)
% R = Right 	: Biru (13 Hz)
fs = 200;		% Sesuai ganglion pakai 200Hz
% t = [0:399]/fs;
% Manajemen Folder
folder = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_Subjek1b\';
folder1 = [folder '_Frekuensi\'];
folder2 = [folder '_FFT\'];
folder3 = [folder '_Scattering\'];
folder4 = [folder '_Ciri\'];
files = dir([folder '*.txt']);
Kode = 'Subjek1_';
qData = 10;
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
durasi_P = 2 ; % Durasi dari Putih
durasi_MB = 2 ; % Durasi dari Merah juga Biru
durasi = 2; % Putih Merah Biru disetarakan
detik_P = [8 16 24 32 40];
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
span = 0.5;
span2 = 0.1;
sMethod = 'moving';

% Scattering - Variable
sc1 = [1 1 1 2 2 3];
sc2 = [2 3 4 3 4 4];
sc1_name = {'Fp1' 'Fp1' 'Fp1' 'Fp2' 'Fp2' 'C3'};
sc2_name = {'Fp2' 'C3'  'C4'  'C3'  'C4'  'C4'};

%  Membuat dataset
ciri_dataset = [];
set1 = {'Putih' 'Merah' 'Biru'};
set2 = {'mean' 'min' 'max' 'dif' 'rel' 'pc'};
tempset1 = [];
tempset2 = [];
% Tabel Labeling
labelCiri = {};
t_putih = [1;0;0];
t_merah = [0;1;0];
t_biru  = [0;0;1];
target = [];
tq_putih = 50;
tq_merah = 30;
tq_biru  = 30;

%%%%%%%%%%%%%%%%%%%%% VARIABEL %%%%%%%%%%%%%%%%%%%%%


%% 0. Load File
%% 1. Filter Data
%% Ambil data dari folder, filter dan simpan dalam bentuk .mat
% csvread('D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_Subjek1\Subjek111.txt');
% load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_Subjek1\Subjek111.txt');
for i=1:length(files)
	csvread([folder files(i).name]);
	for j=1:4
		ans(:,j)=filter(b,a,ans(:,j));
		ans(:,j)=filter(d,c,ans(:,j));
	end
	save([folder sprintf('%s%d.mat',Kode,i)],'ans');
end

%% 2. Potong Data + Normalisasi
%% per kelas, jadikan cell: 1 kotak = 1x400 (2 detik data)
for h=1:qData
load([folder sprintf('%s%d.mat',Kode,h)]);
	% Putih
	for j=1:4
		baris = 1 + ((h-1)*5); %agar bisa lanjut dari data-data yang lain
		for i=1:length(detik_P)
			awal = detik_P(i)*fs+1;
			akhir = awal + (durasi*fs) - 1;
			putih{baris,j} = ans(awal:akhir,j);
			% %Normalisasi
			% pN = putih{baris,j} - min(putih{baris,j});
			% pN = pN ./ max(pN(:));
			% putih{baris,j} = pN;

			baris = baris + 1;
		end
	end

	%Merah
	for j=1:4
		baris = 1 + ((h-1)*3); %agar bisa lanjut dari data-data yang lain
		for i=1:length(detik_M)
			awal = detik_M(i)*fs+1;
			akhir = awal + (durasi*fs) - 1;
			merah{baris,j} = ans(awal:akhir,j);
			% %Normalisasi
			% mN = merah{baris,j} - min(merah{baris,j});
			% mN = mN ./ max(mN(:));
			% merah{baris,j} = mN;

			baris = baris + 1;
		end
	end

	%Biru
	for j=1:4
		baris = 1 + ((h-1)*3); %agar bisa lanjut dari data-data yang lain
		for i=1:length(detik_B)
			awal = detik_B(i)*fs+1;
			akhir = awal + (durasi*fs) - 1;
			biru{baris,j} = ans(awal:akhir,j);
			% %Normalisasi
			% bN = biru{baris,j} - min(biru{baris,j});
			% bN = bN ./ max(bN(:));
			% biru{baris,j} = bN;

			baris = baris + 1;
		end
	end	
end
save([folder sprintf('%s_pN.mat',Kode)],'putih');
save([folder sprintf('%s_mN.mat',Kode)],'merah');
save([folder sprintf('%s_bN.mat',Kode)],'biru');

%% 3. Ekstraksi Ciri
for j=1:4
	%Putih
	for i=1:length(putih)
		mean_Putih{i,j}=mean(putih{i,j});
		min_Putih{i,j}=min(putih{i,j});
		max_Putih{i,j}=max(putih{i,j});
		dif_Putih{i,j}=max(putih{i,j})-min(putih{i,j});
		rel_Putih{i,j}=max(putih{i,j})/min(putih{i,j});
		pc_Putih{i,j}=dif_Putih{i,j}/min_Putih{i,j};
	end

	%Merah
	for i=1:length(merah)
		mean_Merah{i,j}=mean(merah{i,j});
		min_Merah{i,j}=min(merah{i,j});
		max_Merah{i,j}=max(merah{i,j});
		dif_Merah{i,j}=max(merah{i,j})-min(merah{i,j});
		rel_Merah{i,j}=max(merah{i,j})/min(merah{i,j});
		pc_Merah{i,j}=dif_Merah{i,j}/min_Merah{i,j};
	end

	%Biru
	for i=1:length(biru)
		mean_Biru{i,j}=mean(biru{i,j});
		min_Biru{i,j}=min(biru{i,j});
		max_Biru{i,j}=max(biru{i,j});
		dif_Biru{i,j}=max(biru{i,j})-min(biru{i,j});
		rel_Biru{i,j}=max(biru{i,j})/min(biru{i,j});
		pc_Biru{i,j}=dif_Biru{i,j}/min_Biru{i,j};
	end

end
	ciri_Putih.mean = cell2mat(mean_Putih);
	ciri_Putih.min = cell2mat(min_Putih);
	ciri_Putih.max = cell2mat(max_Putih);
	ciri_Putih.dif = cell2mat(dif_Putih);
	ciri_Putih.rel = cell2mat(rel_Putih);
	ciri_Putih.pc = cell2mat(pc_Putih);

	ciri_Merah.mean = cell2mat(mean_Merah);
	ciri_Merah.min = cell2mat(min_Merah);
	ciri_Merah.max = cell2mat(max_Merah);
	ciri_Merah.dif = cell2mat(dif_Merah);
	ciri_Merah.rel = cell2mat(rel_Merah);
	ciri_Merah.pc = cell2mat(pc_Merah);

	ciri_Biru.mean = cell2mat(mean_Biru);
	ciri_Biru.min = cell2mat(min_Biru);
	ciri_Biru.max = cell2mat(max_Biru);
	ciri_Biru.dif = cell2mat(dif_Biru);
	ciri_Biru.rel = cell2mat(rel_Biru);
	ciri_Biru.pc = cell2mat(pc_Biru);


for i=1:length(set1) % Putih Merah Biru
	for j=1:length(set2) % Ciri dan Ciri
		for k=1:4
			% eval() untuk baca variabel matlab dalam input string
			transpose(eval(sprintf('ciri_%s.%s(:,%d)',set1{i},set2{j},k)));
			tempset1 = vertcat(tempset1,ans);
		end
	end
	ciri_dataset = horzcat(ciri_dataset,tempset1);
	tempset1 = [];
end
save([folder sprintf('%sciriDataset.mat',Kode)],'ciri_dataset');

for i=1:tq_putih
	target = [target t_putih];
end
for i=1:tq_merah
	target = [target t_merah];
end
for i=1:tq_biru
	target = [target t_biru];
end


% Putih = ciri_dataset(:,1:50);
% Merah = ciri_dataset(:,51:80);
% Biru = ciri_dataset(:,81:110);
% % Loop untuk pelabelan Baris (ciri channel 1 - 4)
% for i=1:length(set2)
% 	for j=1:4
% 		labelCiri = [labelCiri, sprintf('%s-CH%d',set2{i},j)];
% 	end
% end
% ciri_dataset_Table = table(Putih, Merah, Biru, 'RowNames', labelCiri);