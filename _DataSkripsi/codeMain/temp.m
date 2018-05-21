jMax = 4;
iMax = 3;

for i=1:iMax
    figure;
    hold;
    for j=1:jMax
    plot(PSD_M(i,j).frequencies, PSD_M(i,j).data);
    end
    hold;
    xlim([1 30]);
end

for i=1:iMax
    figure;
    hold;
    for j=1:jMax
    plot(PSD_B(i,j).frequencies, PSD_B(i,j).data);
    end
    hold;
    xlim([1 30]);
end


    figure;
    hold;
    for j=1:jMax
    plot(PSD_M(1,j).frequencies, PSD_M(1,j).data, 'r');
    plot(PSD_M(2,j).frequencies, PSD_M(2,j).data, 'g');
    plot(PSD_M(3,j).frequencies, PSD_M(3,j).data, 'b');
    end
    hold;
    xlim([1 30]);

    figure;
    hold;
    for j=1:jMax
    plot(PSD_B(1,j).frequencies, PSD_B(1,j).data, 'r');
    plot(PSD_B(2,j).frequencies, PSD_B(2,j).data, 'g');
    plot(PSD_B(3,j).frequencies, PSD_B(3,j).data, 'b');
    end
    hold;
    xlim([1 30]);



for j = 1:jMax
    figure;
    hold;
    plot(PSD_M(1,j).frequencies, PSD_M(1,j).data, 'r');
    plot(PSD_M(2,j).frequencies, PSD_M(2,j).data, 'g');
    plot(PSD_M(3,j).frequencies, PSD_M(3,j).data, 'b');
    hold;
    xlim([1 30]);
    figure;
    hold;
    plot(PSD_B(1,j).frequencies, PSD_B(1,j).data, 'r');
    plot(PSD_B(2,j).frequencies, PSD_B(2,j).data, 'g');
    plot(PSD_B(3,j).frequencies, PSD_B(3,j).data, 'b');
    hold;
    xlim([1 30]);
end


%% 9. Frequency Domain (Plotting Per Kanal)
for i=1:4 % kanal
	figure;
	for j=1:3 % kelas
		dataDiFFT = dataMean{j,i}.ans;
		Ak = abs(fft(dataDiFFT))/length(dataDiFFT);
		k = 0:1:length(dataDiFFT)-1;
		f = k*fs/length(dataDiFFT);
		subplot(3,1,j); plot(f,Ak);
		xlabel('\fontsize{8}Hz');
		ylabel('\fontsize{8}dB');
		title(['\fontsize{12}' KelasList{j} '\fontsize{9}' CHlist{i}]);
		xlim([BPlim1 BPlim2]);
		% ylim([dBlim1 dBlim2]);
	end
	print([folder2 sprintf('FFT %s_%d-%d',CHlist{i},BPlim1,BPlim2)],'-dpng');
end

for j=1:4
    m1{1,j} = mean([M1{1,j} M1{2,j} M1{3,j}],2);
    m2{1,j} = mean([M2{1,j} M2{2,j} M2{3,j}],2);
    m3{1,j} = mean([M3{1,j} M3{2,j} M3{3,j}],2);
    
    b1{1,j} = mean([B1{1,j} B1{2,j} B1{3,j}],2);
    b2{1,j} = mean([B2{1,j} B2{2,j} B2{3,j}],2);
    b3{1,j} = mean([B3{1,j} B3{2,j} B3{3,j}],2);
end

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
        plot(f,fft_M{i,j});
        plot(f,fft_B{i,j});
        xlim([1 30]);
        title(sprintf('%s',CHlist{j}))
        hold;
    end
end


t = [0:200-1]/fs;
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

% -- PowerBand?
    CHlist = {'CH1-Fp1' 'CH2-Fp2' 'CH3-C3' 'CH4-C4'};
    for i = 1:3
        figure;
        for j=1:4
            subplot(2,2,j);
            hold;
            plot(f,fft_M{i,j}, 'r');
            plot(f,fft_B{i,j}, 'b');
            hline(bandpower(fft_M{i,j}, fs, [1 30]), 'r');
            hline(bandpower(fft_B{i,j}, fs, [1 30]), 'b');

            % hline(mean(fft_M{i,j}(1:30)), 'r:');
            % hline(mean(fft_B{i,j}(1:30)), 'b:');
            xlim([1 30]);
            title(sprintf('%s',CHlist{j}))
            hold;
        end
    end
    % -------- ----


    CHlist = {'CH1-Fp1' 'CH2-Fp2' 'CH3-C3' 'CH4-C4'};
    for i = 1:3
        figure;
        for j=1:4
            subplot(2,2,j);
            hold;
            plot(f,fft_M{i,j}, 'r');
            plot(f,fft_B{i,j}, 'b');
            % hline(max(fft_M{i,j}(1:30)), 'r');
            % hline(max(fft_B{i,j}(1:30)), 'b');
            if i == 
            hline(mean(fft_M{i,j}(1:30)), 'r:');
            hline(mean(fft_B{i,j}(1:30)), 'b:');
            xlim([1 30]);
            title(sprintf('%s',CHlist{j}))
            hold;
        end
    end

% CHlist = {'CH1-Fp1' 'CH2-Fp2' 'CH3-C3' 'CH4-C4'};
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


save([folder sprintf('%s_pN.mat',Kode)],'putih');
save([folder2 'ciriRMS1.mat'],'inputs');


% -- JST TP TN
[inputs,targets] = cancer_dataset;
targets = targets(1,:);
nG1 = length(find(targets==1))
nG2 = length(find(targets==0))
setdemorandstream(672880951)
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio   = 15/100;
net.divideParam.testRatio  = 15/100;
% net.trainParam.showWindow = false;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs)
testX = inputs(:,tr.testInd);
testT = targets(:,tr.testInd);
% plotroc(targets,outputs)
testY = net(testX);
figure
plotroc(testT,testY)
[c,cm,ind,per] = confusion(testT,testY);
Se1 = per(1,3)
Sp1 = per(1,4)
Ac1 = 1-c
N=length(testT);
Se2 = cm(2,2)/(cm(2,2)+cm(2,1))
Sp2 = cm(1,1)/(cm(1,1)+cm(1,2))
Ac2 = (cm(1,1)+cm(2,2))/N

Answer:
% - Dalam bentuk rate (%)
TPR = cm(1,1)/sum(cm(:,1)) % Division is  by elements in the predicted true column
TNR = cm(2,2)/sum(cm(:,2)) % Same issues:
FNR = cm(1,2)/sum(cm(:,2))
FPR = cm(2,1)/sum(cm(:,1))


ciriSesi1Sesi2.RMS2_Merah = ciriMerah;
ciriSesi1Sesi2.RMS2_Biru = ciriBiru;
save([folder2 'ciriSesi1Sesi2.mat'],'ciriSesi1Sesi2');
save([folder2 'akurasi_Sesi1.mat'],'akurasi_Sesi1');
save([folder2 'akurasi_Sesi2.mat'],'akurasi_Sesi2');
save([folder2 'akurasi_Sesi12.mat'],'akurasi_Sesi12');

[max(akurasi_Sesi1(:)) max(akurasi_Sesi2(:)) max(akurasi_Sesi1Sesi2(:))]
t = [0:200-1]/fs;

save

for i = 1:20
    akurasiJST(i) = JST(inputs, i);
end



% -- Cara Save dan Load .net
1.At what point in my code will i put save net

 Any time after training it and before deleting it. 
However, give it a unique name so that it is not overwritten 
or used by mistake. 
 gregnet1 = net;
 save gregnet1
2.Using save net;, which location on the system is the trained network saved?

 What ever directory you are in when you save it UNLESS you 
specify another directory. 
3.How can i load the trained network and supply new data that i want to test it with?

 load gregnet1
 newoutput = gregnet1(newinput);
Please Note: I want to be able to save the trained neural network such that when i run the code over and over again with the training data set,it gives same output. I have discovered that each time i run my code,it gives a different output which i do not want once i have an acceptable result.

 Then initialize the RNG to the same state before training to 
obtain reproducibility. See any of my training example posts.
Hope this helps.

Thank you for formally accepting my answer

Greg

% -- Filter
data1 = filterBP(data, fs, 1, 3); % delta -
data2 = filterBP(data, fs, 4, 7); % theta -
data3 = filterBP(data, fs, 8, 11); % alpha -
data4 = filterBP(data, fs, 12, 29); % beta
data5 = filterBP(data, fs, 30, 50); % gamma

data6 = filterBP(data, fs, 10, 12); % 11
data7 = filterBP(data, fs, 21, 23); % 22
data8 = filterBP(data, fs, 32, 34); % 33
data9 = filterBP(data, fs, 12, 14); % 13
data10 = filterBP(data, fs, 25, 27); % 26
data11 = filterBP(data, fs, 38, 40); % 39

% -- Labeling Row untuk Nama Ciri
RowCiri = {'ciriDelta_Fp1' ; 'ciriDelta_Fp2' ; 'ciriDelta_C3' ; 'ciriDelta_C4' ; ...
            'ciriTheta_Fp1' ;  'ciriTheta_Fp2' ;  'ciriTheta_C3' ;  'ciriTheta_C4' ; ... 
            'ciriAlpha_Fp1' ;  'ciriAlpha_Fp2' ;  'ciriAlpha_C3' ;  'ciriAlpha_C4' ; ... 
            'ciriBeta_Fp1' ;  'ciriBeta_Fp2' ;  'ciriBeta_C3' ;  'ciriBeta_C4' ; ... 
            'ciriGamma_Fp1' ;  'ciriGamma_Fp2' ;  'ciriGamma_C3' ;  'ciriGamma_C4' ; ... 
            
            'ciri11Hz_Fp1' ;  'ciri11Hz_Fp2' ;  'ciri11Hz_C3' ;  'ciri11Hz_C4' ; ... 
            'ciri22Hz_Fp1' ;  'ciri22Hz_Fp2' ;  'ciri22Hz_C3' ;  'ciri22Hz_C4' ; ... 
            'ciri33Hz_Fp1' ;  'ciri33Hz_Fp2' ;  'ciri33Hz_C3' ;  'ciri33Hz_C4' ; ... 
            'ciri13Hz_Fp1' ;  'ciri13Hz_Fp2' ;  'ciri13Hz_C3' ;  'ciri13Hz_C4' ; ... 
            'ciri26Hz_Fp1' ;  'ciri26Hz_Fp2' ;  'ciri26Hz_C3' ;  'ciri26Hz_C4' ; ... 
            'ciri39Hz_Fp1' ;  'ciri39Hz_Fp2' ;  'ciri39Hz_C3' ;  'ciri39Hz_C4' ; ... 
            };


mat2dataset(ciriMerah)
dataset2table(ans)

% mat2dataset([subjek2_ subjek3_ subjek4_ subjek5_ subjek6_ subjek7_ subjek8_ subjek9_]);
table(subjek2, subjek3, subjek4, subjek5, subjek6, subjek7, subjek8, subjek9, 'RowNames', RowCiri);

% -- Menata variable untuk table
for i = 0:7
    start = i*30+1;
    finish = i*30+30;
    subjek{i+2} = [ciriMerah(:,start:finish) ciriBiru(:,start:finish)];
end

% -- Menata variable untuk table
subjek1 = subjek{1};
subjek2 = subjek{2};
subjek3 = subjek{3};
subjek4 = subjek{4};
subjek5 = subjek{5};
subjek6 = subjek{6};
subjek7 = subjek{7};
subjek8 = subjek{8};
subjek9 = subjek{9};

load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp25-Klasifikasi\ciriPerSubjek.mat');
data1=ciriPerSubjek(13:20,:);
data1=ciriPerSubjek(13:44,:); % 32 Ciri

% -- Menata variable untuk tabel
HiddenNode = subjek{1,1}(:,1);
subjek1 = subjek{1,1}(:,2:4);
subjek2 = subjek{1,2}(:,2:4);
subjek3 = subjek{1,3}(:,2:4);
subjek4 = subjek{1,4}(:,2:4);
subjek5 = subjek{1,5}(:,2:4);
subjek6 = subjek{1,6}(:,2:4);
subjek7 = subjek{1,7}(:,2:4);
subjek8 = subjek{1,8}(:,2:4);
subjek9 = subjek{1,9}(:,2:4);
tabelNet_Sesi1Sesi2 = table(HiddenNode, subjek1, subjek2, subjek3, subjek4, subjek5, subjek6, subjek7, subjek8, subjek9);
save D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData2\temp1\tabelNet_Sesi1Sesi2.mat tabelNet_Sesi1Sesi2; 
% -- Looping JST dengan menggunakan table
for i = 2:8
    data = eval(['data1.subjek' num2str(i)]);
    subjek{i} = JST(data, 20, 50);

    clear data;
end
% --- Testing Purpose
% -- Looping JST dengan menggunakan table
close all; clc;
for i = 2:3
    data = eval(['data1.subjek' num2str(i)]);
    disp(sprintf('Latih JST untuk Subjek%d',i));
    subjek{i} = JST(data, 5, 1); % JST(inputs, maxHiddenNode, maxAttemps)

    clear data;
end

% - Testing Loop
for i = 0:7
    start = i*15+1;
    finish = i*15+15;
    sprintf('%d - %d',start,finish)
end

% -- SIM massal
net = tabelNet_Sesi1.subjek2{1,1};
data = tabel32Ciri_Sesi2.subjek2;
tabelNet_Sesi1.subjek2{1,4} = sim(net,data);

net = tabelNet_Sesi1.subjek2{2,1};
data = tabel32Ciri_Sesi2.subjek2;
tabelNet_Sesi1.subjek2{2,4} = sim(net,data);

% -- SIM Massal Sesi1
for nomorSubjek = 2:9
    data = eval(['dataUji.subjek' num2str(nomorSubjek)]);
    for row = 1:3
        net = eval(['tabelNet_Sesi1.subjek' num2str(nomorSubjek) '{' num2str(row) ',1}']);
        outputUji_Sesi1{row,nomorSubjek} = sim(net,data);
        clear net;
    end
    clear data;
end

% -- SIM Massal Sesi2
for nomorSubjek = 2:9
    data = eval(['dataUji.subjek' num2str(nomorSubjek)]);
    for row = 1:3
        net = eval(['tabelNet_Sesi2.subjek' num2str(nomorSubjek) '{' num2str(row) ',1}']);
        outputUji_Sesi2{row,nomorSubjek} = sim(net,data);
        clear net;
    end
    clear data;
end

% -- ubah SIM jadi biner : 0 1 - Sesi1
outputUjiBiner_Sesi1 = [];
for i = 2:9 % Nomor Subjek
    for j = 1:3 % Baris
        for k = 1:30 % Jumlah Data
            data1 = outputUji_Sesi1{j,i}(1,k);
            data2 = outputUji_Sesi1{j,i}(2,k);

            if data1 > data2
                outputUjiBiner_Sesi1{j,i}(1,k) = 1;
                outputUjiBiner_Sesi1{j,i}(2,k) = 0;
            else
                outputUjiBiner_Sesi1{j,i}(1,k) = 0;
                outputUjiBiner_Sesi1{j,i}(2,k) = 1;
            end
        end
    end
end
clear i j k data1 data2;


% -- ubah SIM jadi biner : 0 1 - Sesi2
outputUjiBiner_Sesi2 = [];
for i = 2:9 % Nomor Subjek
    for j = 1:3 % Baris
        for k = 1:30 % Jumlah Data
            data1 = outputUji_Sesi2{j,i}(1,k);
            data2 = outputUji_Sesi2{j,i}(2,k);

            if data1 > data2
                outputUjiBiner_Sesi2{j,i}(1,k) = 1;
                outputUjiBiner_Sesi2{j,i}(2,k) = 0;
            else
                outputUjiBiner_Sesi2{j,i}(1,k) = 0;
                outputUjiBiner_Sesi2{j,i}(2,k) = 1;
            end
        end
    end
end
clear i j k data1 data2;


% CM
TP = sum(data(1,1:15) == 1);
FN = sum(data(2,1:15) == 1);
FP = sum(data(1,16:30) == 1);
TN = sum(data(2,16:30) == 1);
Akurasi = (TP+TN) / (TP+TN+FP+FN);
TPR = TP / (TP+FN);
FDR = FP / (TP+FP);



% -- confusion Matriks : Akurasi, TPR, FDR
% --- Sesi1
outputUjiCM_Sesi1 = [];
for i = 2:9
    for j = 1:3
        data = outputUjiBiner_Sesi1{j,i};
        % CM
        TP = sum(data(1,1:15) == 1);
        FN = sum(data(2,1:15) == 1);
        FP = sum(data(1,16:30) == 1);
        TN = sum(data(2,16:30) == 1);
        Akurasi = (TP+TN) / (TP+TN+FP+FN);
        TPR = TP / (TP+FN);
        FDR = FP / (TP+FP);
        outputUjiCM_Sesi1{j,i}(1,1) = Akurasi;
        outputUjiCM_Sesi1{j,i}(1,2) = TPR;
        outputUjiCM_Sesi1{j,i}(1,3) = FDR;
    end
end
% --- Sesi2
outputUjiCM_Sesi2 = [];
for i = 2:9
    for j = 1:3
        data = outputUjiBiner_Sesi2{j,i};
        % CM
        TP = sum(data(1,1:15) == 1);
        FN = sum(data(2,1:15) == 1);
        FP = sum(data(1,16:30) == 1);
        TN = sum(data(2,16:30) == 1);
        Akurasi = (TP+TN) / (TP+TN+FP+FN);
        TPR = TP / (TP+FN);
        FDR = FP / (TP+FP);
        outputUjiCM_Sesi2{j,i}(1,1) = Akurasi;
        outputUjiCM_Sesi2{j,i}(1,2) = TPR;
        outputUjiCM_Sesi2{j,i}(1,3) = FDR;
    end
end
clearvars -except outputUjiBiner_Sesi1 outputUjiBiner_Sesi2 outputUjiCM_Sesi1 outputUjiCM_Sesi2

colNames = {'HiddenNodes', 'Subjek2', 'Subjek3', 'Subjek4', 'Subjek5', 'Subjek6', 'Subjek7', 'Subjek8', 'Subjek9'};
tabelCM_Sesi1 = array2table(outputUjiCM_Sesi1,'VariableNames',colNames);
tabelCM_Sesi2 = array2table(outputUjiCM_Sesi2,'VariableNames',colNames);


    % ------------------
    % SUBJEK 1
    % ------------------

    % -- Untuk Looping pemilihan sesi mana yang akan diekstraksi ciri

    close all; clear; clc;

    folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp_Subjek1\RAW_Sesi1Sesi2\';
    ciriMerah = [];
    ciriBiru = [];
    files = dir([folder1 '*.txt']); 

    % Mengumpulkan data dari semua objek
    for h = 1:length(files)
        [M, B] = mainLoop(folder1, files(h,1).name, 1);

        % -- Mengumpulkan rM seluruh subjek ------
        ciriMerah = [ciriMerah M];
        ciriBiru = [ciriBiru B];
        % -- data_rM data_rB

        loading('Load Data', h, length(files));
    end

    subjek1 = [ciriMerah ciriBiru];
    % -- Labeling Row untuk Nama Ciri
    RowCiri = {'ciriDelta_Fp1' ; 'ciriDelta_Fp2' ; 'ciriDelta_C3' ; 'ciriDelta_C4' ; ...
    'ciriTheta_Fp1' ;  'ciriTheta_Fp2' ;  'ciriTheta_C3' ;  'ciriTheta_C4' ; ...
    'ciriAlpha_Fp1' ;  'ciriAlpha_Fp2' ;  'ciriAlpha_C3' ;  'ciriAlpha_C4' ; ...
    'ciriBeta_Fp1' ;  'ciriBeta_Fp2' ;  'ciriBeta_C3' ;  'ciriBeta_C4' ; ...
    'ciriGamma_Fp1' ;  'ciriGamma_Fp2' ;  'ciriGamma_C3' ;  'ciriGamma_C4' ; ...
    'ciri11Hz_Fp1' ;  'ciri11Hz_Fp2' ;  'ciri11Hz_C3' ;  'ciri11Hz_C4' ; ...
    'ciri22Hz_Fp1' ;  'ciri22Hz_Fp2' ;  'ciri22Hz_C3' ;  'ciri22Hz_C4' ; ...
    'ciri33Hz_Fp1' ;  'ciri33Hz_Fp2' ;  'ciri33Hz_C3' ;  'ciri33Hz_C4' ; ...
    'ciri13Hz_Fp1' ;  'ciri13Hz_Fp2' ;  'ciri13Hz_C3' ;  'ciri13Hz_C4' ; ...
    'ciri26Hz_Fp1' ;  'ciri26Hz_Fp2' ;  'ciri26Hz_C3' ;  'ciri26Hz_C4' ; ...
    'ciri39Hz_Fp1' ;  'ciri39Hz_Fp2' ;  'ciri39Hz_C3' ;  'ciri39Hz_C4' ; ...
    };
    tabel44Ciri_Sesi1Sesi2 = table(subjek1, 'RowNames', RowCiri);
    save D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp_Subjek1\tabel44Ciri_Sesi1Sesi2.mat tabel44Ciri_Sesi1Sesi2

    tabel32Ciri_Sesi1 = tabel44Ciri_Sesi1(13:44,:);
    tabel32Ciri_Sesi2 = tabel44Ciri_Sesi2(13:44,:);
    tabel32Ciri_Sesi1Sesi2 = tabel44Ciri_Sesi1Sesi2(13:44,:);

% --- AFTER JSTLoop.m

% -- Menata variable untuk tabel
HiddenNode = subjek{1,1}(:,1);
subjek1 = subjek{1,1}(:,2:4);
tabelNet_Sesi1Sesi2 = table(HiddenNode, subjek1);
save D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp_Subjek1\tabelNet_Sesi1Sesi2.mat tabelNet_Sesi1Sesi2;

% -- Kelompokin NET
for i = 1:1
    data = eval(['tabelNet_Sesi2.subjek' num2str(i)]);
    net_all{1,i} = data{2,1};
    clear data;
end


% 
% MANUALLY SIM WORKED!
% 

inputs = [0 1 2 3 4 5 6 7 8 9 10];
% inputs = inputs + .1 *rand(size(inputs));
targets = [0 1 2 3 4 3 2 1 2 3 4];
% Create a network with 1 neuron in the first layer
net=newff(inputs,targets,1,{'tansig','tansig'},'trainlm');
% Train the network
net = init(net);
net.trainParam.epochs = 100;
[net,tr,out]=train(net,inputs,targets);
%Simulate the network with the inputs
[Y,Pf,Af,E,perf] = sim(net,inputs);
%Calculate output manually:
% Pre-process the data
for iii = 1:numel(net.inputs{1}.processFcns)
      inputs = feval( net.inputs{1}.processFcns{iii}, ...
          'apply', inputs, net.inputs{1}.processSettings{iii} );
end
% Calculate the network response
a1 = tansig(net.IW{1,1}*inputs + net.b{1}); 
Yc = tansig(net.LW{2,1}*a1 + net.b{2}); 
% Post-process the data
for iii = 1:numel(net.outputs{2}.processFcns)
     Yc = feval( net.outputs{2}.processFcns{iii}, ...
          'reverse', Yc, net.outputs{2}.processSettings{iii} );
end
close all
% View results
[Y' Yc']


% 
% Concat Subjek 1 - 9
% 
subjek1_Sesi1 = tabel32Ciri_Sesi1.subjek1;
subjek2 = tabel32Ciri_Sesi1.subjek2;
subjek3 = tabel32Ciri_Sesi1.subjek3;
subjek4 = tabel32Ciri_Sesi1.subjek4;
subjek5 = tabel32Ciri_Sesi1.subjek5;
subjek6 = tabel32Ciri_Sesi1.subjek6;
subjek7 = tabel32Ciri_Sesi1.subjek7;
subjek8 = tabel32Ciri_Sesi1.subjek8;
subjek9 = tabel32Ciri_Sesi1.subjek9;


subjek1_Sesi2 = tabel32Ciri_Sesi2.subjek1;
subjek2 = tabel32Ciri_Sesi2.subjek2;
subjek3 = tabel32Ciri_Sesi2.subjek3;
subjek4 = tabel32Ciri_Sesi2.subjek4;
subjek5 = tabel32Ciri_Sesi2.subjek5;
subjek6 = tabel32Ciri_Sesi2.subjek6;
subjek7 = tabel32Ciri_Sesi2.subjek7;
subjek8 = tabel32Ciri_Sesi2.subjek8;
subjek9 = tabel32Ciri_Sesi2.subjek9;


subjek1_Sesi1Sesi2 = tabel32Ciri_Sesi1Sesi2.subjek1;
subjek2 = tabel32Ciri_Sesi1Sesi2.subjek2;
subjek3 = tabel32Ciri_Sesi1Sesi2.subjek3;
subjek4 = tabel32Ciri_Sesi1Sesi2.subjek4;
subjek5 = tabel32Ciri_Sesi1Sesi2.subjek5;
subjek6 = tabel32Ciri_Sesi1Sesi2.subjek6;
subjek7 = tabel32Ciri_Sesi1Sesi2.subjek7;
subjek8 = tabel32Ciri_Sesi1Sesi2.subjek8;
subjek9 = tabel32Ciri_Sesi1Sesi2.subjek9;

% -- Labeling Row untuk Nama Ciri
RowCiri = {'ciriBeta_Fp1' ;  'ciriBeta_Fp2' ;  'ciriBeta_C3' ;  'ciriBeta_C4' ; ... 
            'ciriGamma_Fp1' ;  'ciriGamma_Fp2' ;  'ciriGamma_C3' ;  'ciriGamma_C4' ; ... 
            
            'ciri11Hz_Fp1' ;  'ciri11Hz_Fp2' ;  'ciri11Hz_C3' ;  'ciri11Hz_C4' ; ... 
            'ciri22Hz_Fp1' ;  'ciri22Hz_Fp2' ;  'ciri22Hz_C3' ;  'ciri22Hz_C4' ; ... 
            'ciri33Hz_Fp1' ;  'ciri33Hz_Fp2' ;  'ciri33Hz_C3' ;  'ciri33Hz_C4' ; ... 
            'ciri13Hz_Fp1' ;  'ciri13Hz_Fp2' ;  'ciri13Hz_C3' ;  'ciri13Hz_C4' ; ... 
            'ciri26Hz_Fp1' ;  'ciri26Hz_Fp2' ;  'ciri26Hz_C3' ;  'ciri26Hz_C4' ; ... 
            'ciri39Hz_Fp1' ;  'ciri39Hz_Fp2' ;  'ciri39Hz_C3' ;  'ciri39Hz_C4' ; ... 
            };

tabel32Ciri_Sesi1Sesi2 = table(subjek1, subjek2, subjek3, subjek4, subjek5, subjek6, subjek7, subjek8, subjek9, 'RowNames', RowCiri);
save D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData2\temp1\tabel32Ciri_Sesi1Sesi2.mat tabel32Ciri_Sesi1Sesi2


net.outputs{2}.processFcns(1) = [];
net.inputs{1}.processFcns(2) = [];


% 
% tabelnet_reunited
% 
labelData = {'tabelNet_Sesi1' 'tabelNet_Sesi2' 'tabelNet_Sesi1Sesi2'};
for h = 1:3
    data1 = labelData{h};
    k = (h-1)*3;
    for i = 1:9
        for j = 1:3
            data = eval([data1 '.subjek' num2str(i)]);
            tabelNet{j+k,i} = data{j};
        end
    end
end