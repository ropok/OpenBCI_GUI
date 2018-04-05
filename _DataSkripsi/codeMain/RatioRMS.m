% -- Ratio RMS : returns Score of Ratio
function [rM_gab, rB_gab] = RatioRMS(dataRMS)
scoreM = [];
scoreB = [];
rM_gab = [];
rB_gab = [];
%     for i = 1:3
%         for j = 4:6
%             % Merah
%             rM = dataRMS{1,i} ./ dataRMS{1,j};
%             % Biru
%             rB = dataRMS{2,i} ./ dataRMS{2,j};



%             % scoreM = [scoreM sum(sum(rM>1))];
%             % scoreB = [scoreB sum(sum(rB>1))];
%             rM_gab = [rM_gab rM];
%             rB_gab = [rB_gab rB];
%             % clear rM rB;
%         end
%     end

% end

rm11 = dataRMS{1,1} ./ dataRMS{1,4}; % RMS 11 / RMS 13
rm13 = dataRMS{1,2} ./ dataRMS{1,5}; % RMS 22 / RMS 26
rM_gab = [rm11 rm13];

rb11 = dataRMS{2,1} ./ dataRMS{2,4}; % RMS 11 / RMS 13
rb13 = dataRMS{2,2} ./ dataRMS{2,5}; % RMS 22 / RMS 26
rB_gab = [rb11 rb13];