% Pengolahan Data
% Input : RAW.txt 4 kolom data (4 kanal)
% Output :
%% 1. Sesi Plotting (plot.png)
%% 2. Sesi Ekstraksi ciri (ciri.mat dan target.mat)
%%%%%%%%%%%%%%%%%%%%% CONTENTS %%%%%%%%%%%%%%%%%%%%%
%% 0. Load File
%% 1. Filter Data
%% 2. Potong Data
%% 3. Gabung Data
%% 4. Normalisasi Data
%% 5. Mean - Rata-Rata

% 1. Sesi Plotting
%% 6. Load Data Mean
%% 7. Smoothing (Moving Average)
%% 8. Time Domain
%% 9. Frequency Domain
%% 10. Scattering

% 2. Sesi Ekstraksi ciri
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
subfolder = '_Sesi1+Sesi2\';
folder = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_Subjek1d\';
folder1 = [folder '_TimeDomain\' subfolder];
folder2 = [folder '_FrequencyDomain\' subfolder];
folder3 = [folder '_Scattering\' subfolder];
files = dir([folder '*.txt']);
Kode = 'subjek1d_';
startqData = 1;
endqData = 15;
% warna_putih = [0.9290 0.6940 0.1250];
% warna_merah = [0.6350 0.0780 0.1840];
% warna_biru =  [0.3010 0.7450 0.9330];
%% Filter
% % BandPass Filter = BP1 - BP2;
% BP1 = 9;
% BP2 = 15;
%limit untuk Frekuensi (Hz)
BPlim1 = 8;
BPlim2 = 42;
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
[d,c] = butter(2,[8 42]/(fs/2), 'bandpass');

%% Ambil sesuai kelas
durasi = 2 ; % Durasi dari Putih Merah Biru (Jadi satu jenis durasi saja)
detik_P = [8 16 24 32 40];
detik_M = [3 19 35];
detik_B = [11 27 43];

%% Temp
tempP = [];
tempM = [];
tempB = [];


% Untuk Plotting
tP = [0:((fs*durasi)-1)]/fs; 
tMB = [0:((fs*durasi)-1)]/fs;
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

%%%%%%%%%%%%%%%%%%%%% VARIABEL %%%%%%%%%%%%%%%%%%%%%



%% Ambil data dari folder, filter dan simpan dalam bentuk .mat
%% 0. Load File
for h=1:length(files)
	csvread([folder files(h).name]);	
%% 1. Filter Data
	for j=1:4
		ans(:,j)=filter(b,a,ans(:,j));
		ans(:,j)=filter(d,c,ans(:,j));
	end
	save([folder sprintf('%s%d.mat',Kode,h)],'ans');
end

%% 2. Potong Data
%% Potong Data per kelas
% Kelas Putih
for h=startqData:endqData
	load([folder sprintf('%s%d.mat',Kode,h)]);
	for j=1:4
		for i=1:length(detik_P)
			awal = detik_P(i)*fs+1;
			akhir = awal + (durasi*fs) - 1;
			temp = ans(awal:akhir,j);
			tempP = vertcat(tempP,temp);
		end
		putih(:,j) = tempP;	
		tempP = [];
	end
% Kelas Merah
	for j=1:4
		for i=1:length(detik_M)
			awal = detik_M(i)*fs+1;
			akhir = awal + (durasi*fs) - 1;
			temp = ans(awal:akhir,j);
			tempM = vertcat(tempM,temp);
		end
		merah(:,j) = tempM;
		tempM = [];
	end
% Kelas Biru
	for j=1:4
		for i=1:length(detik_B)
			awal = detik_B(i)*fs+1;
			akhir = awal + (durasi*fs) - 1;
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

%% 3. Gabung Data - Gabungkan semua data berdasarkan kelas
gabPutih = [];
gabMerah = [];
gabBiru = [];
for i=startqData:endqData
	ans = load([folder sprintf('%s%d_p.mat',Kode,i)]);
	gabPutih = vertcat(gabPutih, ans.putih);

	ans = load([folder sprintf('%s%d_m.mat',Kode,i)]);
	gabMerah = vertcat(gabMerah, ans.merah);

	ans = load([folder sprintf('%s%d_b.mat',Kode,i)]);
	gabBiru = vertcat(gabBiru, ans.biru);
end

% 4. Normalisasi Data
for i=1:4
	pN = gabPutih(:,i) - min(gabPutih(:,i));
	pN = pN ./ max(pN(:));
	gabPutih(:,i) = pN;

	mN = gabMerah(:,i) - min(gabMerah(:,i));
	mN = mN ./ max(mN(:));
	gabMerah(:,i) = mN;

	bN = gabBiru(:,i) - min(gabBiru(:,i));
	bN = bN ./ max(bN(:));
	gabBiru(:,i) = bN;
end

%% 5. Mean - Rata-rata
for j=1:4 % Jumlah Kanal
	tempP = [];
	tempB = [];
	tempM = [];
		% Mengumpulkan barisan data yang mau dirata-rata
	for i=0:(length(gabPutih)/(fs*durasi))-1
		awal = (durasi*fs*i)+1;
		akhir = (durasi*fs*i)+(durasi*fs);
		tempP = horzcat(tempP,gabPutih(awal:akhir,j));
	end
		% Rata-rata dari Putih
		mean(tempP,2);
		save([folder sprintf('MeanP_CH%d.mat',j)],'ans');
		% Mengumpulkan barisan data yang mau dirata-rata
	for i=0:(length(gabMerah)/(fs*durasi))-1
		awal = (durasi*fs*i)+1;
		akhir = (durasi*fs*i)+(durasi*fs);
		tempM = horzcat(tempM,gabMerah(awal:akhir,j));
		tempB = horzcat(tempB,gabBiru(awal:akhir,j));
	end
		% Rata-rata dari Merah dan Biru
		mean(tempM,2);
		save([folder sprintf('MeanM_CH%d.mat',j)],'ans');
		mean(tempB,2);
		save([folder sprintf('MeanB_CH%d.mat',j)],'ans');
end


%% 6. Load Data Mean
for i=1:4
	dataMean{1,i} = load([folder sprintf('MeanP_CH%d.mat',i)]); % Putih
	dataMean{2,i} = load([folder sprintf('MeanM_CH%d.mat',i)]); % Merah
	dataMean{3,i} = load([folder sprintf('MeanB_CH%d.mat',i)]); % Biru
end

%% 7. Smoothing (Moving Average)  - Mean ter Normalisasi
% Smoothing Session (Moving Average)
for i=1:4
	dataNormMA{1,i} = smooth(tP, dataMean{1,i}.ans, span, sMethod); % Putih
	dataNormMA{2,i} = smooth(tMB, dataMean{2,i}.ans, span, sMethod);    % Merah
	dataNormMA{3,i} = smooth(tMB, dataMean{3,i}.ans, span, sMethod);    % Biru
end

%% 8. Time Domain (Plotting Per Kanal) - Mean ter Normalisasi
for i=1:4
	figure(i);
	% set('defaultAxesColorOrder',[warna_putih; warna_merah; warna_biru]);
	% plot(tP,dataNorm{1,i},'k' ], tMB,dataNorm{2,i},'r' , tMB,dataNorm{3,i},'b'); % Tanpa MA
	subplot(2,1,1);
	plot(tP,dataMean{1,i}.ans,'k' , tMB,dataMean{2,i}.ans,'r' , tMB,dataMean{3,i}.ans,'b' , tP,dataNormMA{1,i},'k-', tMB,dataNormMA{2,i}, 'r-', tMB,dataNormMA{3,i},'b-'); % dengan MA
	title(CHlist{i});
	% plot(tP, dataNorm{1,i}, tMB, dataNorm{2,i}, tMB, dataNorm{3,i}, tP, dataNormMA{1,i}, 'c-', tMB, dataNormMA{2,i}, 'm-', tMB, dataNormMA{3,i}, 'y-');
	subplot(2,1,2);
	plot(tP, dataNormMA{1,i},'k' , tMB,dataNormMA{2,i},'r' , tMB,dataNormMA{3,i},'b'); % MA saja
	xlabel('\fontsize{8}detik (s)');	
	% xlim([slim1 slim2]);
	% ylim([ylim1 ylim2]);
	legend('Putih','Merah','Biru' , 'Location','southoutside' , 'Orientation','horizontal');
	print([folder1 sprintf('NN_%s_9-15_MA',CHlist{i})],'-dpng');
end

%% 9. Frequency Domain (Plotting Per Kanal) - Mean ter Normalisasi
for i=1:4 % kanal
	figure(i+4)
	for j=1:3 % kelas
		dataDiFFT = dataMean{j,i}.ans;
		Ak = abs(fft(dataDiFFT))/length(dataDiFFT);
		k = 0:1:length(dataDiFFT)-1;
		f = k*fs/length(dataDiFFT);
		subplot(3,1,j); plot(f,Ak);
		xlabel('\fontsize{8}Hz');
		ylabel('\fontsize{8}dB');
		title(['\fontsize{12}' KelasList{j} '\fontsize{9}' CHlist{i}]);
		xlim([BPlim1 BPlim2]);
		% ylim([dBlim1 dBlim2]);
	end
	print([folder2 sprintf('FFT %s_%d-%d',CHlist{i},BPlim1,BPlim2)],'-dpng');
end

%% 10. Scattering - Mean ter Normalisasi
for i=1:6
    figure(i+8);
    hold on
   scatter(dataMean{3,sc1(i)}.ans,dataMean{3,sc2(i)}.ans,'or'); % Biru
   scatter(dataMean{2,sc1(i)}.ans,dataMean{2,sc2(i)}.ans,'*b'); % Merah
   scatter(dataMean{1,sc1(i)}.ans,dataMean{1,sc2(i)}.ans,'xk'); % Putih
    hold off
   xlabel(sprintf('CH%d : %s', sc1(i), sc1_name{i}));
   ylabel(sprintf('CH%d : %s', sc2(i), sc2_name{i}));
   legend( 'Merah', 'Biru','Putih', 'Location', 'northeastoutside');
   % legend( 'Merah', 'Location', 'northeastoutside');
   % legend( 'Biru', 'Location', 'northeastoutside');
   % legend( 'Putih', 'Location', 'northeastoutside');
   judulFile = sprintf('CH%d vs CH%d', sc1(i), sc2(i));
   % judulFileSave = sprintf('%s_:_CH%d_vs_CH%d_(Mean)', data_label, sc1(i), sc2(i));
   title(judulFile);
   % print(sprintf('%s-CH%d vs CH%d (Mean)', data_label, sc1(i), sc2(i)), '-dpng');
	print([folder3 'Scattering Mean ' judulFile],'-dpng');
end