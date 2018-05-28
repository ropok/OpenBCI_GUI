% --- Untuk 2 Kelas
function [netFix,akurasi,CM] = JST3(dataLatih, maxAttemps, dataUji)
    %JST - Latih Jaringan Saraf Tiruan
    %
    % Syntax: net = JST(dataLatih, mmaxAttemps)
    % Fixed Hidden Node : 24 (2/3*Ni+No = 2/3*32+3 = 24.333)
    % Long description 
    % inputUji : data Uji (data Sesi2)
    % input : 
    % * dataLatih              : data ciriMerah dan ciriBiru
    % * maxHiddenNodeSize   : maximum jumlah Hidden Node untuk pelatihan
    % * targetAkurasi       : goal berupa besar Akurasi 
    % * maxAttemps          : batasan Coba training
    % function JST ini terdiri dari 2 target saja (bisa dimodifikasi lebih lanjut)
    
    % Generate targets
    [~,N] = size(dataLatih{1,1});
    n = N/2;
    targets(1,1:n) = ones;
        targets(2,n+1:N) = ones;
            % targets(3,(n*2)+1:N) = ones;
        
    JST_32 = [];
    maxTried = 20;

    HN = 24;
        akurasiTotal = 0;
        tempAkurasi = 0;
        tried = 0;
        Attemp = 0; 
        while Attemp <= maxAttemps
                % Membuat Pattern Recognition Network
                net = newff(dataLatih,targets,HN,{'tansig','purelin'},'trainlm');
                net.inputs{1}.processFcns={'removeconstantrows'};
                net.outputs{2}.processFcns={'removeconstantrows'};
                % net = patternnet(HN,'trainscg','mse'); % Hidden Node

                % Set up Division of Data for Training, Validation, Testing
                net.divideParam.trainRatio = 70/100;
                net.divideParam.valRatio = 15/100;
                net.divideParam.testRatio = 15/100;

                % Train the Network
                net.trainParam.showWindow = false; % Do not display the train Window
                [net,~] = train(net, dataLatih, targets); 

                [akurasiTotal,TPR,FDR] = mySim(net,dataUji);


                % % % Test the Network
                % % outputs = net(inputs);
                % % errors = gsubtract(targets, outputs);
                % % performance = perform(net, targets, outputs);

                % % -- Confusion Matrix ------------------------------------------------------------------------------------------
                % % --- Test
                % testX = inputs(:, tr.testInd);
                % testT = targets(:, tr.testInd);
                % testY = net(testX);
                % [cTest, cmTest, indTest, perTest] = confusion(testT, testY);

                % % --- Val
                % valX = inputs(:, tr.valInd);
                % valT = targets(:, tr.valInd);
                % valY = net(valX);
                % [cVal, cmVal, indVal, perVal] = confusion(valT, valY);

                % % --- Train
                % trainX = inputs(:, tr.trainInd);
                % trainT = targets(:, tr.trainInd);
                % trainY = net(trainX);
                % [cTrain, cmTrain, indTrain, perTrain] = confusion(trainT, trainY);

                % % ---- Hitung Akurasi
                % % Akurasi = (TP + TN)/total
                % % TP = cm(2,2);
                % % TN = cm(1,1);
                % [~,length_test] = size(testX);
                % [~,length_val] = size(valX);
                % [~,length_train] = size(trainX);
                % akurasiTest = (cmTest(2,2)+cmTest(1,1))/length_test;
                % akurasiVal = (cmVal(2,2)+cmVal(1,1))/length_val;
                % akurasiTrain = (cmTrain(2,2)+cmTrain(1,1))/length_train;
                % akurasiTotal = sum([cmTest(2,2) cmTest(1,1) cmVal(2,2) cmVal(1,1) cmTrain(2,2) cmTrain(1,1)])/length(inputs);
                % -- Confusion Matrix ------------------------------------------------------------------------------------------
                

                % --Update JST_32
                if akurasiTotal > tempAkurasi
                    netFix = net;
                    akurasi = akurasiTotal;
                    % CM(1) = akurasiTotal; 
                    CM(1) = TPR;
                    CM(2) = FDR;
                    % indeksSubjek = HN-22;
                    % JST_32{indeksSubjek,1} = num2str(HN) ;  % Label Jumlah HN
                    % JST_32{indeksSubjek,2} = net;          % Network
                    % % JST_32{indeksSubjek,3} = tr;
                    % JST_32{indeksSubjek,3} = akurasiTotal; % AkurasiTotal
                    disp(sprintf('Updated JST - Hidden Node(%d) - Akurasi Total(%.2f)', HN, akurasiTotal));
                end
                if akurasiTotal >= tempAkurasi
                    % disp(akurasiTotal);
                    disp(Attemp);
                    tempAkurasi = akurasiTotal; % update tempAkurasi 
                    Attemp = Attemp + 1;
                    tried = 0;
                    % -- Limiting the try
                    else
                        tried = tried + 1;
                            if tried == maxTried;
                                disp(Attemp);
                                Attemp = Attemp + 1;
                                tried = 0;
                            end
                end

                % For Safety, init network
                net = init(net);
        end
    %     end
    % end
end