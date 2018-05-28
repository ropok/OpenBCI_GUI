% % KFold untuk subjek 1-9
% close all; clc;
% labelData = {'Ciri32_sesi1' 'Ciri32_Sesi2'};
% for i = 1:size(labelData,2)
%     dataSubjek{i} = eval([labelData{i}]);
%     for j = 1:9
%         dataLatih = [];
%         dataUji = [];

%         dataLatih = 

%     end
% end

% KFold untuk subjek 1-9
close all; clc;
    k = 5;
    labelData = 'Ciri32_Sesi2';
    data = eval(labelData);
    dataLatih = [];
    dataUji = [];
    for i = 1:9
        [L, U] = KFold(data{i}, k);
        dataLatih = [dataLatih ; L];
        dataUji = [dataUji ; U];
    end
dataLatih = dataLatih';
dataUji = dataUji';