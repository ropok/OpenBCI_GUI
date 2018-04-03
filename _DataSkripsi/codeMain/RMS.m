function [dataRMS] = RMS(data)
    sizeData = size(data);
    for i = 1:sizeData(1)
        for j = 1:sizeData(2)
            dataRMS(i,j) = rms(data{i,j});
        end
    end
end