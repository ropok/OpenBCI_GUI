close all;
clear;
clc;
sesi = 'Sesi1+Sesi2';
subfolder = ['_' sesi '\'];
folder = ['D:\Jaler\OpenBCI_GUI\_DataSkripsi\data_ciri\'];
folderLDA = ['D:\Jaler\OpenBCI_GUI\_DataSkripsi\_LDA\'];
% files = dir([folder '*.mat']);
temp = [];
sumSubjek = 8;
sumCH = 4;

% % Scattering - Variable
sc1 = [1 1 1 2 2 3];
sc2 = [2 3 4 3 4 4];
sc1_name = {'Fp1' 'Fp1' 'Fp1' 'Fp2' 'Fp2' 'C3'};
sc2_name = {'Fp2' 'C3'  'C4'  'C3'  'C4'  'C4'};

load([folder sprintf('ciri_%s.mat',sesi)]);


% ------------------------------------------------------------------------
%  Menggabungkan Ciri dari semua subjek
% ------------------------------------------------------------------------
% -- Kelas Putih --
for i = 1:sumCH
    for j = 1:sumSubjek
        temp = vertcat(temp, cell2mat(Ciri(j).PutihMean(:,i)));
    end
    tempCiriPutih(:,i) = temp;
    temp = [];
end

% -- Kelas Merah --
for i = 1:sumCH
    for j = 1:sumSubjek
        temp = vertcat(temp, cell2mat(Ciri(j).MerahMean(:,i)));
    end
    tempCiriMerah(:,i) = temp;
    temp = [];
end
% -- Kelas Biru --
for i = 1:sumCH
    for j = 1:sumSubjek
        temp = vertcat(temp, cell2mat(Ciri(j).BiruMean(:,i)));
    end
    tempCiriBiru(:,i) = temp;
    temp = [];
end

ciriMean = vertcat(tempCiriPutih, tempCiriMerah, tempCiriBiru);
% Inputs = ciriMean';
% Targets = 
qPutih = length(Ciri)*length(Ciri(1).PutihMean);
qMerah = length(Ciri)*length(Ciri(1).MerahMean);
qBiru = length(Ciri)*length(Ciri(1).BiruMean);
Targets = zeros(3,length(ciriMean));
% Targets(1,1:200) = ones;
% Targets(2,201:320) = ones;
% Targets(3,321:440) = ones;

Targets(1,1:qPutih) = ones;
Targets(2,qPutih+1:qPutih+qMerah) = ones;
Targets(3,qPutih+qMerah+1:length(ciriMean)) = ones;

data.Inputs = ciriMean';
data.Targets = Targets;
save ([folderLDA sprintf('Mean_%s.mat',sesi)], '-struct', 'data');
% save ([folder sprintf('ciriMean_%s.mat',sesi)],'ciriMean');
% panjangSatuKelas = length(tempCiriBiru);
% panjangDuaKelas = length(ciriMean);

% % ------------------------------------------------------------------------
% %  Membuat Target
% % ------------------------------------------------------------------------
% target = [zeros(length(tempCiriMerah),1); ones(length(tempCiriBiru),1)];

% % ------------------------------------------------------------------------
% %  Rumus Dasar Fungsi LDA
% % ------------------------------------------------------------------------
% % % -- Calculate linear discriminant coefficients --
% % W = LDA(Input,Target,Priors)
% % W = LDA(X,Y);

% % % -- Calulcate linear scores for training data --
% % L = [ones(25,1) X] * W';

% % % -- Calculate class probabilities --
% % P = exp(L) ./ repmat(sum(exp(L),2),[1 2]);

% X = [ciriMean(:,1) ciriMean(:,2)];
% Y = target;
% W = LDA(X,Y);
% L = [ones(panjangDuaKelas,1) X] * W';
% P = exp(L) ./ repmat(sum(exp(L),2),[1 2]);

% for i=1:length(sc1)
%     X = [ciriMean(:,sc1(i)) ciriMean(:,sc2(i))];
%     Y = target;
%     W = LDA(X,Y);
%     L = [ones(panjangDuaKelas,1) X] * W';
%     P = exp(L) ./ repmat(sum(exp(L),2),[1 2]);
%     figure();
%     hold on
%         scatter(P(1:panjangSatuKelas,1), P(1:panjangSatuKelas,2), 'or');
%         scatter(P(panjangSatuKelas:panjangDuaKelas,1), P(panjangSatuKelas:panjangDuaKelas,2), '*b');
%     hold off
%     xlabel(sprintf('CH%d : %s', sc1(i), sc1_name{i}));
%     ylabel(sprintf('CH%d : %s', sc2(i), sc2_name{i}));
%     legend('Merah', 'Biru', 'Location', 'northeastoutside');
%     judulFile = sprintf('%s CH%d vs CH%d', sesi, sc1(i), sc2(i));
%     title(judulFile);
%     print([folder 'LDA Mean ' judulFile],'-dpng');
% end

% % ------------------------------------------------------------------------
% %  Proses LDA - Ricahyo
% % ------------------------------------------------------------------------
% % klasifikasiLDA = fitcdiscr(ciriMean,target);

% % %mencari nilai koefis(ien linear
% % [b,eval]=eig(klasifikasiLDA.BetweenSigma,klasifikasiLDA.Sigma);

% % %mengurutkan nilai b (eigenvektor) dan eigenvalue
% % eval(isnan(eval)) = 0;
% % [eval, ind] = sort(diag(eval), 'descend');
% % b = b(:,ind(1:min([2 size(b, 2)])));
% % % b = b(:,ind(1:min([3 size(b, 2)])));

% % %mencari score baru hasil LDA
% % z=ciriMean*b;

% % %klasifikasi menggunakan mahalanobis Distance
% % [klasifikasi,err] = classify(z,z,target,'mahalanobis');
% % akurasi=(1-err)*100

% % for i=1:6
% %     figure();
% %     for j = 1:length(Ciri)
% % 	    hold on
% % 	   scatter([Ciri(j).PutihMean{:,sc1(i)}], [Ciri(j).PutihMean{:,sc2(i)}], 'xk' );
% % 	   scatter([Ciri(j).MerahMean{:,sc1(i)}], [Ciri(j).MerahMean{:,sc2(i)}], 'or' );
% % 	   scatter([Ciri(j).BiruMean{:,sc1(i)}], [Ciri(j).BiruMean{:,sc2(i)}], '*b' );
% % 	    hold off
% % 	end
% %    xlabel(sprintf('CH%d : %s', sc1(i), sc1_name{i}));
% %    ylabel(sprintf('CH%d : %s', sc2(i), sc2_name{i}));
% %    legend('Putih', 'Merah', 'Biru', 'Location', 'northeastoutside');
% %    judulFile = sprintf('Mean CH%d vs CH%d', sc1(i), sc2(i));
% %    title(judulFile);
% % 	% print([folder 'Scattering CiriMean ' judulFile],'-dpng');
% % end