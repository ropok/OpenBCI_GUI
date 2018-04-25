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


for i = 1:20
    akurasiJST(i) = JST(inputs, i);
end