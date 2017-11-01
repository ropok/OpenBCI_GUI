% Next tasks : rata-rata semua data untuk diliat SCPnya. Jadinya nanti satu plot satu channel empat kelas
clc;
clear;
close all;

%Variabel
% N = Neutral : White
% L = Left 	  : Red
% R = Right	  : Blue
fs = 200;	% sesuai ganglion pakai 200Hz
t = [0:399]/fs;

% ambil data dan buang N pertama (pemanasan)

%% Data yang Mana

%-jalerse15
load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\j_n.txt');
load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\j_l.txt');
load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\j_r.txt');

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
figure(1)
plot(tn, mean_j_n1, tlr, mean_j_l1, tlr, mean_j_r1);
legend('putih','merah','biru');
title('CH1-Fp1');
print('CH1-Fp1', '-dpng');

figure(2)
plot(tn, mean_j_n2, tlr, mean_j_l2, tlr, mean_j_r2);
legend('putih','merah','biru');
title('CH2-Fp2');
print('CH2-Fp2', '-dpng');

figure(3)
plot(tn, mean_j_n3, tlr, mean_j_l3, tlr, mean_j_r3);
legend('putih','merah','biru');
title('CH3-C3');
print('CH3-C3', '-dpng');

figure(4)
plot(tn, mean_j_n4, tlr, mean_j_l4, tlr, mean_j_r4);
legend('putih','merah','biru');
title('CH4-C4');
print('CH4-C4', '-dpng');