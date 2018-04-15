function [targets, outputs] = JST2(inputs, hiddenLayerSize)

    % Generate targets
    [~,N] = size(inputs);
    n = N/2;
    targets(1,1:n) = ones;
        targets(2,n+1:N) = ones;

    % Membuat Pattern Recognition Network
    % hiddenLayerSize = 10;
    net = patternnet(hiddenLayerSize);

    % Set up Division of Data for Training, Validation, Testing
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;

    % Train the Network
    [net,tr] = train(net, inputs, targets); 
    nntraintool('close'); % close the nntraintool immediately

    % Test the Network
    outputs = net(inputs);
    errors = gsubtract(targets, outputs);
    performance = perform(net, targets, outputs);

    % % Saving the confusionMatrix plot
    % figure, plotconfusion(targets, outputs);
    % print([folder2 sprintf('M_PSD_%s',subjek)],'-dpng');

    % View the Network
    % view(net);
end