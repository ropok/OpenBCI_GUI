close all;
clear;
clc;

sesi = 'Sesi1';
subfolder = ['_' sesi '\'];
folder = ['D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_ciri\' subfolder];
folder1 = ['D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_ciri\'];
% files = dir([folder '*.mat']);
Ciri = [];


% Scattering - Variable
sc1 = [1 1 1 2 2 3];
sc2 = [2 3 4 3 4 4];
sc1_name = {'Fp1' 'Fp1' 'Fp1' 'Fp2' 'Fp2' 'C3'};
sc2_name = {'Fp2' 'C3'  'C4'  'C3'  'C4'  'C4'};

load([folder1 sprintf('ciri_%s.mat',sesi)]);

for i=1:6
    figure();
    for j = 1:length(Ciri)
	    hold on
	   % scatter([Ciri(j).PutihMean{:,sc1(i)}], [Ciri(j).PutihMean{:,sc2(i)}], 'xk' );
	   scatter([Ciri(j).MerahMean{:,sc1(i)}], [Ciri(j).MerahMean{:,sc2(i)}], 'or' );
	   scatter([Ciri(j).BiruMean{:,sc1(i)}], [Ciri(j).BiruMean{:,sc2(i)}], '*b' );
	    hold off
	end
   xlabel(sprintf('CH%d : %s', sc1(i), sc1_name{i}));
   ylabel(sprintf('CH%d : %s', sc2(i), sc2_name{i}));
   legend('Putih', 'Merah', 'Biru', 'Location', 'northeastoutside');
   judulFile = sprintf('Mean CH%d vs CH%d', sc1(i), sc2(i));
   title(judulFile);
	% print([folder 'Scattering CiriMean ' judulFile],'-dpng');
end