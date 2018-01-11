% sambil baca docs nya matlab untuk bagian "smooth" ya, di matlab bagian console ketik aja doc smooth

span = 0.5; % span 0.5 artinya setengah dari data yang ada yang di Moving Average (MA). contohnya jika aku ambil data 2 detik berarti yang di rata-rata kan itu 1 detiknya.
sMethod = 'moving';

garisMovingAverage = smooth(t, data, span, sMethod);


plot(t, garisMovingAverage); %ini ngeplot garis MAnya saja

plot(t, garisMovingAverage, t, data); % yang ini ngeplot garis MA sama garis eegnya.