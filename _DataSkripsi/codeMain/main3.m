%  --- Score:Ratio RMS seluruh subjek
% function [scoreM, scoreB] = main2(subjek, durasiData)
    close all; 
    clear; clc;
    % scoreAllM = [];
    % scoreAllB = [];

    durasiData = 1;
    subjek = 'subjek2c_11.txt';
    folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
    % folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp13\'; 
    files = dir([folder1 '*.txt']);
    fs = 200;

    % -- LoadRaw - Notch50Hz - BP1-50Hz (basic preprocessing)
    data = load([folder1 subjek]);
    data = filterNotch50(data, fs);
    [data, BP] = filterBP(data, fs, 1, 50);
    % --------------------------------- (basic preprocessing)

    % -- input : data ----- Target 11 Hz (Merah)
    [data11, BP11] = filterBP(data, fs, 8.5, 9.5);
    [data22, BP22] = filterBP(data, fs, 17.5, 18.5);
    [data33, BP33] = filterBP(data, fs, 26.5, 27.5);
    % -- Output : data11, data22, data33 --
    % -- input : data ----- Target 13 Hz (Biru)
    [data13, BP13] = filterBP(data, fs, 13.5, 14.5);
    [data26, BP26] = filterBP(data, fs, 27.5, 28.5);
    [data39, BP39] = filterBP(data, fs, 41.5, 42.5);
    % -- Output : data13, data26, data39 --

    %     % -- input : data ----- Target 11 Hz (Merah)
    % [data11, BP11] = filterBP(data, fs, 10.5, 11.5);
    % [data22, BP22] = filterBP(data, fs, 21.5, 22.5);
    % [data33, BP33] = filterBP(data, fs, 32.5, 33.5);
    % % -- Output : data11, data22, data33 --
    % % -- input : data ----- Target 13 Hz (Biru)
    % [data13, BP13] = filterBP(data, fs, 12.5, 13.5);
    % [data26, BP26] = filterBP(data, fs, 25.5, 26.5);
    % [data39, BP39] = filterBP(data, fs, 38.5, 39.5);
    % % -- Output : data13, data26, data39 --

    % -- Potong Data ---------------------------------
    [M11,B11,durasi] = potongData(data11, fs, durasiData);
    [M22,B22,durasi] = potongData(data22, fs, durasiData);
    [M33,B33,durasi] = potongData(data33, fs, durasiData);

    [M13,B13,durasi] = potongData(data13, fs, durasiData);
    [M26,B26,durasi] = potongData(data26, fs, durasiData);
    [M39,B39,durasi] = potongData(data39, fs, durasiData);
    % -- MB[11 22 33] MB[13 26 39] -------------------

    % -- RMS -----------------------------------------
    M11_RMS = RMS(M11);
    M13_RMS = RMS(M13);
    M22_RMS = RMS(M22);
    M26_RMS = RMS(M26);
    M33_RMS = RMS(M33);
    M39_RMS = RMS(M39);

    B11_RMS = RMS(B11);
    B13_RMS = RMS(B13);
    B22_RMS = RMS(B22);
    B26_RMS = RMS(B26);
    B33_RMS = RMS(B33);
    B39_RMS = RMS(B39);
    % -- MB_RMS --------------------------------------

    % -- Memasukkan RMS ke cell, memudahkan loop ------
    dataRMS{1,1} = M11_RMS;
    dataRMS{1,2} = M22_RMS;
    dataRMS{1,3} = M33_RMS;
    dataRMS{1,4} = M13_RMS;
    dataRMS{1,5} = M26_RMS;
    dataRMS{1,6} = M39_RMS;

    
    dataRMS{2,1} = B11_RMS;
    dataRMS{2,2} = B22_RMS;
    dataRMS{2,3} = B33_RMS;
    dataRMS{2,4} = B13_RMS;
    dataRMS{2,5} = B26_RMS;
    dataRMS{2,6} = B39_RMS;

    % dataRMS{2,1} = B13_RMS;
    % dataRMS{2,2} = B26_RMS;
    % dataRMS{2,3} = B39_RMS;
    % dataRMS{2,4} = B11_RMS;
    % dataRMS{2,5} = B22_RMS;
    % dataRMS{2,6} = B33_RMS;
    % -- dataRMS{}-------------------------------------

    % -- Scoring ratioRMS -------
    [rM, rB] = RatioRMS(dataRMS);
    % -- scoreM scoreB ----------

    % % -- Mengumpulkan score seluruh subjek ------
    % scoreAllM = [scoreAllM; scoreM];
    % scoreAllB = [scoreAllB; scoreB];
    % % -- scoreAllM scoreAllB


% end