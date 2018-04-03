% -- Ratio RMS : returns Score of Ratio
function [scoreM, scoreB] = RatioRMS(dataRMS)

    for i = 1:3
        for j = 4:6
            % Merah
            rM = dataRMS{1,i} ./ dataRMS{1,j};
            % Biru
            rB = dataRMS{2,i} ./ dataRMS{2,j};

            clear rM rB;
        end
    end

end