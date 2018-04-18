function [data] = filterBP(dataPre, fs, cutOn, cutOff)
    [b,a] = butter(2,[cutOn cutOff]/(fs/2), 'bandpass');
    BP = [cutOn cutOff];
    sizeDataPre = size(dataPre);
    for j=1:sizeDataPre(2)
        data(:,j) = filter(b,a,dataPre(:,j));
    end
end