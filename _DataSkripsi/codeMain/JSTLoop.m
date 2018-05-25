% % -- Looping JST dengan menggunakan table
close all; clc;
labelDataLatih = {'tabel32Ciri_Sesi1' 'tabel32Ciri_Sesi2' 'tabel32Ciri_Sesi1Sesi2'};
labelDataUji = 'tabel32Ciri_Sesi2';
for i = 1:3 % Sesi1 Sesi2 Sesi1Sesi2
    for j = 1:9 % Subjek 1 - 9
        dataLatih = eval([labelDataLatih{i} '.subjek' num2str(j)]);
        dataUji = eval([labelDataUji '.subjek' num2str(j)]);

        disp(sprintf('Latih JST untuk Subjek%d - Sesi-%d',j,i));

        [JST{1}{i,j}, JST{2}{i,j}] = JST3(dataLatih, 10, dataUji);

        clear data;
        clc;
    end
end