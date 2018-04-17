%  --- Mengambil ciri dari max dan mean hasil FFT. Dengan catatan sudah diketahui kelasnya
function [ciriMerah, ciriBiru] = main7(subjek, durasiData)
%main7 - Mengambil ciri DFT mean dan max
%
% Syntax: [ciriMerah, ciriBiru] = main7(subjek, durasiData)
%
% Long description
    
    % close all; clear; clc;
    % durasiData = 1;
    % subjek = 'subjek5a_9.txt';
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
    
    % -- Potong Data, input : data[1 2 3] ---------------------------------
    [M1,B1,durasi] = potongData(data1, fs, durasiData); % theta
    [M2,B2,durasi] = potongData(data2, fs, durasiData);  % alpha
    [M3,B3,durasi] = potongData(data3, fs, durasiData); % beta
    % -- output : MB[1 2 3] -----------------------------------------------

    % -- Gabungin data ke dalam satu variable per -- input : MB[1 2 3]------
    % M = [M1; M2; M3];
    % B = [B1; B2; B3];
    M = [M1];
    B = [B1];
    sizeData = size(M);
    % -- output : M, B, sizeData ---------------------------------------------------

    % -- Convert ke ciri DST -- input : M B sizeData   
        % -- FFT kan data
    for i=1:sizeData(1)
        for j=1:sizeData(2)
            fft_M{i,j} = abs(fft(M{i,j}))/length(M{i,j});
            fft_B{i,j} = abs(fft(B{i,j}))/length(B{i,j});    
        end
    end
        % -- ambil ciri, masukkan ke variable dft_M dan dft_B dari data 1-30
    for i=1:sizeData(1)
        for j=1:sizeData(2)
            ciriDFT.meanM(i,j) = mean(fft_M{i,j}(1:30));
            ciriDFT.meanB(i,j) = mean(fft_B{i,j}(1:30));
            ciriDFT.maxM(i,j) = max(fft_M{i,j}(1:30));
            ciriDFT.maxB(i,j) = max(fft_B{i,j}(1:30));
        end
    end

    ciriMerah = [ciriDFT.meanM'; ciriDFT.maxM'];
    ciriBiru = [ciriDFT.meanB'; ciriDFT.maxB'];

    % -- output : ciriDFT[.meanM .meanB .maxM .maxB]

    % % -- RMS dimasukkan ke dalam cell, memudahkan loop -
    % dataRMS{1,1} = RMS(M1);
    % dataRMS{1,2} = RMS(M2);
    % dataRMS{1,3} = RMS(M3);

    % dataRMS{2,1} = RMS(B1);
    % dataRMS{2,2} = RMS(B2); 
    % dataRMS{2,3} = RMS(B3);
    % % -- dataRMS{} -------------------------------------

    % [rM, rB] = RatioRMS2(dataRMS);

end