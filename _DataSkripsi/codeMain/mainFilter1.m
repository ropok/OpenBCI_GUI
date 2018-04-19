%  --- Ekstraksi Ciri RMS
function [ciriM, ciriB] = mainFilter1(subjek, durasiData)
%myFun - Description
%
% Syntax: [ciriM ciriB] = mainFilter1(subjek, durasiData)
%
% Long description 

    folder = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
    % files = dir([folder '*.txt']);
    fs = 200;

    % -- LoadRaw - Notch50Hz - BP1-50Hz (basic preprocessing)
    data = load([folder subjek]);
    data = filterNotch50(data, fs); % Notch 50 Hz
    data = filterBP(data, fs, 1, 50); % BandPass awal : 1-50
    % --------------------------------- (basic preprocessing)

    % -- input : data ----- 11 22 33 13 26 39 ----------------
    % data0 = data;
    data1 = filterBP(data, fs, 10, 12); % 11
    data2 = filterBP(data, fs, 21, 23); % 22
    data3 = filterBP(data, fs, 32, 34); % 33
    data4 = filterBP(data, fs, 12, 14); % 13
    data5 = filterBP(data, fs, 25, 27); % 26
    data6 = filterBP(data, fs, 38, 40); % 39
    % -- Output : data1, data2, data3, data4, data5, data6 --
    
    % -- Potong Data, input : data[1 2 3 4 5 6] ---------------------------------
    [M1,B1] = potongData(data1, fs, durasiData); % 11
    [M2,B2] = potongData(data2, fs, durasiData); % 22
    [M3,B3] = potongData(data3, fs, durasiData); % 33
    [M4,B4] = potongData(data4, fs, durasiData); % 13
    [M5,B5] = potongData(data5, fs, durasiData); % 26
    [M6,B6] = potongData(data6, fs, durasiData); % 39
    % -- output : MB[1 2 3 4 5 6] -----------------------------------------------


    % - RMS ----------------------------------------------------------------
    % -- Gabungin data ke dalam satu variable per -- input : MB[1 2 3]------
    M = [M1; M2; M3; M4; M5; M6];
    B = [B1; B2; B3; B4; B5; B6];
    % -- output : M, B, sizeData -------------------------------------------

    % -- RMS -- Input: M B
    ciriM = RMS(M)';
    ciriB = RMS(B)';
    % ----------------------------------------------------------------------


    % % - Ratio RMS ----------------------------------------------------------
    % M = [RMS(M1)./RMS(M4) ; RMS(M1)./RMS(M5) ; RMS(M1)./RMS(M6) ; ... 
    %         RMS(M2)./RMS(M4) ; RMS(M2)./RMS(M5) ; RMS(M2)./RMS(M6) ; ... 
    %             RMS(M3)./RMS(M4) ; RMS(M3)./RMS(M5) ; RMS(M3)./RMS(M6)];
    % B = [RMS(B1)./RMS(B4) ; RMS(B1)./RMS(B5) ; RMS(B1)./RMS(B6) ; ... 
    %         RMS(B2)./RMS(B4) ; RMS(B2)./RMS(B5) ; RMS(B2)./RMS(B6) ; ... 
    %             RMS(B3)./RMS(B4) ; RMS(B3)./RMS(B5) ; RMS(B3)./RMS(B6)];

    % ciriM = M';
    % ciriB = B';
    % % ----------------------------------------------------------------------

end