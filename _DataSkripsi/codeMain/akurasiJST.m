% -- Akurasi JST
close all; clear; clc;
folder2 = 'D:\Jaler\OpenBCI_GUI\_DataSkripsi\Dataset\rawData\temp21\';
load([folder2 'ciriSesi1.mat']);
load([folder2 'ciriSesi2.mat']);
load([folder2 'ciriSesi1Sesi2.mat']);

% -- Generate Inputs
Am1 = ciriSesi1.RMS1_Merah;
Ab1 = ciriSesi1.RMS1_Biru;
Bm1 = ciriSesi1.RMS2_Merah;
Bb1 = ciriSesi1.RMS2_Biru;
Cm1 = ciriSesi1.RatioRMS1_Merah;
Cb1 = ciriSesi1.RatioRMS1_Biru;
Dm1 = ciriSesi1.RatioRMS2_Merah;
Db1 = ciriSesi1.RatioRMS2_Biru;
inputs1{1} = [Dm1 Db1];
% inputs1{1} = [Am1 Ab1];
% inputs1{2} = [Bm1 Bb1];
% inputs1{3} = [Cm1 Cb1];
% inputs1{4} = [Dm1 Db1];
% inputs1{5} = [Am1 Bm1 Ab1 Bb1];
% inputs1{6} = [Am1 Cm1 Ab1 Cb1];
% inputs1{7} = [Am1 Dm1 Ab1 Db1];
% inputs1{8} = [Bm1 Cm1 Bb1 Cb1];
% inputs1{9} = [Bm1 Dm1 Bb1 Db1];
% inputs1{10} = [Cm1 Dm1 Cb1 Db1];
% inputs1{11} = [Am1 Bm1 Cm1 Dm1 Ab1 Bb1 Cb1 Db1];

Am2 = ciriSesi2.RMS1_Merah;
Ab2 = ciriSesi2.RMS1_Biru;
Bm2 = ciriSesi2.RMS2_Merah;
Bb2 = ciriSesi2.RMS2_Biru;
Cm2 = ciriSesi2.RatioRMS1_Merah;
Cb2 = ciriSesi2.RatioRMS1_Biru;
Dm2 = ciriSesi2.RatioRMS2_Merah;
Db2 = ciriSesi2.RatioRMS2_Biru;
inputs2{1} = [Dm2 Db2];
% inputs2{1} = [Am2 Ab2];
% inputs2{2} = [Bm2 Bb2];
% inputs2{3} = [Cm2 Cb2];
% inputs2{4} = [Dm2 Db2];
% inputs2{5} = [Am2 Bm2 Ab2 Bb2];
% inputs2{6} = [Am2 Cm2 Ab2 Cb2];
% inputs2{7} = [Am2 Dm2 Ab2 Db2];
% inputs2{8} = [Bm2 Cm2 Bb2 Cb2];
% inputs2{9} = [Bm2 Dm2 Bb2 Db2];
% inputs2{10} = [Cm2 Dm2 Cb2 Db2];
% inputs2{11} = [Am2 Bm2 Cm2 Dm2 Ab2 Bb2 Cb2 Db2];

Am12 = ciriSesi1Sesi2.RMS1_Merah;
Ab12 = ciriSesi1Sesi2.RMS1_Biru;
Bm12 = ciriSesi1Sesi2.RMS2_Merah;
Bb12 = ciriSesi1Sesi2.RMS2_Biru;
Cm12 = ciriSesi1Sesi2.RatioRMS1_Merah;
Cb12 = ciriSesi1Sesi2.RatioRMS1_Biru;
Dm12 = ciriSesi1Sesi2.RatioRMS2_Merah;
Db12 = ciriSesi1Sesi2.RatioRMS2_Biru;
inputs12{1} = [Dm2 Db2];
% inputs12{1} = [Am12 Ab12];
% inputs12{2} = [Bm12 Bb12];
% inputs12{3} = [Cm12 Cb12];
% inputs12{4} = [Dm12 Db12];
% inputs12{5} = [Am12 Bm12 Ab12 Bb12];
% inputs12{6} = [Am12 Cm12 Ab12 Cb12];
% inputs12{7} = [Am12 Dm12 Ab12 Db12];
% inputs12{8} = [Bm12 Cm12 Bb12 Cb12];
% inputs12{9} = [Bm12 Dm12 Bb12 Db12];
% inputs12{10} = [Cm12 Dm12 Cb12 Db12];
% inputs12{11} = [Am12 Bm12 Cm12 Dm12 Ab12 Bb12 Cb12 Db12];

% A2 = [ciriSesi2.RMS1_Merah ciriSesi2.RMS1_Biru];
% B2 = [ciriSesi2.RMS2_Merah ciriSesi2.RMS2_Biru];
% C2 = [ciriSesi2.RatioRMS1_Merah ciriSesi2.RatioRMS1_Biru];
% D2 = [ciriSesi2.RatioRMS2_Merah ciriSesi2.RatioRMS2_Biru];

% A12 = [ciriSesi1Sesi2.RMS1_Merah ciriSesi1Sesi2.RMS1_Biru];
% B12 = [ciriSesi1Sesi2.RMS2_Merah ciriSesi1Sesi2.RMS2_Biru];
% C12 = [ciriSesi1Sesi2.RatioRMS1_Merah ciriSesi1Sesi2.RatioRMS1_Biru];
% D12 = [ciriSesi1Sesi2.RatioRMS2_Merah ciriSesi1Sesi2.RatioRMS2_Biru];

for j = 1:length(inputs1)
    for HL = 1:20
        akurasi_Sesi1(HL,j) = JST(inputs1{j},HL);
        akurasi_Sesi2(HL,j) = JST(inputs2{j},HL);
        akurasi_Sesi1Sesi2(HL,j) = JST(inputs12{j},HL);
    end
        loading('JST',j,length(inputs1));
end

% for HL = 1:20
%     akurasi_Sesi1(HL,1) = JST(A1,HL);
%     akurasi_Sesi1(HL,2) = JST(B1,HL);
%     akurasi_Sesi1(HL,3) = JST(C1,HL);
%     akurasi_Sesi1(HL,4) = JST(D1,HL);


%     akurasi_Sesi2(HL,1) = JST(A2,HL);
%     akurasi_Sesi2(HL,2) = JST(B2,HL);
%     akurasi_Sesi2(HL,3) = JST(C2,HL);
%     akurasi_Sesi2(HL,4) = JST(D2,HL);
    
%     akurasi_Sesi1Sesi2(HL,1) = JST(A12,HL);
%     akurasi_Sesi1Sesi2(HL,2) = JST(B12,HL);
%     akurasi_Sesi1Sesi2(HL,3) = JST(C12,HL);
%     akurasi_Sesi1Sesi2(HL,4) = JST(D12,HL);

%     loading('JST',1,20);
% end