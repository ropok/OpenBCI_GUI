function [dataPSD] = PSDAll(data, fs)
    sizeData = size(data);
    for i = 1:sizeData(1)
        for j = 1:sizeData(2)
            Pxx = abs(fft(data{i,j})).^2/length(data{i,j})/fs;
            dataPSD(i,j) = dspdata.psd(Pxx(1:length(Pxx)/2), 'Fs',fs);
            clear Pxx;
        end
    end
end