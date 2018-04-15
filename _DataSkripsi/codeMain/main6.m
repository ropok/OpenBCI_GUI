%  --- mendata Ratio RMS seluruh subjek

    close all; clear; clc;
    % scoreAllM = [];
    % scoreAllB = [];

    durasiData = 1;
    subjek = 'subjek5a_1.txt';
    folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
    % folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp13\'; 
    files = dir([folder1 '*.txt']);
    fs = 200;

    % -- LoadRaw - Notch50Hz - BP1-50Hz (basic preprocessing)
    data = load([folder1 subjek]);
    data = filterNotch50(data, fs);
    [data, BP] = filterBP(data, fs, 1, 30);
    % --------------------------------- (basic preprocessing)

    % -- input : data ----- theta - alpha - beta
    [data1, BP1] = filterBP(data, fs, 4, 8); % theta
    [data2, BP2] = filterBP(data, fs, 8, 13); % alpha
    [data3, BP3] = filterBP(data, fs, 13, 30); % beta
    % -- Output : data1, data2, data3 --
    
    % -- Potong Data ---------------------------------
    [M1,B1,durasi] = potongData(data1, fs, durasiData);
    [M2,B2,durasi] = potongData(data2, fs, durasiData);
    [M3,B3,durasi] = potongData(data3, fs, durasiData);
    % -- MB[1 2 3] -----------------------------------

    % % -- RMS dimasukkan ke dalam cell, memudahkan loop -
    % dataRMS{1,1} = RMS(M1);
    % dataRMS{1,2} = RMS(M2);
    % dataRMS{1,3} = RMS(M3);

    % dataRMS{2,1} = RMS(B1);
    % dataRMS{2,2} = RMS(B2); 
    % dataRMS{2,3} = RMS(B3);
    % % -- dataRMS{} -------------------------------------

    % [rM, rB] = RatioRMS2(dataRMS);