
close all;
clear;
clc;

folder = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_Subjek1b_RAW\';
files = dir([folder '*.txt']);
Kode = 'Subjek1' ;
% qData = 10;

for i=1:length(files)
	ans = load([folder files(i).name]);
	ans = ans(:,2:5);
	if(i<=5)save([folder sprintf('%s_1%d.txt',Kode,i)],'ans','-ascii');
		else save([folder sprintf('%s_2%d.txt',Kode,i-5)],'ans','-ascii');
		end
end