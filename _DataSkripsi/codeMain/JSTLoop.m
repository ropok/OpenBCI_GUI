% % -- Looping JST dengan menggunakan table
close all; clc;
labelDataLatih = {'tabel32Ciri_Sesi1' 'tabel32Ciri_Sesi2' 'tabel32Ciri_Sesi1Sesi2'};
labelDataUji = 'tabel32Ciri_Sesi2';
for i = 1:3
    for j = 1:9
        dataLatih = eval([labelDataLatih{i} '.subjek' num2str(j)]);
        dataUji = eval([labelDataUji '.subjek' num2str(j)]);

        disp(sprintf('Latih JST untuk Subjek%d',j));

        % subjek{i} = JST2(dataLatih, 10, dataUji); 
        [JST{1}{i,j}, JST{2}{i,j}] = JST2(dataLatih, 10, dataUji);

        clear data;
        clc;
    end
end