close all; clear; clc;

folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp19\';

ciriMerah = [];
ciriBiru = [];

files = dir([folder1 '*.txt']);

% Mengumpulkan data dari semua objek
for h = 1:length(files)
% for h = 1:2 % for Test purpose
    [M, B] = main7(files(h,1).name, 1);

    % -- Mengumpulkan rM seluruh subjek ------
    ciriMerah = [ciriMerah M];
    ciriBiru = [ciriBiru B];
    % -- data_rM data_rB

    loading('Load Data', h, length(files));
end

% % -- JST --
% inputs = [data_rM' data_rB']; % input untuk JST
% for i = 1:9
%     inputs1{1,i} = inputs(4*i-3:4*i,:);
%     % Saving the confusionMatrix plot
%     [targets, outputs] = JST2(inputs1{1,i},10);
%     figure, plotconfusion(targets, outputs, sprintf('%d',i));
%     print([folder2 sprintf('Confusion_Matrix_%d',i)],'-dpng');
%     close all;
%     clear targets outputs;
%     loading('Confusion Matrix Plotting', i, 9);
% end

% % -- Variasi i
%     iMin = 1;
%     iMax = 10;
% -- Variasi j (Hidden Layer)
    % jMin = 1;
    % jMax = 20;

    % iMax = 4;

% % -- JST -- Variasi Hidden Layer 1-10
% inputs = [data_rM' data_rB']; % input untuk JST
% for i = 1:iMax
%     if i == iMax
%         inputs1{1,i} = inputs;
%     else
%         inputs1{1,i} = inputs(4*i-3:4*i,:);
%     end
%     % Saving the confusionMatrix plot
%     textKelompok = sprintf('KelompokCiri%d',i);
%     for j = jMin:jMax
%         textHiddenLayer = sprintf('HiddenLayer%d',j);
%         [targets, outputs] = JST2(inputs1{1,i},j); % JST
%         figure, plotconfusion(targets, outputs, [textKelompok ' ' textHiddenLayer ' ']);
%         print([folder2 sprintf('CM_%s_%s',textKelompok,textHiddenLayer)],'-dpng');
%         close all;
%         clear targets outputs;
%         loading(sprintf('Plotting Kelompok%d %d',i,j), j, jMax);
%     end
%     loading('Confusion Matrix Plotting', i, 10);
% end