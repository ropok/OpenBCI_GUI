% Mencoba hilangin BandPass
function [ciri_rms] = code12(subjek)
% -- Contoh Penggunaan: code6('subjek3a_10')
% Plotting TD pisah per kanal
close all;
% clear;
% clc;

% static
fs = 200;
[b,a] = butter(2,[49 51]/(fs/2), 'stop');           % Notch
[h,g] = butter(2,[0.1 50]/(fs/2), 'bandpass');   % Filter awal 1-50 Hz
[d,c] = butter(2,[10.5 11.5]/(fs/2), 'bandpass');   % Merah - 11 Hz
[f,e] = butter(2,[12.5 13.5]/(fs/2), 'bandpass');   % Biru  - 13 Hz

% durasi
chAwal = 1;
chAkhir = 4;
durasi = 2; % berapa detik ambil
durasiFs = durasi*fs;
% subjek = 'subjek5a_3.txt';
% folderPrint = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp9\';
%% [Awal Akhir,...]
% Jeda = [0 3, 8 11, 16 19, 24 27, 32 35, 40 43]
% Merah = [3 8, 19 24, 35 40]
% Biru  = [11 16, 27 32, 43 48]
% === SETELAH x 200 Hz ===
% Jeda = [1 600, 1601 2200, 3201 3800, 4801 5400, 6401 7000, 8001 8600]
% Merah = [601 1600, 3801 4800, 7001 8000]
% Biru  = [2201 3200, 5401 6400, 8601 9400]
% vline([0 5 16 21 32 37], 'r');
% vline([8 13 24 29 40 45], 'b');

% ----------------------------------- Basic PreProcessing ------Input: data------------
% data = load([subjek '.txt']);
data = load(subjek);
t = [0:durasiFs-1]/fs;
for j=chAwal:chAkhir
    data(:,j)=filter(b,a,data(:,j)); % Filter Notch 50 Hz
    data(:,j)=filter(h,g,data(:,j)); % Filter Band Pass 1 - 50 Hz
end
% -------------------------------------------------------- -----Output: data (Filtered)------------

% ----------------------------------- BandPass M B ---------------Input: data------------
for j=chAwal:chAkhir
    data11(:,j)=filter(d,c,data(:,j)); % data11 = BP 10.5 - 11.5 Hz
    data13(:,j)=filter(f,e,data(:,j)); % data13 = BP 12.5 - 13.5 Hz
end
% -------------------------------------------------------- -----Output: dataM dataB-------

% % 4. Normalisasi Data
% for i=1:4
% 	pN = gabPutih(:,i) - min(gabPutih(:,i));
% 	pN = pN ./ max(pN(:));
% 	gabPutih(:,i) = pN;

% 	mN = gabMerah(:,i) - min(gabMerah(:,i));
% 	mN = mN ./ max(mN(:));
% 	gabMerah(:,i) = mN;

% 	bN = gabBiru(:,i) - min(gabBiru(:,i));
% 	bN = bN ./ max(bN(:));
% 	gabBiru(:,i) = bN;
% end

M.a11 = data11(601:1600,:);
M.b11 = data11(3801:4800,:);
M.c11 = data11(7001:8000,:);

M.a13 = data13(601:1600,:);
M.b13 = data13(3801:4800,:);
M.c13 = data13(7001:8000,:);

B.a11 = data11(2201:3200,:);
B.b11 = data11(5401:6400,:);
B.c11 = data11(8601:length(data11),:);

B.a13 = data13(2201:3200,:);
B.b13 = data13(5401:6400,:);
B.c13 = data13(8601:length(data11),:);


% -- Potong sesuai durasi TD:TimeDomain
for j = chAwal:chAkhir
    M_TD{1,j} = M.a11(1:durasiFs,j);
    M_TD{2,j} = M.b11(1:durasiFs,j);
    M_TD{3,j} = M.c11(1:durasiFs,j);
    M_TD{4,j} = M.a13(1:durasiFs,j);
    M_TD{5,j} = M.b13(1:durasiFs,j);
    M_TD{6,j} = M.c13(1:durasiFs,j);
    
    B_TD{1,j} = B.a11(1:durasiFs,j);
    B_TD{2,j} = B.b11(1:durasiFs,j);
    B_TD{3,j} = B.c11(1:durasiFs,j);
    B_TD{4,j} = B.a13(1:durasiFs,j);
    B_TD{5,j} = B.b13(1:durasiFs,j);
    B_TD{6,j} = B.c13(1:durasiFs,j);
end

% -- Potong sesuai durasi PSD:TimeDomain
for j = chAwal:chAkhir
    M_PSD{1,j} = PSD(M.a11(1:durasiFs,j));
    M_PSD{2,j} = PSD(M.b11(1:durasiFs,j));
    M_PSD{3,j} = PSD(M.c11(1:durasiFs,j));
    M_PSD{4,j} = PSD(M.a13(1:durasiFs,j));
    M_PSD{5,j} = PSD(M.b13(1:durasiFs,j));
    M_PSD{6,j} = PSD(M.c13(1:durasiFs,j));
    
    B_PSD{1,j} = PSD(B.a11(1:durasiFs,j));
    B_PSD{2,j} = PSD(B.b11(1:durasiFs,j));
    B_PSD{3,j} = PSD(B.c11(1:durasiFs,j));
    B_PSD{4,j} = PSD(B.a13(1:durasiFs,j));
    B_PSD{5,j} = PSD(B.b13(1:durasiFs,j));
    B_PSD{6,j} = PSD(B.c13(1:durasiFs,j));
end

maxDataM = []; minDataM = [];
for i = 1:length(M_PSD)
    for j = chAwal:chAkhir
        maxDataM = max([maxDataM max(M_PSD{i,j}.data)]);
        minDataM = min([minDataM min(M_PSD{i,j}.data)]);
    end
end
maxDataB = []; minDataB = [];
for i = 1:length(B_PSD)
    for j = chAwal:chAkhir
        maxDataB = max([maxDataB max(B_PSD{i,j}.data)]);
        minDataB = min([minDataB min(B_PSD{i,j}.data)]);
    end
end
maxData = max([maxDataM maxDataB]);
minData = min([minDataM minDataB]);

% subjek(regexp(subjek, '[.txt]'))=[];
% plotTD1(M_TD, 1, 4, 2, minData, maxData, 'Merah', 3); print([folderPrint sprintf('TD_%s_M1',subjek)],'-dpng');
% plotTD1(M_TD, 2, 5, 2, minData, maxData, 'Merah', 19); print([folderPrint sprintf('TD_%s_M2',subjek)],'-dpng');
% plotTD1(M_TD, 3, 6, 2, minData, maxData, 'Merah', 35); print([folderPrint sprintf('TD_%s_M3',subjek)],'-dpng');

% plotTD1(B_TD, 1, 4, 2, minData, maxData, 'Biru', 11); print([folderPrint sprintf('TD_%s_B1',subjek)],'-dpng');
% plotTD1(B_TD, 2, 5, 2, minData, maxData, 'Biru', 27); print([folderPrint sprintf('TD_%s_B2',subjek)],'-dpng');
% plotTD1(B_TD, 3, 6, 2, minData, maxData, 'Biru', 43); print([folderPrint sprintf('TD_%s_B3',subjek)],'-dpng');

subjek(regexp(subjek, '[.txt]'))=[];
% plotPSD2(M_PSD, 1, 4, maxData, 'Merah',   [3 5]);% print([folderPrint sprintf('PSD_%s_M1',subjek)],'-dpng');
% plotPSD2(M_PSD, 2, 5, maxData, 'Merah', [19 21]);% print([folderPrint sprintf('PSD_%s_M2',subjek)],'-dpng');
% plotPSD2(M_PSD, 3, 6, maxData, 'Merah', [35 38]);% print([folderPrint sprintf('PSD_%s_M3',subjek)],'-dpng');

% plotPSD2(B_PSD, 1, 4, maxData, 'Biru', [11 14]);% print([folderPrint sprintf('PSD_%s_B1',subjek)],'-dpng');
% plotPSD2(B_PSD, 2, 5, maxData, 'Biru', [27 29]);% print([folderPrint sprintf('PSD_%s_B2',subjek)],'-dpng');
% plotPSD2(B_PSD, 3, 6, maxData, 'Biru', [43 45]);% print([folderPrint sprintf('PSD_%s_B3',subjek)],'-dpng');

% plot2x2(M_TD,'Merah', 2, folderPrint, subjek);
% plot2x2(B_TD,'Biru', 2, folderPrint, subjek);
sizeM_TD = size(M_TD);  %(1) = row, (2) = column
sizeB_TD = size(B_TD);

for i=1:3
    for j=1:4
        % M_TDr.11(i,j) = rms(M_TD{i,j});
        % M_TDr.13(i,j) = rms(M_TD{i+3,j});
        % B_TDr.11(i,j) = rms(B_TD{i,j});
        % B_TDr.13(i,j) = rms(B_TD{i+3,j});
        ciri_max.M11(i,j) = max(M_TD{i,j});
        ciri_max.M13(i,j) = max(M_TD{i+3,j});
        ciri_max.B11(i,j) = max(B_TD{i,j});
        ciri_max.B13(i,j) = max(B_TD{i+3,j});

        ciri_rms.M11(i,j) = rms(M_TD{i,j});
        ciri_rms.M13(i,j) = rms(M_TD{i+3,j});
        ciri_rms.B11(i,j) = rms(B_TD{i,j});
        ciri_rms.B13(i,j) = rms(B_TD{i+3,j});
    end
end

% M_rms= M_TDr;
% B_rms= B_TDr;

end