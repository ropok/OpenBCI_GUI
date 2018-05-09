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
HiddenNode = subjek{1,2}(:,1);
subjek2 = subjek{1,2}(:,2:4);
subjek3 = subjek{1,3}(:,2:4);
subjek4 = subjek{1,4}(:,2:4);
subjek5 = subjek{1,5}(:,2:4);
subjek6 = subjek{1,6}(:,2:4);
subjek7 = subjek{1,7}(:,2:4);
subjek8 = subjek{1,8}(:,2:4);
subjek9 = subjek{1,9}(:,2:4);
tabelNet_Sesi2 = table(HiddenNode, subjek2, subjek3, subjek4, subjek5, subjek6, subjek7, subjek8, subjek9);
save D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp31\tabelNet_Sesi2.mat tabelNet_Sesi2;
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