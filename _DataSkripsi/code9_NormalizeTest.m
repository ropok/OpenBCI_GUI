close all;
clc;
clear;


KelasList = {'Putih' 'Merah' 'Biru'};
folder = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_jalerse\';

load('dataMean.mat');
% nom = dataMean{1,1}.ans;
% norm11 = nom - min(nom);
% norm11 = norm11 ./ max(norm11(:));

for j=1:3
	for i=1:4
		dataMean{j,i}.ans - min(dataMean{j,i}.ans);
		ans = ans ./ max(ans(:));
		% save([folder sprintf('norm%s_CH%d.mat',KelasList{j},i)], 'ans');
		dataNorm{j,i}=ans;
	end
end

save([folder 'dataNorm.mat'], 'dataNorm');