% Saving File management - to RAW ready pre-processing %


close all;
clear;
clc;
subjek = '6a';
folder = ['D:\Jaler\OpenBCI_GUI\OpenBCI_GUI\application.windows64\SavedData\subjek' subjek '\'];
folderSave = ['D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_Subjek' subjek '\'];
kode = ['subjek' subjek '_'];
files = dir([folder '*.txt']);

%% Main %%
for h=1:length(files)
	ans = load([folder files(h).name]);
	data = ans(:,2:5);
	filename = sprintf('%s%s%d.txt',folderSave,kode,h);
	save(filename,'data','-ascii');
	% save([folder sprintf('%s%d.mat',Kode,h)],'data');
end