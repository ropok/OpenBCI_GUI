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

% 
% SIM MASSAL with fungsi SIM
% 
data = tabelNet;
labelDataUji = 'tabel32Ciri_Sesi2';
for i = 1:size(data,1)
    for j = 1:size(data,2)
        dataUji = eval([labelDataUji '.subjek' num2str(j)]);
        tabelNet_pr1{i,j} = sim(data{i,j},dataUji);
        % tabelNet_pr1{i,j} = simJST(data{i,j},dataUji);
    end
end
clearvars -except tabelNet_pr1TEST;


% 
% Biner
% 
data = tabelNet_pr1;
tabelNet_pr2 = [];
for i = 1:size(data,1)
    for j = 1:size(data,2)
        for k = 1:30
            data1 = data{i,j}(1,k);
            data2 = data{i,j}(2,k);

            if data1 > data2
                tabelNet_pr2{j,i}(1,k) = 1;
                tabelNet_pr2{j,i}(2,k) = 0;
            else
                tabelNet_pr2{j,i}(1,k) = 0;
                tabelNet_pr2{j,i}(2,k) = 1;
            end
        end
    end
end
clearvars -except tabelNet_pr1 tabelNet_pr2;

% 
% -- confusion Matriks : Akurasi, TPR, FDR
% 
tabelNet_pr3 = [];
for i = 1:size(tabelNet_pr2,1)
    for j = 1:size(tabelNet_pr2,2)
        data = tabelNet_pr2{i,j};
        % CM
        TP = sum(data(1,1:15) == 1);
        FN = sum(data(2,1:15) == 1);
        FP = sum(data(1,16:30) == 1);
        TN = sum(data(2,16:30) == 1);
        Akurasi = (TP+TN) / (TP+TN+FP+FN);
        TPR = TP / (TP+FN);
        FDR = FP / (TP+FP);
        tabelNet_pr3{i,j}(1,1) = Akurasi;
        tabelNet_pr3{i,j}(1,2) = TPR;
        tabelNet_pr3{i,j}(1,3) = FDR;
    end
end


colNames = {'HiddenNodes', 'Subjek2', 'Subjek3', 'Subjek4', 'Subjek5', 'Subjek6', 'Subjek7', 'Subjek8', 'Subjek9'};
tabelCM_Sesi1 = array2table(outputUjiCM_Sesi1,'VariableNames',colNames);
tabelCM_Sesi2 = array2table(outputUjiCM_Sesi2,'VariableNames',colNames);
tabelCM_Sesi1Sesi2 = array2table(outputUjiCM_Sesi1Sesi2,'VariableNames',colNames);

