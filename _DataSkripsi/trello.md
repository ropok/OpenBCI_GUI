Selamat siang mas Catur.
Update → **Cross Validation** dengan variasi sebagai berikut.

1. 3 Kelas (Merah Putih Biru) Sesi1
2. 3 Kelas (Merah Putih Biru) Sesi2
3. 2 Kelas (Merah Biru) Sesi1
4. 2 Kelas (Merah Biru) Sesi2

Dengan rincian data sebagai berikut:

* 32 Ciri digunakan : *Beta, Gamma, 11, 22, 33, 13, 26, 39* masing-masing *4 kanal* (8 macam x 4 knal = 32 Ciri)
* Satu kali pemgambilan data (Setiap Sesi) diambil **dua kali perulangan**, dengan setiap perulangan : 3 detik Putih, 5 detik Merah, 3 detik Putih dan 5 detik Biru.

### 3 Kelas

* Setiap perulangan diambil 5 detik Merah, 5 detik Putih(1 detik pertama dibuang) dan 5 detik Biru dengan potongan data 1 detik. Dengan dua kali perulangan jadi data yang ada: 5x2 Merah, 5x2 Putih, 5x2 Biru (30 Jumlah Data).
* Ada 5 kali pengambilan untuk setiap sesinya (5x30 = 150 Jumlah Data). Berlaku untuk Sesi1 dan Sesi2


### 2 Kelas

* Setiap perulangan diambil 5 detik Merah dan 5 detik Biru dengan potongan data 1 detik. Dengan dua kali perulangan jadi data yang ada: 5x2 Merah, 5x2 Biru (20 Jumlah Data).
* Ada 5 kali pengambilan untuk setiap sesinya (5x20 = 100 Jumlah Data). Berlaku untuk Sesi1 dan Sesi2

## k-Fold Cross Validation
Digunakan 5-Fold Cross Validation dengan menggunakan JST, setiap Fold memiliki net JST yang berbeda. Singkatnya proses pelatihan dengan fungsi train() digunakan untuk dataLatih yang menghasilkan network dan sim() digunakan untuk network dan dataUji yang menghasilkan akurasi TPR FDR, diulang-ulang hingga mendapatkan akurasi yang lebih tinggi dari sim() yang sebelumnya.

* Untuk **3 Kelas** → 150 Data = 120 dataLatih dan 30 dataUji.
* Untuk **2 Kelas** → 100 Data = 80 dataLatih dan 30 dataUji

Dengan demikian, dihasilkan tabel Cross Validation sebagai berikut.

[Tabel Cross Validation 24 Hidden Node: 2 Kelas dan 3 Kelas](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/6b6245af8e964f8a1546f8d53e05e9d7/CrossValidation.PNG)


# Kesimpulan

* Hasil Cross Validation 2 Kelas > 3 kelas dalam hal akurasi. Karena SSVEP yang menjadi acuan, dimana 2 kelas (Merah Biru) dirancang dengan frekuensi kedip berbeda. Sedangkan 3 kelas (Merah Putih Biru), Putih tidak dirancang dengan frekuensi kedip yang merupakan acuan SSVEP.
* Dari Cross Validation yang diperoleh kesimpulan yang dapat diambil adalah perancangan BCI dengan SSVEP menggunakan kanal yang berfungsi sebagai *attention*/perhatian (Fp1 Fp2) dan *alerting response*/response-perhatian (C3 C4) dapat dibuat dengan 1s data yang dipakai dan diperoleh akurasi seperti pada [tabel Cross Validation](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/6b6245af8e964f8a1546f8d53e05e9d7/CrossValidation.PNG). Dibandingkan dengan jurnal-jurnal lain mengenai SSVEP tetapi menggunakan kanal yang berfungsi dalam proses visual untuk warna (O : Occipital).