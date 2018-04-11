% -- Ratio RMS : returns Score of Ratio
function [rM_gab, rB_gab] = RatioRMS2(dataRMS)
% scoreM = [];
% scoreB = [];
rM_gab = [];
rB_gab = [];

        rM1 = dataRMS{1,1} ./ dataRMS{1,2};
        rM2 = dataRMS{1,1} ./ dataRMS{1,3};
        rM3 = dataRMS{1,2} ./ dataRMS{1,3};

        rB1 = dataRMS{2,1} ./ dataRMS{2,2};
        rB2 = dataRMS{2,1} ./ dataRMS{2,3};
        rB3 = dataRMS{2,2} ./ dataRMS{2,3};

            rM_gab = [rM1 rM2 rM3];
            rB_gab = [rB1 rB2 rB3];

end