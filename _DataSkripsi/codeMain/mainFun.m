%  --- Ekstraksi Ciri RMS
function [ciriM, ciriB] = mainFun(subjek, durasiData)
%myFun - Description
%
% Syntax: [ciriM ciriB] = mainFun(data, durasiData)
%
% Long description 

    folder = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
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
    [M1,B1,durasi] = potongData(data1, fs, durasiData); % theta
    [M2,B2,durasi] = potongData(data2, fs, durasiData); % alpha
    [M3,B3,durasi] = potongData(data3, fs, durasiData); % beta
    % -- output : MB[1 2 3] -----------------------------------------------

    % -- Gabungin data ke dalam satu variable per -- input : MB[1 2 3]------
    M = [M1; M2; M3];
    B = [B1; B2; B3];
    % -- output : M, B, sizeData -------------------------------------------

    % -- RMS -- Input: M B
    CHpakai = 2;
    ciriM = RMS(M(:,1:CHpakai))';
    ciriB = RMS(B(:,1:CHpakai))';

end