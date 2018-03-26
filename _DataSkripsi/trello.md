Selamat sore mas @zzzatm , saya sudah membuat program untuk mengolah jadi 2 subplot untuk Time Domain dan PSD dengan plot 4 kanal dalam masing-masing plot.
Ada 6 Plot dengan 12 Subplot yang dihasilkan dari setiap perulangan pada setiap subjek.

###Plot PSD (Power Spectral Density):
_SubPlot pertama merupakan BandPass 10.5-11.5 Hz_
_SubPlot kedua merupakan BandPass 12.5-13.5Hz_
Adapun plot yang saya lampirkan merupakan plot dari **Subjek5** Sesi Pertama Perulangan Pertama**[1]** dan Sesi Kedua Perulangan Pertama**[2]**
Pada title ada nilai max yaitu nilai data tertinggi agar terlihat frekuensi tertinggi yang muncul.

1. M1 : Plot Merah 3-8s [[1]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/2390a8755d45198e6c2689f40cb95bb0/PSD_subjek5a_1_M1.png) [[2]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/c4bd0bd1eb35e9bdf5ed372cf80eaef1/PSD_subjek5a_6_M1.png)
2. M2 : Plot Merah 19-24s [[1]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/2e77e148ea7e6c6bab87eb2fee1be746/PSD_subjek5a_1_M2.png) [[2]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/99414443834491a8195a4733e110c527/PSD_subjek5a_6_M2.png) 
3. M3 : Plot Merah 35-40s [[1]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/547bc7a899ad4efde06e09726fbe2c90/PSD_subjek5a_1_M3.png) [[2]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/f5ac7f22e92b40c8372f0643a9e75815/PSD_subjek5a_6_M3.png)
4. B1 : Plot Biru 11-16s [[1]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/0ce2c11814469398ab4773cdfc1eb136/PSD_subjek5a_1_B1.png) [[2]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/c952f9755cefb365bb5a909ae61f6062/PSD_subjek5a_6_B1.png)
5. B2 : Plot Biru 27-32s [[1]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/4cfb50e1b4492597e26ebe0eb5f4e563/PSD_subjek5a_1_B2.png) [[2]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/43f0660c1a8280a1ff7f2c0236c16789/PSD_subjek5a_6_B2.png)
6. B3 : Plot Biru 43-48s [[1]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/4a2c8dc1e5d25563c68105a2142e8afd/PSD_subjek5a_1_B3.png) [[2]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/ec1a392ccd1541817e74017e4959bd10/PSD_subjek5a_6_B3.png)

###Plot Time Domain:
_Setiap potongan data diambil durasi 2 detik dari awal mulai_
Terdapat **ylim([min max])**, **min** adalah nilai terkecil dari setiap perulangan pada setiap subjek dan **max** adalah nilai terbesar, dimaksudkan agar terlihat lebih jelas untuk membandingkan plot yang satu dengan yang lainnya pada setiap perulangan dan subjek
Adapun plot yang saya lampirkan merupakan plot dari **Subjek5** Sesi Pertama Perulangan Pertama**[1]** dan Sesi Kedua Perulangan Pertama**[2]**

1. M1 : Plot Merah 3-5s [[1]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/905bb65e3b8e4a8700b6e8c5c9252a4b/TD_subjek5a_1_M1.png) [[2]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/73abddde746a045c9cf3f278bf1648e6/TD_subjek5a_6_M1.png) 
2. M2 : Plot Merah 19-21s [[1]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/57d56de800ff145068b20afa9e3d051b/TD_subjek5a_1_M2.png) [[2]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/d70a49bff6bbe554a0aa184bb67a1f5c/TD_subjek5a_6_M2.png) 
3. M3 : Plot Merah 35-37s [[1]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/30c2c753d43b9f2dfbb5b251460a6c11/TD_subjek5a_1_M3.png) [[2]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/56f6f686766ea147019a9ced7049404a/TD_subjek5a_6_M3.png) 
4. B1 : Plot Biru 11-13s [[1]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/d2b41ec77bb8e11190763d2d0a7f191a/TD_subjek5a_1_B1.png) [[2]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/900e31599a6f6cc97975ed1eca84b8c2/TD_subjek5a_6_B1.png) 
5. B2 : Plot Biru 27-29 [[1]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/5ab79a5c1962064a4cd1dc58489c587b/TD_subjek5a_1_B2.png) [[2]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/fa5ed750e52c43f639228f5838116ca1/TD_subjek5a_6_B2.png) 
6. B3 : Plot Biru 43-45s [[1]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/e827f217eddf5842390b26d7551339f4/TD_subjek5a_1_B3.png) [[2]](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/3ae8dd6e53854f7c24ae5bbfb606fd4a/TD_subjek5a_6_B3.png) 


###Pembahasan
Secara keseluruhan memang ada frekuensi yang mendominasi pada kelas Merah untuk BP 10.5-11.5 Hz, begitu juga dengan kelas Biru untuk BP 12.5-13.5 Hz.
Namun pada perulangan maupun subjek lain ada juga frekuensi dimana kelas Merah dominan pada BP 12.5-13.5 Hz begitu juga sebaliknya dengan frekuensi pada kelas Biru.
> Agar lebih jelasnya lagi, selanjutnya dilakukan scattering untuk RMS sehingga dapat lebih jelas mana kanal yang relevan pada pemisahan kelas merah dan kelas biru.

