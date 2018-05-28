function [dataLatih, dataUji] = KFold(data,k)
% KFold - Description
%  Splitting data berdasarkan K-Fold untuk 3 ciri
% Syntax: [dataLatih, dataUji] = KFold(data,k)
%
% Long description

    for i = 1:k 
        % Init K-Fold configuration
        [~,N] = size(data);
        n = N/2;
        kn = n/k;
        Awal = ((i-1)*kn)+1;
        Akhir = i*kn;
        % K-Fold
        % - Init dataPre untuk dipotong-potong
        dataPre = [data(:,1:50) ; data(:,51:100)];
        % - ambil dataUji
        dataUjiPre = dataPre(:,Awal:Akhir); % K-Fold
        dataUji{i} = [dataUjiPre(1:32,:) dataUjiPre(33:64,:)]; % Ambil Merah Putih Biru untuk digabungin balik
        % - ambil dataLatih
        dataLatihPre = dataPre;
        dataLatihPre(:,Awal:Akhir) = []; % K-Fold -> hilangin bagian dataUji
        dataLatih{i} = [dataLatihPre(1:32,:) dataLatihPre(33:64,:)]; % Ambil Merah Putih Biru untuk digabungin balik
        clear dataPre dataUjiPre dataLatihPre 
    end
    
end