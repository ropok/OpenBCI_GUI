function [M,B] = potongData(dataPre, fs, durasi)
    durasiFs = fs*durasi;
    sizeDataPre = size(dataPre);

    Mpre.a = dataPre(601:1600,:);
    Mpre.b = dataPre(3801:4800,:);
    % Mpre.c = dataPre(7001:8000,:);

    % % Abaikan 1 sekon pertama
    % Ppre.a = [dataPre(201:600,:) ; dataPre(1601:2200,:)]; 
    % Ppre.b = [dataPre(3401:3800,:) ; dataPre(4801:5400,:)];
    % % Ppre.c = [dataPre(6601:7000,:) ; dataPre(8001:8600,:)];

    Bpre.a = dataPre(2201:3200,:);
    Bpre.b = dataPre(5401:6400,:);
    % Bpre.c = dataPre(8601:length(dataPre),:); 

    for j = 1:sizeDataPre(2) % Channel / Kanal
        for i = 1:5
            durasiAwal = ((i-1)*fs)+1;
            durasiAkhir = i*durasiFs;
    
            M{i,j} = Mpre.a(durasiAwal:durasiAkhir,j);
            M{i+5,j} = Mpre.b(durasiAwal:durasiAkhir,j);
    
            B{i,j} = Bpre.a(durasiAwal:durasiAkhir,j);
            B{i+5,j} = Bpre.b(durasiAwal:durasiAkhir,j);
    
            % P{i,j} = Ppre.a(durasiAwal:durasiAkhir,j);
            % P{i+5,j} = Ppre.b(durasiAwal:durasiAkhir,j);
        end

    end

end



