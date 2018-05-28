function [akurasi,TPR,FDR] = mySim(net,data)
% mySim untuk 2 kelas
%
% Syntax: [akurasi,TPR,FDR] = mySim(net,data)
%
% Long description (Steps)
% 1. sim
% 2. biner
% 3. CM


% 
% Step 1. sim
% 
% -Auto sim
% Yc = sim(net,data);
% -Manual Sim
for i = 1:size(data,2)
    a1(:,i) = net.IW{1,1}*data(:,i) + net.b{1};
    a1(:,i) = 2./(1+exp(-2*a1(:,i)))-1;
    Yc(:,i) = net.LW{2,1}*a1(:,i) + net.b{2};
end
data_pr1 = Yc;

% 
% Step 2. biner
% compare data
data_pr2 = [];
for j = 1:size(data_pr1,2)
    compData1 = data_pr1(1,j);
    compData2 = data_pr1(2,j);

    if compData1 > compData2
        data_pr2(1,j) = 1;
        data_pr2(2,j) = 0;
        else
            data_pr2(1,j) = 0;
            data_pr2(2,j) = 1;
    end
end

% % 
% % Step 3. CM
% % 
% TP = sum(data_pr2(1,1:15) == 1);
% FN = sum(data_pr2(2,1:15) == 1);
% FP = sum(data_pr2(1,16:30) == 1);
% TN = sum(data_pr2(2,16:30) == 1);
% akurasi = (TP+TN) / (TP+TN+FP+FN);
% TPR = TP / (TP+FN);
% FDR = FP / (TP+FP);

% 
% Step 3. CM
% 
    % Generate targets
    N = size(data,2);
    n = N/2;
    target(1,1:n) = ones;
        target(2,n+1:N) = ones;

[~,~,~,per] = confusion(target,data_pr2);
FN = sum(per(:,1));
FP = sum(per(:,2));
TP = sum(per(:,3));
TN = sum(per(:,4));
akurasi = (TP+TN) / (TP+TN+FP+FN);
TPR = TP / (TP+FN);
FDR = FP / (TP+FP);

end