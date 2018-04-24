%  --- Ekstraksi Ciri Semua Ciri
    
    close all; clear; clc;
    durasiData = 4;
    subjek = 'subjek5a_9.txt';
    folder = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
    % folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp13\'; 
    files = dir([folder '*.txt']);
    fs = 200;

    % -- LoadRaw - Notch50Hz - BP1-50Hz (basic preprocessing)
    data = load([folder subjek]);
    data = filterNotch50(data, fs); % Notch 50 Hz
    data = filterBP(data, fs, 1, 30); % BandPass awal : 1-30
    % --------------------------------- (basic preprocessing)

    % -- input : data ----- theta - alpha - beta
    % data0 = data;
    data1 = filterBP(data, fs, 4, 8); % theta
    data2 = filterBP(data, fs, 8, 13); % alpha
    data3 = filterBP(data, fs, 13, 30); % beta
    % -- Output : data1, data2, data3 --
    
    % -- Potong Data, input : data[1 2 3] ---------------------------------
    [M1,B1] = potongData(data1, fs, durasiData); % theta
    [M2,B2] = potongData(data2, fs, durasiData); % alpha
    [M3,B3] = potongData(data3, fs, durasiData); % beta
    % -- output : MB[1 2 3] -----------------------------------------------

    % -- Gabungin data ke dalam satu variable per -- input : MB[1 2 3]------
    M = [M1; M2; M3];
    B = [B1; B2; B3];
    % -- output : M, B, sizeData -------------------------------------------

    % % -- RMS -- Input: M B
    % ciriM = RMS(M(:,1:3))';
    % ciriB = RMS(B(:,1:3))';

    t = [0:durasiData*fs-1]/fs;
    CHlist = {'CH1-Fp1' 'CH2-Fp2' 'CH3-C3' 'CH4-C4'};
    for i = 1:3
        figure;
        for j=1:4
            subplot(2,2,j);
            hold;
            plot(t,M{i,j}, 'r');
            plot(t,B{i,j}, 'b');
            hline(rms(M{i,j}(1:30)), 'r:');
            hline(rms(B{i,j}(1:30)), 'b:');
            % xlim([1 30]);
            title(sprintf('%s',CHlist{j}))
            hold;
        end
    end