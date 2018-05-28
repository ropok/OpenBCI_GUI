function [data] = filterNotch50(dataPre, fs)
    [b,a] = butter(2,[49 51]/(fs/2), 'stop');
    sizeDataPre = size(dataPre);
    for j=1:sizeDataPre(2)
        data(:,j) = filter(b,a,dataPre(:,j));
    end
end