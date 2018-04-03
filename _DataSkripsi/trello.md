Selamat sore mas CATUR, kali ini saya hitung ratio RMS pada subjek-subjek dengan pengambilan data **Warna Merah (11 Hz)** dan **Warna Biru (13 Hz)**. Untuk yang subjek2c(Merah-9Hz Biru-14Hz) belum saya lanjutkan lagi.

>Saya mendapatkan pencarahan: sudah ada petunjuk ciri yang tepat dan cara klasifikasinya, namun semoga cara mengolah data saya sudah tepat.

Kelanjutan dari ratio RMS untuk mencari dominan frekuensi yang terjadi sebagaimana mestinya (Merah dominan pada 11 Hz maupun kelipatannya, begitu juga Biru 13 Hz). Untuk mencari mana BandPass filter yang tepat untuk hal tersebut, maka saya lakukan skoring yang dapat menjangkau seluruh potongan data dari seluruh subjek.

###Langkah-langkah:

1. Load Data RAW
2. Pre-processing dasar : Notch 50 Hz dan Band Pass 1-50 Hz
3. Band Pass Filter dengan jangkauan yang berbeda pada data yang sama:
_Merah : 11 22 33 Hz_
_Biru : 13 26 39 Hz_

* 11 Hz = 10.5 - 11.5 Hz
* 22 Hz = 21.5 - 22.5 Hz
* 33 Hz = 32.5 - 33.5 Hz
* 13 Hz = 12.5 - 13.5 Hz
* 26 Hz = 25.5 - 26.5 Hz
* 39 Hz = 38.5 - 39.5 Hz

Sehingga menghasilkan variabel sebagai berikut:
M11 : Fokus Warna Merah dengan BP 11 Hz
M11 M22 M33 M13 M26 M39
B11 : Fokus Warna Biru dengan BP 11 Hz
B11 B22 B33 B13 B26 B39

4. Pemotongan data berdurasi 2 detik, untuk setiap potongan fokus sehingga menghasilkan 3x4 cell (3 merupakan perulangan fokus dan 4 merupakan jumlah seluruh kanal). Masing-masing array berisi 1x400 (Potongan data berdurasi 2 detik).
5. Masing-masing array diambil nilai rms, sehingga menghasilkan nilai RMS 3x4.
6. Ratio RMS untuk potongan data yang merupakan fokus Merah dihitung dengan membagi RMS dari BP Merah dengan RMS dari BP Biru, contoh: M11/M13, M11/M26, M11/M39 dst untuk M22 dan M33.
7. Ratio RMS untuk potongan data yang merupakan fokus Biru dihitung dengan membagi RMS dari BP Biru dengan RMS dari BP Merah, contoh: B13/B11, B13/B22, B13/B33 dst untuk B26 dan B39.
8. Ratio RMS nomor 6 akan menghasilkan nilai lebih dari 1 jika frekuensi Merah (11Hz dan kelipatannya) dominan.
9. Ratio RMS nomor 7 akan menghasilkan nilai lebih dari 1 jika frekuensi Biru (13 Hz dan kelipatannya) dominan.
10. Sehingga dapat dilakukan skoring untuk Merah dan Biru pada semua subjek dan dapat diputuskan mana BP yang cocok untuk mengklasifikasikan fokus pada warna Merah atau fokus pada warna Biru.
11. Skoring dilakukan dengan menghitung berapa nilai 1 yang muncul sehingga setiap variabel Skoring dihasilkan 3x4 array (nilai maksimal 12 = 3x4 (1 yang muncul 12 kali)).
12. Skoring dari semua subjek digabungkan lalu dijumlah, sehingga menghasilkan hasil akhir mana Filter yang cocok untuk klasifikasi fokus warna Merah dan Biru.
13. Nilai terbanyak mengindikasikan Filter yang cocok.
> Untuk lebih jelasnya saya jelaskan dalam bentuk pseudocode matlab.

### Langkah dalam Matlab:
1. data = load(subjek); % RAW data dari tiap subjek
2. data = filterNotch(data); % Filter Notch 50 Hz
3. data = filterBP(data, 1, 50); % Filter BP 1-50 Hz
4. data11 = filterBP(data, 10.5, 11.5); % BP untuk 11Hz
5. data22 = filterBP(data, 21.5, 22.5); % BP untuk 22Hz
6. data33 = filterBP(data, 32.5, 33.5); % BP untuk 33Hz
7. data13 = filterBP(data, 12.5, 13.5); % BP untuk 13Hz
8. data26 = filterBP(data, 25.5, 26.5); % BP untuk 26Hz
9. data39 = filterBP(data, 38.5, 39.5); % BP untuk 39Hz
10. [M11,B11,durasi] = potongData(data11, fs, 2); % Memotong data, memisahkan data pada saat fokus Merah(M) dan fokus Biru (B)
11. [M22,B22,durasi] = potongData(data22, fs, 2); % setiap Variabel 3x4 cell, dengan isi cell 1x400 double
12. [M33,B33,durasi] = potongData(data33, fs, 2);
13. [M13,B13,durasi] = potongData(data13, fs, 2);
14. [M26,B26,durasi] = potongData(data26, fs, 2);
15. [M39,B39,durasi] = potongData(data39, fs, 2);
16. dataRMS{1,1} = M11_RMS; % menyimpan ciri RMS yang merupakan hasil dari rms(M) dan rms(B)
17. dataRMS{1,2} = M22_RMS; % Setiap variabel 3x4 double, 1x400 double = 1 double RMS
18. dataRMS{1,3} = M33_RMS;
19. dataRMS{1,4} = M13_RMS;
20. dataRMS{1,5} = M26_RMS;
21. dataRMS{1,6} = M39_RMS;
22. dataRMS{2,1} = B13_RMS;
23. dataRMS{2,2} = B26_RMS;
24. dataRMS{2,3} = B39_RMS;
25. dataRMS{2,4} = B11_RMS;
26. dataRMS{2,5} = B22_RMS;
27. dataRMS{2,6} = B33_RMS;
28. Untuk mencari Ratio RMS dengan cara membagikan setiap nilai RMS yang ada pada dataRMS : 
```
% -- Ratio RMS : returns Score of Ratio
function [scoreM, scoreB] = RatioRMS(dataRMS)
scoreM = [];
scoreB = [];
    for i = 1:3
        for j = 4:6
            % Merah
            rM = dataRMS{1,i} ./ dataRMS{1,j};
            % Biru
            rB = dataRMS{2,i} ./ dataRMS{2,j};

            scoreM = [scoreM sum(sum(rM>1))];
            scoreB = [scoreB sum(sum(rB>1))];
            clear rM rB;
        end
    end

end
```
29. Sehingga dihasilkan scoreM yaitu keseluruhan skoring pada fokus warna Merah untuk semua subjek yang ada. Begitu juga dengan scoreB.
30. scoreM perolehan skor tertinggi ada pada ratio dari M11/M39 dengan skor 995 dari 1032 (96.4%).
31. scoreB perolehan skor tertinggi ada pada ratio dari B13/B33 dengan skor 900 dari 1032 (87.2%).


### Kesimpulan

* Berdasarkan skor yang diperoleh dapat diketahui BP mana yang cocok untuk klasifikasi tiap fokus Warna.
* Klasifikasi warna Merah diperoleh dari pembagian RMS dari data setelah dilakukan filter 11 Hz (10.5 - 11.5 Hz) dengan data setelah dilakukan filter 39 Hz (38.5 - 39.5 Hz). Jika hasil pembagian atau rasio lebih dari 1 maka masuk ke dalam kelas Merah.
* Klasifikasi warna Biru diperoleh dari pembagian RMS dari data setelah dilakukan filter 13 Hz (12.5 - 13.5 Hz) dengan data setelah dilakukan filter 33 Hz (32.5 - 33.5 Hz). Jika hasil pembagian atau rasio lebih dari 1 maka masuk ke dalam kelas Biru.
* Dengan demikian secara keseluruhan prosesnya: Data → Filter Notch 50 Hz → Filter BandPass(BP) 1-50 Hz → Filter BP 11Hz, 13Hz, 33Hz dan 39 Hz secara bersamaan → RMS dari setiap BP(11, 13, 33, 39) → Jika RMS11/RMS39 > 1 maka masuk ke dalam kelas merah, Jika RMS13/33 > 1 maka masuk ke dalam kelas biru.

Terima kasih.