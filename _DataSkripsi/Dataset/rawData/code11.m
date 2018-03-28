% Scattering Ciri CHx vs CHy
close all; clear; clc;
% --- Directory
folder = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp10\';

% --- Variable
sc1 = [1 1 1 2 2 3];
sc2 = [2 3 4 3 4 4];
sc1_name = {'Fp_1' 'Fp_1' 'Fp_1' 'Fp_2' 'Fp_2' 'C_3'};
sc2_name = {'Fp_2' 'C_3'  'C_4'  'C_3'  'C_4'  'C_4'};

load([folder 'ciriRMS.mat']);

maxCiriRMS = max([max(ciriRMS.M) max(ciriRMS.B)]);
minCiriRMS = min([min(ciriRMS.M) min(ciriRMS.B)]);
% -- Normalisasi
    tempN_M = ciriRMS.M - minCiriRMS;
    tempN_M = tempN_M ./ maxCiriRMS;
    ciriRMSN.M = tempN_M;
    
    tempN_B = ciriRMS.B - minCiriRMS;
    tempN_B = tempN_B ./ maxCiriRMS;
    ciriRMSN.B = tempN_B;

    
% --- Scattering
for i=1:6
    figure();
    hold on
        scatter(ciriRMSN.M(:,sc1(i)), ciriRMSN.M(:,sc2(i)), 'or');
        scatter(ciriRMSN.B(:,sc1(i)), ciriRMSN.B(:,sc2(i)), 'xb');
    hold off
    xlabel(sprintf('%s', sc1_name{i}));
    ylabel(sprintf('%s', sc2_name{i}));
    legend('Merah','Biru' , 'Location','northeastoutside');
    title({'Scattering Ciri RMS-N'; [ sprintf('%s vs %s',sc1_name{i},sc2_name{i} )]});
    print([folder sprintf('Scattering Ciri RMS-N %s vs %s',sc1_name{i},sc2_name{i})], '-dpng');
end

% --- Scattering
% for i=1:6
%     figure();
%     hold on
%         scatter(ciriRMS.M(:,sc1(i)), ciriRMS.M(:,sc2(i)), 'or');
%         scatter(ciriRMS.B(:,sc1(i)), ciriRMS.B(:,sc2(i)), 'xb');
%     hold off
%     xlabel(sprintf('%s', sc1_name{i}));
%     ylabel(sprintf('%s', sc2_name{i}));
%     legend('Merah','Biru' , 'Location','northeastoutside');
%     title({'Scattering Ciri RMS'; [ sprintf('%s vs %s',sc1_name{i},sc2_name{i} )]});
%     print([folder sprintf('Scattering Ciri RMS %s vs %s',sc1_name{i},sc2_name{i})], '-dpng');
% end