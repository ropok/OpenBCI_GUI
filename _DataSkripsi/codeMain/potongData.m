function [M,B] = potongData(dataPre, fs, durasi)
    durasiFs = fs*durasi;
    sizeDataPre = size(dataPre);

    Mpre.a11 = dataPre(601:1600,:);
    Mpre.b11 = dataPre(3801:4800,:);
    Mpre.c11 = dataPre(7001:8000,:);
    Bpre.a11 = dataPre(2201:3200,:);
    Bpre.b11 = dataPre(5401:6400,:);
    Bpre.c11 = dataPre(8601:length(dataPre),:);

    for j = 1:sizeDataPre(2)
        M{1,j} = Mpre.a11(1:durasiFs,j);
        M{2,j} = Mpre.b11(1:durasiFs,j);
        M{3,j} = Mpre.c11(1:durasiFs,j);
        B{1,j} = Bpre.a11(1:durasiFs,j);
        B{2,j} = Bpre.b11(1:durasiFs,j);
        B{3,j} = Bpre.c11(1:durasiFs,j);
    end

end