% Loop JST untuk CV

for j = 1 : size(dataLatih,2)
    for i = 1 : size(dataLatih,1)
        disp(sprintf('Cross Validation untuk Subjek%d - %d-Fold',j,i));
        [CV_Sesi2_25{1}{i,j}, CV_Sesi2_25{2}{i,j}, CV_Sesi2_25{3}{i,j}] = JST3(dataLatih{i,j}, 10, dataUji{i,j});
    end
end