% Next tasks : rata-rata semua data untuk diliat SCPnya. Jadinya nanti satu plot satu channel empat kelas
clc;
clear;
close all;

%Variabel
% N = Netral : Putih
% L = Left 	  : Merah
% R = Right	  : Biru
fs = 200;	% sesuai ganglion pakai 200Hz
t = [0:399]/fs;

% ambil data dan buang N pertama (pemanasan)

%% Data yang Mana

%-jalerse15
load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\j_n.txt');
load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\j_l.txt');
load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\j_r.txt');

% bandpass Filter
[d,c] = butter(2,[9 15]/(fs/2), 'bandpass');
for i=1:4
	j_n(:,i)=filter(d,c,j_n(:,i));
	j_l(:,i)=filter(d,c,j_l(:,i));
	j_r(:,i)=filter(d,c,j_r(:,i));
end

detikLR = 5;
detikN = 3;

cat_j_n1 = [];
cat_j_n2 = [];
cat_j_n3 = [];
cat_j_n4 = [];
for i=0:(length(j_n)/(fs*detikN))-1
	awal = (detikN*fs*i)+1;
	akhir = (detikN*fs*i)+(detikN*fs);
	cat_temp1 = horzcat(j_n(awal:akhir,1));
	cat_j_n1 = horzcat(cat_j_n1,cat_temp1);

	cat_temp2 = horzcat(j_n(awal:akhir,2));
	cat_j_n2 = horzcat(cat_j_n2,cat_temp2);

	cat_temp3 = horzcat(j_n(awal:akhir,3));
	cat_j_n3 = horzcat(cat_j_n3,cat_temp3);

	cat_temp4 = horzcat(j_n(awal:akhir,4));
	cat_j_n4 = horzcat(cat_j_n4,cat_temp4);
end

mean_j_n1 = mean(cat_j_n1,2);
mean_j_n2 = mean(cat_j_n2,2);
mean_j_n3 = mean(cat_j_n3,2);
mean_j_n4 = mean(cat_j_n4,2);

cat_j_l1 = [];
cat_j_l2 = [];
cat_j_l3 = [];
cat_j_l4 = [];
for i=0:(length(j_l)/(fs*detikLR))-1
	awal = (detikLR*fs*i)+1;
	akhir = (detikLR*fs*i)+(detikLR*fs);
	cat_temp1 = horzcat(j_l(awal:akhir,1));
	cat_j_l1 = horzcat(cat_j_l1,cat_temp1);

	cat_temp2 = horzcat(j_l(awal:akhir,2));
	cat_j_l2 = horzcat(cat_j_l2,cat_temp2);

	cat_temp3 = horzcat(j_l(awal:akhir,3));
	cat_j_l3 = horzcat(cat_j_l3,cat_temp3);

	cat_temp4 = horzcat(j_l(awal:akhir,4));
	cat_j_l4 = horzcat(cat_j_l4,cat_temp4);
end


mean_j_l1 = mean(cat_j_l1,2);
mean_j_l2 = mean(cat_j_l2,2);
mean_j_l3 = mean(cat_j_l3,2);
mean_j_l4 = mean(cat_j_l4,2);

cat_j_r1 = [];
cat_j_r2 = [];
cat_j_r3 = [];
cat_j_r4 = [];
for i=0:(length(j_r)/(fs*detikLR))-1
	awal = (detikLR*fs*i)+1;
	akhir = (detikLR*fs*i)+(detikLR*fs);
	cat_temp1 = horzcat(j_r(awal:akhir,1));
	cat_j_r1 = horzcat(cat_j_r1,cat_temp1);

	cat_temp2 = horzcat(j_r(awal:akhir,2));
	cat_j_r2 = horzcat(cat_j_r2,cat_temp2);

	cat_temp3 = horzcat(j_r(awal:akhir,3));
	cat_j_r3 = horzcat(cat_j_r3,cat_temp3);

	cat_temp4 = horzcat(j_r(awal:akhir,4));
	cat_j_r4 = horzcat(cat_j_r4,cat_temp4);
end

mean_j_r1 = mean(cat_j_r1,2);
mean_j_r2 = mean(cat_j_r2,2);
mean_j_r3 = mean(cat_j_r3,2);
mean_j_r4 = mean(cat_j_r4,2);

% figure(1)
% hold on
% plot(t, mean_j_n1);
% % plot(mean_j_l1);
% % plot(mean_j_r1);
% % legend('putih','merah','biru');
% hold off
tn = [0:599]/fs;
tlr = [0:999]/fs;

% for i=1:4
% 	figure(i)
% 	plot(tn, sprintf('mean_j_n%s',i), tlr, sprintf('mean_j_l%s',i), tlr, sprintf('mean_j_r%s',i));
% end

% % Per Kanal
% figure(1)
% plot(tn, mean_j_n1, tlr, mean_j_l1, tlr, mean_j_r1);
% legend('putih','merah','biru');
% title('CH1-Fp1');
% xlabel('\fontsize{8}detik (s)');	
% print('CH1-Fp1', '-dpng');

% figure(2)
% plot(tn, mean_j_n2, tlr, mean_j_l2, tlr, mean_j_r2);
% legend('putih','merah','biru');
% title('CH2-Fp2');
% xlabel('\fontsize{8}detik (s)');
% print('CH2-Fp2', '-dpng');

% figure(3)
% plot(tn, mean_j_n3, tlr, mean_j_l3, tlr, mean_j_r3);
% legend('putih','merah','biru');
% title('CH3-C3');
% xlabel('\fontsize{8}detik (s)');
% print('CH3-C3', '-dpng');

% figure(4)
% plot(tn, mean_j_n4, tlr, mean_j_l4, tlr, mean_j_r4);
% legend('putih','merah','biru');
% title('CH4-C4');
% xlabel('\fontsize{8}detik (s)');
% print('CH4-C4', '-dpng');

% %% Per Kelas
% % Kelas Putih
% figure(1)
% plot(tn, mean_j_n1, tn, mean_j_n2, tn, mean_j_n3, tn, mean_j_n4);
% legend('CH1-Fp1', 'CH2-Fp2', 'CH3-C3', 'CH4-C4');
% title('Kelas Putih');
% print('j_Kelas Putih', '-dpng');

% figure(2)
% plot(tlr, mean_j_l1, tlr, mean_j_l2, tlr, mean_j_l3, tlr,mean_j_l4);
% legend('CH1-Fp1', 'CH2-Fp2', 'CH3-C3', 'CH4-C4');
% title('Kelas Merah');
% print('j_Kelas Merah', '-dpng');

% figure(3)
% plot(tlr, mean_j_r1, tlr, mean_j_r2, tlr, mean_j_r3, tlr,mean_j_r4);
% legend('CH1-Fp1', 'CH2-Fp2', 'CH3-C3', 'CH4-C4');
% title('Kelas Biru');
% print('j_kelas Biru', '-dpng');

%% FFT Per Kanal
dataDiFFT = {mean_j_n1 mean_j_l1 mean_j_r1 mean_j_n2 mean_j_l2 mean_j_r2 mean_j_n3 mean_j_l3 mean_j_r3 mean_j_n4 mean_j_l4 mean_j_r4};
dataDiFFT_title = {'Putih' 'Merah' 'Biru'};
% figure(1)
% Ak = abs(fft(dataDiFFT{1}))/length(dataDiFFT{1});
% k = 0:1:length(dataDiFFT{1})-1;
% f = k*fs/length(dataDiFFT{1});
% plot(f,Ak);

for i=1:4
	figure(i)
	o=1;
	if i == 1
		for j=1:3
			Ak = abs(fft(dataDiFFT{j}))/length(dataDiFFT{j});
			k = 0:1:length(dataDiFFT{j})-1;
			f = k*fs/length(dataDiFFT{j});
			subplot(3,1,o); plot(f,Ak);
			xlabel('\fontsize{8}Hz');
			ylabel('\fontsize{8}dB');
			title(['\fontsize{12}' dataDiFFT_title{j} '\fontsize{9} (CH1-Fp1)']);
			xlim([7 15]);
			o=o+1;
		end
		print('FFT CH1-Fp1', '-dpng');
	end
	if i == 2
		for j=4:6
			Ak = abs(fft(dataDiFFT{j}))/length(dataDiFFT{j});
			k = 0:1:length(dataDiFFT{j})-1;
			f = k*fs/length(dataDiFFT{j});
			subplot(3,1,o); plot(f,Ak);
			xlabel('\fontsize{8}Hz');
			ylabel('\fontsize{8}dB');
			title(['\fontsize{12}' dataDiFFT_title{j-3} '\fontsize{9} (CH2-Fp2)']);
			xlim([7 15]);
			o=o+1;
		end
		print('FFT CH2-Fp2', '-dpng');
	end
	if i == 3
		for j=7:9
			Ak = abs(fft(dataDiFFT{j}))/length(dataDiFFT{j});
			k = 0:1:length(dataDiFFT{j})-1;
			f = k*fs/length(dataDiFFT{j});
			subplot(3,1,o); plot(f,Ak);
			xlabel('\fontsize{8}Hz');
			ylabel('\fontsize{8}dB');
			title(['\fontsize{12}' dataDiFFT_title{j-6} '\fontsize{9} (CH3-C3)']);
			xlim([7 15]);
			o=o+1;
		end
		print('FFT CH3-C3', '-dpng');
	end
	if i == 4
		for j=10:12
			Ak = abs(fft(dataDiFFT{j}))/length(dataDiFFT{j});
			k = 0:1:length(dataDiFFT{j})-1;
			f = k*fs/length(dataDiFFT{j});
			subplot(3,1,o); plot(f,Ak);
			xlabel('\fontsize{8}Hz');
			ylabel('\fontsize{8}dB');
			title(['\fontsize{12}' dataDiFFT_title{j-9} '\fontsize{9} (CH4-C4)']);
			xlim([7 15]);
			o=o+1;
		end
		print('FFT CH4-C4', '-dpng');
	end
end