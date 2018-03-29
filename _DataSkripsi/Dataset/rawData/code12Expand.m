close all; clear; clc;

folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp11\';

files = dir([folder1 '*.txt']);

ciriRMS.M11 = [];
ciriRMS.M13 = [];
ciriRMS.B11 = [];
ciriRMS.B13 = [];

for h = 1:length(files)
% for h = 80:80
    [ciri_rms] = code12(files(h,1).name);
    ciriRMS.M11 = vertcat(ciriRMS.M11, ciri_rms.M11);
    ciriRMS.M13 = vertcat(ciriRMS.M13, ciri_rms.M13);
    ciriRMS.B11 = vertcat(ciriRMS.B11, ciri_rms.B11);
    ciriRMS.B13 = vertcat(ciriRMS.B13, ciri_rms.B13);
end
% ciriRMS.M = ciriRMS_M;
% ciriRMS.B = ciriRMS_B;
save([folder2 sprintf('ciriRMS.mat')],'ciriRMS');