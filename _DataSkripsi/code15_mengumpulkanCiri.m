close all;
clear;
clc;

sesi = 'Sesi1+Sesi2';
subfolder = ['_' sesi '\'];
folder = ['D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_ciri\' subfolder];
folder1 = ['D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_ciri\'];
files = dir([folder '*.mat']);
Ciri = [];

for h = 1:length(files)
	load([folder files(h).name]);
	Ciri = [Ciri ciri];
end
save([folder1 sprintf('ciri_%s.mat',sesi)], 'Ciri');