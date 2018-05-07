% % -- Looping JST dengan menggunakan table
close all; clc;
for i = 2:2
    data = eval(['data1.subjek' num2str(i)]);
    disp(sprintf('Latih JST untuk Subjek%d',i));
    subjek{i} = JST(data, 20, 10); % JST(inputs, maxHiddenNode, maxAttemps)

    save D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp26-Klasifikasi2\JST8Ciri.mat subjek;

    clear data;
    clc;
end

% % -- PerSubjek JST dengan menggunakan table
% close all; clc;
% noSubjek = 2;
%     data = eval(['data1.subjek' num2str(noSubjek)]);
%     disp(sprintf('Latih JST untuk Subjek%d',noSubjek));
%     subjek{noSubjek} = JST(data, 20, 50); % JST(inputs, maxHiddenNode, maxAttemps)

%     clear data;