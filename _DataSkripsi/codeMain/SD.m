function [dataSD] = SD(data)
    %SD - Standard Deviation [2.3]
    %
    % Syntax: [dataSD] = SD(data)
    %
    % Long description 
    sizeData = size(data);
    for i = 1:sizeData(1)
        for j = 1:sizeData(2)
            dataSD(i,j) = sqrt( (sumsqr(data{i,j})-rms(data{i,j}) )/length(data{i,j})-1 );
        end
    end
end