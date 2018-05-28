% Loop JST untuk CV

for j = 1 : size(dataLatih,2)
    for i = 1 : size(dataLatih,1)
        disp(sprintf('Cross Validation untuk Subjek%d - %d-Fold',j,i));
        [CV_Sesi1{1}{i,j}, CV_Sesi1{2}(i,j), CV_Sesi1{3}{i,j}] = JST3(dataLatih{i,j}, 10, dataUji{i,j});
    end
    save D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData2\temp5\CV_Sesi1.mat CV_Sesi1
end