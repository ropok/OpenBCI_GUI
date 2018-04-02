function [dataPSD] = PSD(data, fs)
    fs =  200;
    Pxx = abs(fft(data)).^2/length(data)/fs;
    dataPSD = dspdata.psd(Pxx(1:length(Pxx)/2), 'Fs',fs);
end