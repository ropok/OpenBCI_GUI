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
			transpose(sprintf('ciri_%s.%s(:,%d)',set1{i},set2{j},k));
			tempset1 = vertcat(tempset1,ans);
		end
	end
end
%% %% 9. Scattering Semuanya
% for i=1:6
%     figure(i);
%     hold on
%    scatter(ciri_Merah.mean(:,sc1(i)),ciri_Merah.mean(:,sc2(i)),'or');
%    scatter(ciri_Merah.min(:,sc1(i)),ciri_Merah.min(:,sc2(i)),'or');
%    scatter(ciri_Merah.max(:,sc1(i)),ciri_Merah.max(:,sc2(i)),'or');
%    scatter(ciri_Merah.dif(:,sc1(i)),ciri_Merah.dif(:,sc2(i)),'or');
%    scatter(ciri_Merah.rel(:,sc1(i)),ciri_Merah.rel(:,sc2(i)),'or');
%    scatter(ciri_Merah.pc(:,sc1(i)),ciri_Merah.pc(:,sc2(i)),'or');

%    scatter(ciri_Biru.mean(:,sc1(i)),ciri_Biru.mean(:,sc2(i)),'*b');
%    scatter(ciri_Biru.min(:,sc1(i)),ciri_Biru.min(:,sc2(i)),'*b');
%    scatter(ciri_Biru.max(:,sc1(i)),ciri_Biru.max(:,sc2(i)),'*b');
%    scatter(ciri_Biru.dif(:,sc1(i)),ciri_Biru.dif(:,sc2(i)),'*b');
%    scatter(ciri_Biru.rel(:,sc1(i)),ciri_Biru.rel(:,sc2(i)),'*b');
%    scatter(ciri_Biru.pc(:,sc1(i)),ciri_Biru.pc(:,sc2(i)),'*b');

%    scatter(ciri_Putih.mean(:,sc1(i)),ciri_Putih.mean(:,sc2(i)),'xk');
%    scatter(ciri_Putih.min(:,sc1(i)),ciri_Putih.min(:,sc2(i)),'xk');
%    scatter(ciri_Putih.max(:,sc1(i)),ciri_Putih.max(:,sc2(i)),'xk');
%    scatter(ciri_Putih.dif(:,sc1(i)),ciri_Putih.dif(:,sc2(i)),'xk');
%    scatter(ciri_Putih.rel(:,sc1(i)),ciri_Putih.rel(:,sc2(i)),'xk');
%    scatter(ciri_Putih.pc(:,sc1(i)),ciri_Putih.pc(:,sc2(i)),'xk');
%     hold off
%    xlabel(sprintf('%s', sc1_name{i}));
%    ylabel(sprintf('%s', sc2_name{i}));
%    % legend( 'Merah', 'Biru','Putih', 'Location', 'northeastoutside');
%    % legend( 'Merah', 'Location', 'northeastoutside');
%    % legend( 'Biru', 'Location', 'northeastoutside');
%    % legend( 'Putih', 'Location', 'northeastoutside');
%    judulFile = sprintf('%s vs %s', sc1_name{i}, sc2_name{i});
%    % judulFileSave = sprintf('%s_:_CH%d_vs_CH%d_(Mean)', data_label, sc1(i), sc2(i));
%    title(judulFile);
%    % print(sprintf('%s-CH%d vs CH%d (Mean)', data_label, sc1(i), sc2(i)), '-dpng');
% 	print([folder4 'Scattering ' judulFile],'-dpng');
% end

% %% 2. Potong Data
% %% Potong Data per kelas
% % Kelas Putih
% for h=1:qData
% 	load([folder sprintf('%s%d.mat',Kode,h)]);
% 	for j=1:4
% 		for i=1:length(detik_P)
% 			awal = detik_P(i)*fs+1;
% 			akhir = awal + (durasi_P*fs) - 1;
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
% 			akhir = awal + (durasi_MB*fs) - 1;
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
% 			akhir = awal + (durasi_MB*fs) - 1;
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

% %% 5. Normalisasi
% for j=1:3
% 	for i=1:4
% 		dataMean{j,i}.ans - min(dataMean{j,i}.ans);
% 		ans = ans ./ max(ans(:));
% 		% save([folder sprintf('norm%s_CH%d.mat',KelasList{j},i)], 'ans');
% 		dataNorm{j,i}=ans;
% 	end
% end
% save([folder 'dataNorm.mat'], 'dataNorm');
% %Normalisasi untuk Scattering
% for i=1:4
% 	pN = gabPutih(:,i) - min(gabPutih(:,i));
% 	pN = pN ./ max(pN(:));
% 	putihNorm(:,i) = pN;

% 	mN = gabMerah(:,i) - min(gabMerah(:,i));
% 	mN = mN ./ max(mN(:));
% 	merahNorm(:,i) = mN;

% 	bN = gabBiru(:,i) - min(gabBiru(:,i));
% 	bN = bN ./ max(bN(:));
% 	biruNorm(:,i) = bN;
% end

% %% Coba gabungkan semua
% % Putih
% gabPutih = [];
% gabMerah = [];
% gabBiru = [];
% for i=1:qData
% 	ans = load([folder sprintf('%s%d_p.mat',Kode,i)]);
% 	gabPutih = vertcat(gabPutih, ans.putih);

% 	ans = load([folder sprintf('%s%d_m.mat',Kode,i)]);
% 	gabMerah = vertcat(gabMerah, ans.merah);

% 	ans = load([folder sprintf('%s%d_b.mat',Kode,i)]);
% 	gabBiru = vertcat(gabBiru, ans.biru);
% end

% %% 3. Mean - Rata rata
% for j=1:4 % Jumlah Kanal
% 	tempP = [];
% 	tempB = [];
% 	tempM = [];
% 		% Mengumpulkan barisan data yang mau dirata-rata
% 	for i=0:(length(gabPutih)/(fs*durasi_P))-1
% 		awal = (durasi_P*fs*i)+1;
% 		akhir = (durasi_P*fs*i)+(durasi_P*fs);
% 		tempP = horzcat(tempP,gabPutih(awal:akhir,j));
% 	end
% 		% Rata-rata dari Putih
% 		mean(tempP,2);
% 		save([folder sprintf('MeanP_CH%d.mat',j)],'ans');
% 		% Mengumpulkan barisan data yang mau dirata-rata
% 	for i=0:(length(gabMerah)/(fs*durasi_MB))-1
% 		awal = (durasi_MB*fs*i)+1;
% 		akhir = (durasi_MB*fs*i)+(durasi_MB*fs);
% 		tempM = horzcat(tempM,gabMerah(awal:akhir,j));
% 		tempB = horzcat(tempB,gabBiru(awal:akhir,j));
% 	end
% 		% Rata-rata dari Merah dan Biru
% 		mean(tempM,2);
% 		save([folder sprintf('MeanM_CH%d.mat',j)],'ans');
% 		mean(tempB,2);
% 		save([folder sprintf('MeanB_CH%d.mat',j)],'ans');
% end


% %% 4. Load Data Mean
% for i=1:4
% 	dataMean{1,i} = load([folder sprintf('MeanP_CH%d.mat',i)]);
% 	dataMean{2,i} = load([folder sprintf('MeanM_CH%d.mat',i)]);
% 	dataMean{3,i} = load([folder sprintf('MeanB_CH%d.mat',i)]);
% end




% %% 6. Smoothing (Moving Average)
% % Smoothing Session (Moving Average)
% for i=1:4
% 	dataNormMA{1,i} = smooth(tP, dataNorm{1,i}, span, sMethod);
% 	dataNormMA{2,i} = smooth(tMB, dataNorm{2,i}, span, sMethod);
% 	dataNormMA{3,i} = smooth(tMB, dataNorm{3,i}, span, sMethod);
% end

% %% 7. Time Domain (Plotting Per Kanal)
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

% %% 8. Frequency Domain (Plotting Per Kanal)
% for i=1:4 % kanal
% 	figure(i+4)
% 	for j=1:3 % kelas
% 		Ak = abs(fft(dataNorm{j,i}))/length(dataNorm{j,i});
% 		k = 0:1:length(dataNorm{j,i})-1;
% 		f = k*fs/length(dataNorm{j,i});
% 		subplot(3,1,j); plot(f,Ak);
% 		xlabel('\fontsize{8}Hz');
% 		ylabel('\fontsize{8}dB');
% 		title(['\fontsize{12}' KelasList{j} '\fontsize{9}' CHlist{i}]);
% 		xlim([BPlim1 BPlim2]);
% 		% ylim([dBlim1 dBlim2]);
% 	end
% 	print([folder2 sprintf('FFT %s_%d-%d',CHlist{i},BPlim1,BPlim2)],'-dpng');
% end

% %% 9. Scattering Semuanya
% for i=1:6
%     figure(i+8);
%     hold on
%    scatter(merahNorm(:,sc1(i)),merahNorm(:,sc2(i)),'or');
%    scatter(biruNorm(:,sc1(i)),biruNorm(:,sc2(i)),'*b');
%    scatter(putihNorm(:,sc1(i)),putihNorm(:,sc2(i)),'xk');
%     hold off
%    xlabel(sprintf('CH%d : %s', sc1(i), sc1_name{i}));
%    ylabel(sprintf('CH%d : %s', sc2(i), sc2_name{i}));
%    legend( 'Merah', 'Biru','Putih', 'Location', 'northeastoutside');
%    % legend( 'Merah', 'Location', 'northeastoutside');
%    % legend( 'Biru', 'Location', 'northeastoutside');
%    % legend( 'Putih', 'Location', 'northeastoutside');
%    judulFile = sprintf('CH%d vs CH%d', sc1(i), sc2(i));
%    % judulFileSave = sprintf('%s_:_CH%d_vs_CH%d_(Mean)', data_label, sc1(i), sc2(i));
%    title(judulFile);
%    % print(sprintf('%s-CH%d vs CH%d (Mean)', data_label, sc1(i), sc2(i)), '-dpng');
% 	print([folder3 'Scattering ' judulFile],'-dpng');
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

%% 8. Scattering
% Variabel bernama : putih merah biru
%CH1 vs CH2
% sctrx = 1;
% sctry = 2;
% figure(1);
% hold on
% % scatter(putih(:,sctrx),putih(:,sctry),'k');
% % scatter(merah(:,sctrx),merah(:,sctry),'r');
% scatter(biruNorm(:,sctrx),biruNorm(:,sctry),'b');
% xlabel(['\fontsize{8}' CHlist{sctrx}]);
% ylabel(['\fontsize{8}' CHlist{sctry}]);
% hold off

% figure(2);
% hold on
% scatter(putihNorm(:,sctrx),putihNorm(:,sctry),'xk');
% scatter(merahNorm(:,sctrx),merahNorm(:,sctry),'or');
% scatter(biruNorm(:,sctrx),biruNorm(:,sctry),'*b');
% xlabel(['\fontsize{8}' CHlist{sctrx}]);
% ylabel(['\fontsize{8}' CHlist{sctry}]);
% hold off

% %% 8. Scattering Merah-Biru dan Putih
% for i=4:5
%     figure(i);
%    subplot(1,2,1); hold on
%    scatter(merahNorm(:,sc1(i)),merahNorm(:,sc2(i)),'or');
%    xlabel(sprintf('CH%d : %s', sc1(i), sc1_name{i}));
%    ylabel(sprintf('CH%d : %s', sc2(i), sc2_name{i}));

%    % subplot(1,3,2); 
%    scatter(biruNorm(:,sc1(i)),biruNorm(:,sc2(i)),'*b');
%    xlabel(sprintf('CH%d : %s', sc1(i), sc1_name{i}));
%    ylabel(sprintf('CH%d : %s', sc2(i), sc2_name{i}));
%    legend('Merah','Biru', 'Location','northoutside', 'Orientation', 'horizontal');
%    legend('boxoff');

%    hold off
%    subplot(1,2,2); scatter(putihNorm(:,sc1(i)),putihNorm(:,sc2(i)),'xk');
%    xlabel(sprintf('CH%d : %s', sc1(i), sc1_name{i}));
%    ylabel(sprintf('CH%d : %s', sc2(i), sc2_name{i}));
%    legend( 'Putih', 'Location','northoutside', 'Orientation', 'horizontal');
%    legend('boxoff');

%    judulFile = sprintf('CH%d vs CH%d 2s', sc1(i), sc2(i));
%    suptitle(judulFile);
% 	print([folder3 'Scattering MB-P ' judulFile],'-dpng');
% end

% %% 8. Scattering Merah-Biru-Putih (Pisah 3 Warna)
% for i=4:5
%     figure(i);
%    subplot(1,3,1); scatter(merahNorm(:,sc1(i)),merahNorm(:,sc2(i)),'or');
%    xlabel(sprintf('CH%d : %s', sc1(i), sc1_name{i}));
%    ylabel(sprintf('CH%d : %s', sc2(i), sc2_name{i}));
%    legend( 'Merah', 'Location','northoutside', 'Orientation', 'horizontal');
%    legend('boxoff');

%    subplot(1,3,2); scatter(biruNorm(:,sc1(i)),biruNorm(:,sc2(i)),'*b');
%    xlabel(sprintf('CH%d : %s', sc1(i), sc1_name{i}));
%    ylabel(sprintf('CH%d : %s', sc2(i), sc2_name{i}));
%    legend( 'Biru', 'Location','northoutside', 'Orientation', 'horizontal');
%    legend('boxoff');

%    subplot(1,3,3); scatter(putihNorm(:,sc1(i)),putihNorm(:,sc2(i)),'xk');
%    xlabel(sprintf('CH%d : %s', sc1(i), sc1_name{i}));
%    ylabel(sprintf('CH%d : %s', sc2(i), sc2_name{i}));
%    legend( 'Putih', 'Location','northoutside', 'Orientation', 'horizontal');
%    legend('boxoff');

%    judulFile = sprintf('CH%d vs CH%d 2s', sc1(i), sc2(i));
%    suptitle(judulFile);
% 	print([folder3 'Scattering M-B-P ' judulFile],'-dpng');
% end

% %% 8. Scattering dataNorm (Mean)
% %%% %%%
% % dataNorm{1,:} = putih
% % dataNorm{2,:} = merah
% % dataNorm{3,:} = biru
% %%% %%%
% for i=1:6
%     figure(i);
%     hold on
%    scatter(dataNorm{1,sc1(i)},dataNorm{1,sc2(i)},'xk');
%    scatter(dataNorm{2,sc1(i)},dataNorm{2,sc2(i)},'or');
%    scatter(dataNorm{3,sc1(i)},dataNorm{3,sc2(i)},'*b');
%     hold off
%    xlabel(sprintf('CH%d : %s', sc1(i), sc1_name{i}));
%    ylabel(sprintf('CH%d : %s', sc2(i), sc2_name{i}));
%    legend('Putih', 'Merah', 'Biru', 'Location', 'northeastoutside');
%    judulFile = sprintf('CH%d vs CH%d', sc1(i), sc2(i));
%    % judulFileSave = sprintf('%s_:_CH%d_vs_CH%d_(Mean)', data_label, sc1(i), sc2(i));
%    title(judulFile);
%    % print(sprintf('%s-CH%d vs CH%d (Mean)', data_label, sc1(i), sc2(i)), '-dpng');
% 	print([folder3 'Scattering Mean ' judulFile],'-dpng');
% end