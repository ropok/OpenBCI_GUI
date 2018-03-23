
MERAH_N = [dataPB(601:1600,:) ; dataPB(3801:4800,:) ; dataPB(7001:8000,:)];
BIRU_N = [dataPB(2201:3200,:); dataPB(5401:6400,:); dataPB(8601:length(dataPB),:)];

M_N = PSD(MERAH_N);
B_N = PSD(BIRU_N);

plotPSD(M_N,'Merah'); xlim([9 15]);
plotPSD(B_N,'Biru'); xlim([9 15]);