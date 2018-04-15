function [dataPSD] = PSDAll(data, fs)
%PSDAll - Membuat PSD dari seluruh isi cell.
%
% Syntax: [dataPSD] = PSDAll(data, fs)
%
% Long description : 
% o Output : dataPSD dengan dimensi yang sama dengan input
% Example :
% input : data (3x4 cell) - cell
% [dataPSD] = PSDAll(data, 200)
% Output : dataPSD (3x4 psd) - non cell
    sizeData = size(data);
    for i = 1:sizeData(1)
        for j = 1:sizeData(2)
            Pxx = abs(fft(data{i,j})).^2/length(data{i,j})/fs;
            dataPSD(i,j) = dspdata.psd(Pxx(1:length(Pxx)/2), 'Fs',fs);
            clear Pxx;
        end
    end
end