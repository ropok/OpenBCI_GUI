dataUji = tabel32Ciri_Sesi2;
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

% -- SIM Massal Sesi1Sesi2
for nomorSubjek = 2:9
    data = eval(['dataUji.subjek' num2str(nomorSubjek)]);
    for row = 1:3
        net = eval(['tabelNet_Sesi1Sesi2.subjek' num2str(nomorSubjek) '{' num2str(row) ',1}']);
        outputUji_Sesi1Sesi2{row,nomorSubjek} = sim(net,data);
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


% -- ubah SIM jadi biner : 0 1 - Sesi1Sesi2
outputUjiBiner_Sesi1Sesi2 = [];
for i = 2:9 % Nomor Subjek
    for j = 1:3 % Baris
        for k = 1:30 % Jumlah Data
            data1 = outputUji_Sesi1Sesi2{j,i}(1,k);
            data2 = outputUji_Sesi1Sesi2{j,i}(2,k);

            if data1 > data2
                outputUjiBiner_Sesi1Sesi2{j,i}(1,k) = 1;
                outputUjiBiner_Sesi1Sesi2{j,i}(2,k) = 0;
            else
                outputUjiBiner_Sesi1Sesi2{j,i}(1,k) = 0;
                outputUjiBiner_Sesi1Sesi2{j,i}(2,k) = 1;
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
% --- Sesi1Sesi2
outputUjiCM_Sesi1Sesi2 = [];
for i = 2:9
    for j = 1:3
        data = outputUjiBiner_Sesi1Sesi2{j,i};
        % CM
        TP = sum(data(1,1:15) == 1);
        FN = sum(data(2,1:15) == 1);
        FP = sum(data(1,16:30) == 1);
        TN = sum(data(2,16:30) == 1);
        Akurasi = (TP+TN) / (TP+TN+FP+FN);
        TPR = TP / (TP+FN);
        FDR = FP / (TP+FP);
        outputUjiCM_Sesi1Sesi2{j,i}(1,1) = Akurasi;
        outputUjiCM_Sesi1Sesi2{j,i}(1,2) = TPR;
        outputUjiCM_Sesi1Sesi2{j,i}(1,3) = FDR;
    end
end

clearvars -except outputUjiCM_Sesi1 outputUjiCM_Sesi2 outputUjiCM_Sesi1Sesi2

colNames = {'HiddenNodes', 'Subjek2', 'Subjek3', 'Subjek4', 'Subjek5', 'Subjek6', 'Subjek7', 'Subjek8', 'Subjek9'};
tabelCM_Sesi1 = array2table(outputUjiCM_Sesi1,'VariableNames',colNames);
tabelCM_Sesi2 = array2table(outputUjiCM_Sesi2,'VariableNames',colNames);
tabelCM_Sesi1Sesi2 = array2table(outputUjiCM_Sesi1Sesi2,'VariableNames',colNames);


% ----------------------------------------------------------------------------------------------------------------------
%                       SINGLE SUBJEK
% ----------------------------------------------------------------------------------------------------------------------
dataUji = tabel32Ciri_Sesi2;

% -- SIM Massal
for nomorSubjek = 1:1
    data = eval(['dataUji.subjek' num2str(nomorSubjek)]);
    for row = 1:3
        % --- Sesi1
        net = eval(['tabelNet_Sesi1.subjek' num2str(nomorSubjek) '{' num2str(row) ',1}']);
        outputUji_Sesi1{row,nomorSubjek} = sim(net,data);
        clear net;
        % --- Sesi2
        net = eval(['tabelNet_Sesi2.subjek' num2str(nomorSubjek) '{' num2str(row) ',1}']);
        outputUji_Sesi2{row,nomorSubjek} = sim(net,data);
        clear net;
        % --- Sesi1Sesi2
        net = eval(['tabelNet_Sesi1Sesi2.subjek' num2str(nomorSubjek) '{' num2str(row) ',1}']);
        outputUji_Sesi1Sesi2{row,nomorSubjek} = sim(net,data);
        clear net;
    end
    clear data;
end

% -- ubah SIM jadi biner : 0 1 - Sesi1
outputUjiBiner_Sesi1 = [];
for i = 1:1 % Nomor Subjek
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
for i = 1:1 % Nomor Subjek
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


% -- ubah SIM jadi biner : 0 1 - Sesi1Sesi2
outputUjiBiner_Sesi1Sesi2 = [];
for i = 1:1 % Nomor Subjek
    for j = 1:3 % Baris
        for k = 1:30 % Jumlah Data
            data1 = outputUji_Sesi1Sesi2{j,i}(1,k);
            data2 = outputUji_Sesi1Sesi2{j,i}(2,k);

            if data1 > data2
                outputUjiBiner_Sesi1Sesi2{j,i}(1,k) = 1;
                outputUjiBiner_Sesi1Sesi2{j,i}(2,k) = 0;
            else
                outputUjiBiner_Sesi1Sesi2{j,i}(1,k) = 0;
                outputUjiBiner_Sesi1Sesi2{j,i}(2,k) = 1;
            end
        end
    end
end
clear i j k data1 data2;


% -- confusion Matriks : Akurasi, TPR, FDR
% --- Sesi1
outputUjiCM_Sesi1 = [];
for i = 1:1
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
for i = 1:1
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
% --- Sesi1Sesi2
outputUjiCM_Sesi1Sesi2 = [];
for i = 1:1
    for j = 1:3
        data = outputUjiBiner_Sesi1Sesi2{j,i};
        % CM
        TP = sum(data(1,1:15) == 1);
        FN = sum(data(2,1:15) == 1);
        FP = sum(data(1,16:30) == 1);
        TN = sum(data(2,16:30) == 1);
        Akurasi = (TP+TN) / (TP+TN+FP+FN);
        TPR = TP / (TP+FN);
        FDR = FP / (TP+FP);
        outputUjiCM_Sesi1Sesi2{j,i}(1,1) = Akurasi;
        outputUjiCM_Sesi1Sesi2{j,i}(1,2) = TPR;
        outputUjiCM_Sesi1Sesi2{j,i}(1,3) = FDR;
    end
end

clearvars -except outputUjiCM_Sesi1 outputUjiCM_Sesi2 outputUjiCM_Sesi1Sesi2

colNames = {'HiddenNodes', 'Subjek1'};
tabelCM_Sesi1 = array2table(outputUjiCM_Sesi1,'VariableNames',colNames);
tabelCM_Sesi2 = array2table(outputUjiCM_Sesi2,'VariableNames',colNames);
tabelCM_Sesi1Sesi2 = array2table(outputUjiCM_Sesi1Sesi2,'VariableNames',colNames);