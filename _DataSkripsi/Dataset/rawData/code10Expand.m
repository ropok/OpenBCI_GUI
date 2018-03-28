close all; clear; clc;

folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp10\';

files = dir([folder1 '*.txt']);

ciriRMS_M = []; 
ciriRMS_B = [];

for h = 1:length(files)
% for h = 80:80
    [M_TDrms,B_TDrms] = code10(files(h,1).name);
    ciriRMS_M = vertcat(ciriRMS_M,M_TDrms);
    ciriRMS_B = vertcat(ciriRMS_B,B_TDrms);
end
ciriRMS.M = ciriRMS_M;
ciriRMS.B = ciriRMS_B;
save([folder2 sprintf('ciriRMS.mat')],'ciriRMS');
% save([folder2 sprintf('ciriRMS.mat')],'ciriRMS_M','ciriRMS_B');
% save([folder2 sprintf('ciriRMS_B.mat')],'ciriRMS_B');