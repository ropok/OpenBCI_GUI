function CM = outputCM(input)
    
% -- confusion Matriks : Akurasi, TPR, FDR
        % CM
        TP = sum(input(1,1:15) == 1);
        FN = sum(input(2,1:15) == 1);
        FP = sum(input(1,16:30) == 1);
        TN = sum(input(2,16:30) == 1);
        Akurasi = (TP+TN) / (TP+TN+FP+FN);
        TPR = TP / (TP+FN);
        FDR = FP / (TP+FP);
        CM(1,1) = Akurasi;
        CM(1,2) = TPR;
        CM(1,3) = FDR;
end