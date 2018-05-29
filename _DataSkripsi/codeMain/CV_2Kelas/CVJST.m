% Loop JST untuk CV 2 KELAS

for j = 1 : size(dataLatih,2)
    for i = 1 : size(dataLatih,1)
        disp(sprintf('Cross Validation untuk Subjek%d - %d-Fold',j,i));
        [CV_Sesi2{1}{i,j}, CV_Sesi2{2}(i,j), CV_Sesi2{3}{i,j}] = JST3(dataLatih{i,j}, 10, dataUji{i,j});
    end
    save D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData2\temp4\CV_Sesi2.mat CV_Sesi2 
end