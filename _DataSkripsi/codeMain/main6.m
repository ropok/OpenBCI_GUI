%  --- Melihat plotting-an FFT dari data yang dirata-rata.

    close all; clear; clc;
    % scoreAllM = [];
    % scoreAllB = [];

    durasiData = 1;
    subjek = 'subjek5a_1.txt';
    folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
    % folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\subjek2c\';
    % folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp13\'; 
    files = dir([folder1 '*.txt']);
    fs = 200;

    % -- LoadRaw - Notch50Hz - BP1-50Hz (basic preprocessing)
    data = load([folder1 subjek]);
    data = filterNotch50(data, fs);
    [data, BP] = filterBP(data, fs, 0.2, 45);
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

    % -- Gabungkan Data berdasarkan kelas ------------
    % --- Rata Ratakan 1x200 data
    for j=1:4
        m1{1,j} = mean([M1{1,j} M1{2,j} M1{3,j}],2);
        m2{1,j} = mean([M2{1,j} M2{2,j} M2{3,j}],2);
        m3{1,j} = mean([M3{1,j} M3{2,j} M3{3,j}],2);
        
        b1{1,j} = mean([B1{1,j} B1{2,j} B1{3,j}],2);
        b2{1,j} = mean([B2{1,j} B2{2,j} B2{3,j}],2);
        b3{1,j} = mean([B3{1,j} B3{2,j} B3{3,j}],2);
    end
    M = [m1; m2; m3];
    B = [b1; b2; b3];
    clear m1 m2 m3 b1 b2 b3;
    % -- M B -----------------------------------------

    %  -- FFT Session -----------------------------------
    for i=1:3
        for j=1:4
            fft_M{i,j} = abs(fft(M{i,j}))/length(M{i,j});
            fft_B{i,j} = abs(fft(B{i,j}))/length(B{i,j});
            k = 0:1:length(M{i,j})-1;
            f = k*fs/length(M{i,j});
        end
    end

    CHlist = {'CH1-Fp1' 'CH2-Fp2' 'CH3-C3' 'CH4-C4'};
    for i = 1:3
        figure;
        for j=1:4
            subplot(2,2,j);
            hold;
            plot(f,fft_M{i,j}, 'r');
            plot(f,fft_B{i,j}, 'b');
            hline(max(fft_M{i,j}(1:30)), 'r');
            hline(max(fft_B{i,j}(1:30)), 'b');

            hline(mean(fft_M{i,j}(1:30)), 'r:');
            hline(mean(fft_B{i,j}(1:30)), 'b:');
            xlim([1 30]);
            title(sprintf('%s',CHlist{j}))
            hold;
        end
    end
    % -- fft_M fft_B ------------------------------------

%     CHlist = {'CH1-Fp1' 'CH2-Fp2' 'CH3-C3' 'CH4-C4'};
% for i = 1:3
%     figure;
%     for j=1:4
%         subplot(2,2,j);
%         hold;
%         data = m{i,j};
%         Ak = abs(fft(data))/length(data);
%         k = 0:1:length(data)-1;
%         f = k*fs/length(data);
%         plot(f,Ak);
%         clear data Ak k f;
%         data = b{i,j};
%         Ak = abs(fft(data))/length(data);
%         k = 0:1:length(data)-1;
%         f = k*fs/length(data);
%         plot(f,Ak);
%         xlim([1 30]);
%         title(sprintf('%s',CHlist{j}))
%         hold;
%         clear data Ak k f;
%     end
% end


    % % -- RMS dimasukkan ke dalam cell, memudahkan loop -
    % dataRMS{1,1} = RMS(M1);
    % dataRMS{1,2} = RMS(M2);
    % dataRMS{1,3} = RMS(M3);

    % dataRMS{2,1} = RMS(B1);
    % dataRMS{2,2} = RMS(B2); 
    % dataRMS{2,3} = RMS(B3);
    % % -- dataRMS{} -------------------------------------

    % [rM, rB] = RatioRMS2(dataRMS);