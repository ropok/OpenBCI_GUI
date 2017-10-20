clc;
clear;
close all;

%Variables
% N = Neutral : White
% L = Left 	  : Red
% R = Right	  : Blue
fs = 200;	% sesuai ganglion pakai 200Hz
t = [0:399]/fs;

% ambil data dan buang N pertama (pemanasan)

%% Data yang Mana
%-R11
% load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\R11.txt');
% data_raw = R11;

%-R12
% load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\R12.txt');
% data_raw = R12;
% data_label = 'R12';

%-jalerse11
% load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\jalerse11.txt');
% data_raw = jalerse11;
% data_label = 'jalerse11';

%-jalerse12
% load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\jalerse12.txt');
% data_raw = jalerse12;
% data_label = 'jalerse12';

%-jalerse13
% load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\jalerse13.txt');
% data_raw = jalerse13;
% data_label = 'jalerse13';

%-jalerse14
% load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\jalerse14.txt');
% data_raw = jalerse14;
% data_label = 'jalerse14';

%-jalerse15
% load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\jalerse15.txt');
% data_raw = jalerse15;
% data_label = 'jalerse15';


%-jalerse16 - hanya sampai detik 34.565 ( 6913 indeks )
load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\jalerse16.txt');
data_raw = jalerse16;
data_label = 'jalerse16';

% step 2. Notch 50Hz
[b,a] = butter(2,[49 51]/(fs/2), 'stop');
% bandpass Filter
[d,c] = butter(2,[0.5 50]/(fs/2), 'bandpass');
for i=1:4
	data_raw(:,i)=filter(b,a,data_raw(:,i));
	data_raw(:,i)=filter(d,c,data_raw(:,i));
end

%% cek panjang waktu (3 sekon)
durasiWaktu = 3;
data_netral = [8 16 24 32 40]; % White
data_left = [3 4 5 19 20 21 35 36 37]; % Red
data_right = [11 12 13 27 28 29 43 44 45]; % Blue
%% Potong Data
for i=1:length(data_netral) % Netral - White
  for j=1:4
    awal = data_netral(i)*fs +1;
    akhir = awal + durasiWaktu*fs-1;
    n{i,j} = data_raw(awal:akhir,j);
  end
end

for i=1:length(data_left) % Left - Red
  for j=1:4
    awal = data_left(i)*fs+1;
    akhir = awal + durasiWaktu*fs-1;
    l{i,j} = data_raw(awal:akhir,j);
  end
end

for i=1:length(data_right) % Right - Blue
  for j=1:4
    awal = data_right(i)*fs +1;
    akhir = awal + durasiWaktu*fs-1;
    r{i,j} = data_raw(awal:akhir,j);
  end
end

%% Scatter
for i=1:4
    for j=1:length(data_netral)
        n_mean(j,i) = mean(n{j,i});
    end
    for jk=1:length(data_left)
        l_mean(j,i) = mean(l{jk,i});
    end
    for jl=1:length(data_right) 
        r_mean(j,i) = mean(r{jl,i});
    end
end

sc1 = [1 1 1 2 2 3];
sc2 = [2 3 4 3 4 4];
sc_ch1 = {'Fp1' 'Fp1' 'Fp1' 'Fp2' 'Fp2' 'C3'};
sc_ch2 = {'Fp2' 'C3' 'C4' 'C3' 'C4' 'C4'};

for i=1:6
    figure(i);
    hold on
   scatter(n_mean(:,sc1(i)),n_mean(:,sc2(i)),'xk'); % Netral - Putih
   scatter(l_mean(:,sc1(i)),l_mean(:,sc2(i)),'or'); % Left - Red
   scatter(r_mean(:,sc1(i)),r_mean(:,sc2(i)),'*b'); % Right - Blue
    hold off
   xlabel(sprintf('Channel %d : %s', sc1(i), sc_ch1{i}));
   ylabel(sprintf('Channel %d : %s', sc2(i), sc_ch2{i}));
   legend('Putih-Netral', 'Merah-Left', 'Biru-Right', 'Location', 'northeastoutside')
   judulFile = sprintf('%s : CH%d vs CH%d (Mean)', data_label, sc1(i), sc2(i));
   judulFileSave = sprintf('%s_:_CH%d_vs_CH%d_(Mean)', data_label, sc1(i), sc2(i));
   title(judulFile);
   print(sprintf('%s-CH%d vs CH%d (Mean)', data_label, sc1(i), sc2(i)), '-dpng');
end

close all;