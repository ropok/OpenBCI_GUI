function [M,B] = potongData(dataPre, fs, durasi)
    durasiFs = fs*durasi;
    sizeDataPre = size(dataPre);

    % Data Merah
    Mpre.a = dataPre(601:1600,:);
    Mpre.b = dataPre(3801:4800,:);

    % Data Biru
    Bpre.a = dataPre(2201:3200,:);
    Bpre.b = dataPre(5401:6400,:);

    batasPotong = length(Mpre.a)/durasiFs;

    for j = 1:sizeDataPre(2) % Channel / Kanal
        for i = 1:batasPotong
            durasiAwal = ((i-1)*durasiFs)+1;
            durasiAkhir = i*durasiFs;
    
            M{i,j} = Mpre.a(durasiAwal:durasiAkhir,j);
            M{i+batasPotong,j} = Mpre.b(durasiAwal:durasiAkhir,j);
    
            B{i,j} = Bpre.a(durasiAwal:durasiAkhir,j);
            B{i+batasPotong,j} = Bpre.b(durasiAwal:durasiAkhir,j);
    
            % P{i,j} = Ppre.a(durasiAwal:durasiAkhir,j);
            % P{i+5,j} = Ppre.b(durasiAwal:durasiAkhir,j);
        end

    end

end



