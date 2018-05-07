function akurasi = uji_JST(net, inputs)
% uji_JST - Description
% uji JST dari net yang sudah ada
% Syntax: akurasi = uji_JST(input,net)
%
% Long description

    [~,tr] = train(net, inputs);
    % -- Confusion Matrix ------------------------------------------------------------------------------------------
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
        [~,length_test] = size(testX);
        [~,length_val] = size(valX);
        [~,length_train] = size(trainX);
        % akurasiTest = (cmTest(2,2)+cmTest(1,1))/length_test;
        % akurasiVal = (cmVal(2,2)+cmVal(1,1))/length_val;
        % akurasiTrain = (cmTrain(2,2)+cmTrain(1,1))/length_train;
        akurasiTotal = sum([cmTest(2,2) cmTest(1,1) cmVal(2,2) cmVal(1,1) cmTrain(2,2) cmTrain(1,1)])/length(inputs);
        % -- Confusion Matrix ------------------------------------------------------------------------------------------

    
end