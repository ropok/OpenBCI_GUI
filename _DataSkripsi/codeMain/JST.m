function [net] = JST(inputs, maxHiddenLayerSize, targetAkurasi)
    %JST - Latih Jaringan Saraf Tiruan
    %
    % Syntax: net = JST(inputs, maxHiddenLayerSize, targetAkurasi)
    %
    % Long description 
    % input : 
    % * inputs              : data ciriMerah dan ciriBiru
    % * maxHiddenLayerSize  : maximum jumlah Hidden Layer untuk pelatihan
    % * targetAkurasi       : goal berupa besar Akurasi 
    % 
    % function JST ini terdiri dari 2 target saja (bisa dimodifikasi lebih lanjut)

    % Generate targets
    [~,N] = size(inputs);
    n = N/2;
    targets(1,1:n) = ones;
        targets(2,n+1:N) = ones;
    akurasiTotal = 0;
    tempAkurasi = 0;
    while akurasiTotal < targetAkurasi    
        for HL = 1:maxHiddenLayerSize
            % Membuat Pattern Recognition Network
            % hiddenLayerSize = 10;
            net = patternnet(HL); % Hidden Layer

            % Set up Division of Data for Training, Validation, Testing
            net.divideParam.trainRatio = 70/100;
            net.divideParam.valRatio = 15/100;
            net.divideParam.testRatio = 15/100;

            % Train the Network
            net.trainParam.showWindow = false; % Do not display the train Window
            [net,tr] = train(net, inputs, targets);

            % Test the Network
            outputs = net(inputs);
            errors = gsubtract(targets, outputs);
            performance = perform(net, targets, outputs);

            % --- Test
            testX = inputs(:, tr.testInd);
            testT = targets(:, tr.testInd);
            testY = net(testX);
            [cTest, cmTest, indTest, perTest] = confusion(testT, testY);

            % --- Val
            valX = inputs(:, tr.valInd);
            valT = targets(:, tr.valInd);
            valY = net(valX);
            [cVal, cmVal, indVal, perVal] = confusion(valT, valY);

            % --- Train
            trainX = inputs(:, tr.trainInd);
            trainT = targets(:, tr.trainInd);
            trainY = net(trainX);
            [cTrain, cmTrain, indTrain, perTrain] = confusion(trainT, trainY);

            % ---- Hitung Akurasi
            % Akurasi = (TP + TN)/total
            % TP = cm(2,2);
            % TN = cm(1,1);
            akurasiTest = (cmTest(2,2)+cmTest(1,1))/length(testX);
            akurasiVal = (cmVal(2,2)+cmVal(1,1))/length(valX);
            akurasiTrain = (cmTrain(2,2)+cmTrain(1,1))/length(trainX);
            akurasiTotal = sum([cmTest(2,2) cmTest(1,1) cmVal(2,2) cmVal(1,1) cmTrain(2,2) cmTrain(1,1)])/length(inputs);
            
            if akurasiTotal >= tempAkurasi
                disp(akurasiTotal);
                tempAkurasi = akurasiTotal;
            end
        
            if akurasiTotal >= targetAkurasi
                break
            end
        end
    end
end