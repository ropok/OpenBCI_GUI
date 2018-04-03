% -- Ratio RMS : returns Score of Ratio
function [scoreM, scoreB] = RatioRMS(dataRMS)
scoreM = [];
scoreB = [];
    for i = 1:3
        for j = 4:6
            % Merah
            rM = dataRMS{1,i} ./ dataRMS{1,j};
            % Biru
            rB = dataRMS{2,i} ./ dataRMS{2,j};

            scoreM = [scoreM sum(sum(rM>1))];
            scoreB = [scoreB sum(sum(rB>1))];
            clear rM rB;
        end
    end

end