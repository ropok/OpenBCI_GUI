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
files = dir([folder '*.txt']);
Kode = 'jalerse_1';

%% Filter
% BandPass Filter = BP1 - BP2;
BP1 = 9;
BP2 = 15;
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