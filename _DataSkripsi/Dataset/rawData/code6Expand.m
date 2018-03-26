close all; clear; clc;

folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';
folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp6\';

files = dir([folder1 '*.txt']);

% for h = 1:length(files)
for h = 1:1
    code6(files(h,1).name, folder2);
end
% for h=1:length(files)
% 	csvread([folder files(h).name]);	
% %% 1. Filter Data
% 	for j=1:4
% 		ans(:,j)=filter(b,a,ans(:,j));
% 		ans(:,j)=filter(d,c,ans(:,j));
% 	end
% 	save([folder sprintf('%s%d.mat',Kode,h)],'ans');
% end