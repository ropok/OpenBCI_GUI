Selamat sore Mas Catur, sudah saya ujikan menjadi confusion matrix untuk dari ciri Ratio RMS dimana masing-masing ciri diberi **label kelompok ciri** sebagai berikut.

1. RMS11/RMS13
2. RMS11/RMS26
3. RMS11/RMS39
4. RMS22/RMS13
5. RMS22/RMS26
6. RMS22/RMS39
7. RMS33/RMS13
8. RMS33/RMS26
9. RMS33/RMS39
> Masing-masing kelompok tersebut memiliki jumlah data 4x516 data.

JST yang digunakan memiliki spesifikasi sebagai berikut:

* 10 Hidden Layer (Sebagai patokan default, angka dari documentation matlab)
* Ratio Training 70%
* Ratio Validation 15%
* Ratio Test 15%

Presentase keberhasilan dilihat dari **Confusion Matrix** (CM) yang juga melihat **plot performance** yang dihasilkan, adapun penggunaan kelompok ciri pada JST tersebut sebagai berikut:

1. Kelompok 1 [CM](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/9de40d041987dd87d7c6abf57724c037/CM_1.png) [Perform Plot](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/c175ceae03ebce0a82a43f60440ffa1b/Perform_1.png)
2. Kelompok 2 [CM](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/424a8714432d6faa501c3b294d47b055/CM_2.png) [Perform Plot](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/0652ae612040fe7af341eb36cfac9453/Perform_2.png)
3. Kelompok 3 [CM](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/71cf627b521d1964c9c0b7d9c1bcbfb5/CM_3.png) [Perform Plot](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/f3d43356968ad4b2e271cd9e80b75669/Perform_3.png)
4. Kelompok 4 [CM](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/431495834a2d858678e259cc2c70970a/CM_4.png) [Perform Plot](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/39eeee23a554a946f1d7b58faf024bfe/Perform_4.png)
5. Kelompok 5 [CM](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/6f2a233e7634ca173a8b1103e4e0c217/CM_5.png) [Perform Plot](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/4d1a677533b231be8929bb398bd77d29/Perform_5.png)
6. Kelompok 6 [CM](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/d7ada2b065dcfbd9da90b93489350ff2/CM_6.png) [Perform Plot](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/1b39d7bd2910b9a04053ebb1ca9457f9/Perform_6.png)
7. Kelompok 7 [CM](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/7b0afba6d7df2176ce23ad7d7ee20a00/CM_7.png) [Perform Plot](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/e78bfbab26e92ac377eb5e7c95352fb3/Perform_7.png)
8. Kelompok 8 [CM](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/46849913de1ef2983862dd5a23d5d82c/CM_8.png) [Perform Plot](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/243c16cf1cdfc7cdaf2876a5d368f081/Perform_8.png)
9. Kelompok 9 [CM](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/cbe13a8f1c9dae1a2fff80a2fa248c33/CM_9.png) [Perform Plot](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/095214caae305dffdf0911913c99b701/Perform_9.png)
10. Kelompok 1 2 3 4 5 6 7 8 9  [CM1](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/d131bdea6e10e62c734ca41cfe8e78c5/CM_9x4.jpg) [CM2](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/68ecf708eae329871a824639e63953be/CM_9x4_1.png) [Perform Plot 1](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/6fb4a5e56f4016589573e0102fcc549c/Perform_9x4.png) [Perform Plot 2](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/26c8d0a7ebfed3463111ad7a383bc03e/Perform_9x4_1.png) [nntarintool](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/820d227e4b319d96aa03d60a206d1e68/nntarintool_36ciri.PNG)


###Kesimpulan
Confusion Matrix yang dihasilkan dengan presentasi keberhasilan tertinggi ada pada JST [nomor 10 (9 kelompok ciri)](https://trello-attachments.s3.amazonaws.com/5875a761fec77e8b484f5d1b/5aaf96f8f343ee30e840b4bd/26c8d0a7ebfed3463111ad7a383bc03e/Perform_9x4_1.png) dengan perolehan :

* Training : 81.5%
* Validation : 85.7%
* Test : 81.8%
* Total : 82.2%


#### Source Code JST
```
function JST(inputs, hiddenLayerSize)

    % Generate targets
    [~,N] = size(inputs);
    n = N/2;
    targets(1,1:n) = ones;
        targets(2,n+1:N) = ones;

    % Membuat Pattern Recognition Network
    % hiddenLayerSize = 10;
    net = patternnet(hiddenLayerSize);

    % Set up Division of Data for Training, Validation, Testing
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;

    % Train the Network
    [net,tr] = train(net, inputs, targets);

    % Test the Network
    outputs = net(inputs);
    errors = gsubtract(targets, outputs);
    performance = perform(net, targets, outputs)
    figure, plotperform(tr);
    % save net.mat net
    % figure, plotconfusion(targets, outputs);

    % View the Network
    % view(net);
end
```

>Selanjutnya jika sudah ok untuk JST ini, saya move on ke GUI_OpenBCI.