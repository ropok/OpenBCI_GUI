%  --- Ekstraksi Ciri RMS
function [ciriM, ciriB] = mainLoop(subjek, durasiData)
% mainLoop - Description
% Loop untuk load semua file .txt yang ada di folder tertentu
% Syntax: [ciriM, ciriB] = mainLoop(subjek, durasiData)
%
% Long description 

    folder = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
    fs = 200;

    % -- LoadRaw - Notch50Hz - BP1-50Hz (basic preprocessing)
    data = load([folder subjek]);
    data = filterNotch50(data, fs); % Notch 50 Hz
    data = filterBP(data, fs, 1, 50); % BandPass awal : 1-50
    % --------------------------------- (basic preprocessing)

    % -- input : data ----- theta - alpha - beta
    data1 = filterBP(data, fs, 1, 3); % delta
    data2 = filterBP(data, fs, 4, 7); % theta
    data3 = filterBP(data, fs, 8, 11); % alpha
    data4 = filterBP(data, fs, 12, 29); % beta
    data5 = filterBP(data, fs, 30, 50); % gamma

    data6 = filterBP(data, fs, 10, 12); % 11
    data7 = filterBP(data, fs, 21, 23); % 22
    data8 = filterBP(data, fs, 32, 34); % 33
    data9 = filterBP(data, fs, 12, 14); % 13
    data10 = filterBP(data, fs, 25, 27); % 26
    data11 = filterBP(data, fs, 38, 40); % 39
    % -- Output : data1, data2, data3 --
    
    % -- Potong Data, input : data[1 2 3 ... 11] ---------------------------------
    [M1,B1] = potongData(data1, fs, durasiData); % delta
    [M2,B2] = potongData(data2, fs, durasiData); % theta
    [M3,B3] = potongData(data3, fs, durasiData); % alpha
    [M4,B4] = potongData(data4, fs, durasiData); % beta
    [M5,B5] = potongData(data5, fs, durasiData); % gamma

    [M6,B6] = potongData(data6, fs, durasiData); % 11
    [M7,B7] = potongData(data7, fs, durasiData); % 22
    [M8,B8] = potongData(data8, fs, durasiData); % 33
    [M9,B9] = potongData(data9, fs, durasiData); % 13
    [M10,B10] = potongData(data10, fs, durasiData); % 26
    [M11,B11] = potongData(data11, fs, durasiData); % 39
    % -- output : MB[1 2 3 ... 11] -----------------------------------------------

    % % -- Gabungin data ke dalam satu variable per -- input : MB[1 2 3 ... 11]---
    M = [M1'; M2'; M3'; M4'; M5'; M6'; M7'; M8'; M9'; M10'; M11'];
    B = [B1'; B2'; B3'; B4'; B5'; B6'; B7'; B8'; B9'; B10'; B11'];
    % -- output : M B ------------------------------------------------------------

    % --  Ekstraksi ciri dengan RMS
    ciriM = RMS_SD(M);
    ciriB = RMS_SD(B);
    % -----------------------------


end