function [dataRMS_SD] = RMS_SD(data)
    sizeData = size(data);
    for i = 1:sizeData(1)
        for j = 1:sizeData(2)
            % dataRMS_SD(i,j) = rms(data{i,j})/std(data{i,j});
            dataRMS_SD(i,j) = std(data{i,j});
        end
    end
end