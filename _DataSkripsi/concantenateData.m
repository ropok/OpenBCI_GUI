clc;
clear;
close all;
% Concatenate Vertical untuk semua kelas

% load('');

folder = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\';
files = dir([folder '*.txt']);

for i=1:length(files)
   load([folder files(i).name]);
end

n = vertcat(n_jalerse11, n_jalerse12, n_jalerse13, n_jalerse14, n_jalerse15);
l = vertcat(l_jalerse11, l_jalerse12, l_jalerse13, l_jalerse14, l_jalerse15);
r = vertcat(r_jalerse11, r_jalerse12, r_jalerse13, r_jalerse14, r_jalerse15);


save(sprintf('n_j.txt'),'n','-ascii')
save(sprintf('l_j.txt'),'l','-ascii')
save(sprintf('r_j.txt'),'r','-ascii')