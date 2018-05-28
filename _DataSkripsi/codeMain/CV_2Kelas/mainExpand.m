% -- Untuk Looping pemilihan sesi mana yang akan diekstraksi ciri

close all; clear; clc;

% folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\';             % Sesi1 Sesi2
% folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\Sesi1\';     % Sesi1
folder1 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\Sesi2\';     % Sesi2
% folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp21\';

ciriMerah = [];
% ciriPutih = [];
ciriBiru = [];
% ciriSesi = 'Sesi1';
files = dir([folder1 '*.txt']); 

% Mengumpulkan data dari semua objek
i = 1; % indeks untuk dimasukkin ke subjek
for h = 1:length(files)
% for h = 1:1
% for h = 77:86 % for Test purpose
    [M,B] = mainLoop(folder1, files(h,1).name, 1);

    % -- Mengumpulkan rM seluruh subjek ------
    ciriMerah = [ciriMerah M];
    % ciriPutih = [ciriPutih P];
    ciriBiru = [ciriBiru B];
    loading('Load Data', h, length(files));


    % - beri if untuk dimasukan ke subjek;
    if mod(h,5) == 0
        subjek{i} = [ciriMerah ciriBiru];
        % kosongin biar bisa ciri lagi
        ciriMerah = [];
        % ciriPutih = [];
        ciriBiru = [];
        i = i +1;
    end

end
clearvars -except subjek
% % Membuat Tabel + Pelabelan
% % -- Menata variable untuk table (Sesi1Sesi2)
% for i = 0:7
%     start = i*30+1;
%     finish = i*30+30;
%     subjek{i+2} = [ciriMerah(:,start:finish) ciriBiru(:,start:finish)];
% end

% % % -- Menata variable untuk table (1 Sesi)
% % for i = 0:7
% %     start = i*15+1;
% %     finish = i*15+15;
% %     subjek{i+2} = [ciriMerah(:,start:finish) ciriBiru(:,start:finish)];
% % end

% % % -- Menata variable untuk table
% % subjek1 = subjek{1};
% % subjek2 = subjek{2};
% % subjek3 = subjek{3};    
% % subjek4 = subjek{4};
% % subjek5 = subjek{5};
% % subjek6 = subjek{6};
% % subjek7 = subjek{7};
% % subjek8 = subjek{8};
% % subjek9 = subjek{9};

% % -- Labeling Row untuk Nama Ciri
% RowCiri = {'ciriDelta_Fp1' ; 'ciriDelta_Fp2' ; 'ciriDelta_C3' ; 'ciriDelta_C4' ; ...
%             'ciriTheta_Fp1' ;  'ciriTheta_Fp2' ;  'ciriTheta_C3' ;  'ciriTheta_C4' ; ... 
%             'ciriAlpha_Fp1' ;  'ciriAlpha_Fp2' ;  'ciriAlpha_C3' ;  'ciriAlpha_C4' ; ... 
%             'ciriBeta_Fp1' ;  'ciriBeta_Fp2' ;  'ciriBeta_C3' ;  'ciriBeta_C4' ; ... 
%             'ciriGamma_Fp1' ;  'ciriGamma_Fp2' ;  'ciriGamma_C3' ;  'ciriGamma_C4' ; ... 
            
%             'ciri11Hz_Fp1' ;  'ciri11Hz_Fp2' ;  'ciri11Hz_C3' ;  'ciri11Hz_C4' ; ... 
%             'ciri22Hz_Fp1' ;  'ciri22Hz_Fp2' ;  'ciri22Hz_C3' ;  'ciri22Hz_C4' ; ... 
%             'ciri33Hz_Fp1' ;  'ciri33Hz_Fp2' ;  'ciri33Hz_C3' ;  'ciri33Hz_C4' ; ... 
%             'ciri13Hz_Fp1' ;  'ciri13Hz_Fp2' ;  'ciri13Hz_C3' ;  'ciri13Hz_C4' ; ... 
%             'ciri26Hz_Fp1' ;  'ciri26Hz_Fp2' ;  'ciri26Hz_C3' ;  'ciri26Hz_C4' ; ... 
%             'ciri39Hz_Fp1' ;  'ciri39Hz_Fp2' ;  'ciri39Hz_C3' ;  'ciri39Hz_C4' ; ... 
%             };


% tabel32Ciri_Sesi1Sesi2 = table(subjek2, subjek3, subjek4, subjek5, subjek6, subjek7, subjek8, subjek9, 'RowNames', RowCiri);