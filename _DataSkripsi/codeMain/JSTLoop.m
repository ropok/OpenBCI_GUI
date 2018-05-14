% % -- Looping JST dengan menggunakan table
close all; clc;
% folder = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp28_LatihVariasiSesi\';
% label = 'JST32Ciri_Sesi1Sesi2';
for i = 2:9
    data = eval(['data1.subjek' num2str(i)]);
    % dataUji = eval(['data2.subjek' num2str(i)]); % Sesi2
    disp(sprintf('Latih JST untuk Subjek%d',i));
    subjek{i} = JST(data, 10); % JST(inputs, maxAttemps)
    % save([folder label '.mat'], 'subjek');
    % save D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp28_LatihVariasiSesi\JST32Ciri_Sesi1.mat subjek;

    clear data;
    clc;
end
% save D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp32\dataUji.mat dataUji;

% % -- PerSubjek JST dengan menggunakan table
% close all; clc;
% noSubjek = 2;
%     data = eval(['data1.subjek' num2str(noSubjek)]);
%     disp(sprintf('Latih JST untuk Subjek%d',noSubjek));
%     subjek{noSubjek} = JST(data, 20, 50); % JST(inputs, maxHiddenNode, maxAttemps)

%     clear data;