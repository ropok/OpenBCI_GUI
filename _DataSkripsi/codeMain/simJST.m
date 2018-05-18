function output_biner = simJST(net,input)
%simJST - Description
%
% Syntax: output_biner = simJST(net,input)
%
% Long description
% Input berupa data dengan dimensi (jumlah.datum x jumlah.ciri)
% [Input]->[HN]->[output]
% HN:Hidden Node
    [datum,~] = size(input);
    for i = 1:datum
        data = input(i,:);
        % data = normalize_var(data,-1,1);
        data = mapstd(data);
        % HN = data*net.IW{1,1}' + net.b{1}';
        % HN = 2./(1+exp(-2*HN))-1; %tansig
        HN = data*net.IW{1,1}';
        HN = 2./(1+exp(-2*HN))-1; %tansig
        HN = HN  + net.b{1}';
        output(i,:) = HN*net.LW{2,1}' + net.b{2}';
        
        % HN = tansig(data*net.IW{1,1}' + net.b{1}');
        % output(i,:) = purelin(HN*net.LW{2,1}' + net.b{2}');
    end
    
    output_biner = output';

    % for i = 1:datum
    %     if(output(1,i)>output(2,i))
    %         output_biner(1,i) = 1;
    %         output_biner(2,i) = 0;
    %     else
    %         output_biner(1,i) = 0;
    %         output_biner(2,i) = 1;
    %     end
    % end

end



% % 
% % Manually SIM
% % 
% % [input] -> [HiddenLayer] -> [output]
% % Test
% hiddenlayer = input*net.IW{1,1}' + net.b{1}';
% hiddenlayer = 2/(1+exp(-2*hiddenlayer))-1 % tansig
% outputlayer = hiddenlayer*net.LW{2,1}' + net.b{2}';
