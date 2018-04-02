function plotPSD1(PSDdata, fokusWarna, xlim1, xlim2, durasi, BPLabel)
    sizeData = size(PSDdata);

    % -- Cek Fokus Warna Merah atau Biru
    if fokusWarna(1) == 'M'
        detik = [3 19 35];
        else
            detik = [11 27 43];
    end
    % ----------------------------------

    % -- cari maxData dan minData untuk ylim, agar sama tiap plotnya.
    maxData = []; minData = [];
    for i = 1:sizeData(1)
        for j = 1:sizeData(2)
            maxData = max([maxData max(PSDdata(i,j).data)]);
            minData = min([minData min(PSDdata(i,j).data)]);
        end
    end

    figure();
        for i = 1:sizeData(1) % Time Frame
            subplot(3,1,i)
                hold on;
                for j = 1:sizeData(2) % Channel
                    plot(PSDdata(i,j).frequencies, PSDdata(i,j).data);
                end
                hold off;
            if i == 1
                title({sprintf('%s (BP: %d-%d Hz)',fokusWarna, BPLabel); sprintf('%d-%d s', detik(i),detik(i)+durasi)});
                        legend('Fp_1','Fp_2','C_3', 'C_4' , 'Location','northeast' , 'Orientation','horizontal');

                else    
                    title( sprintf('%d-%d s', detik(i),detik(i)+durasi) );
                end
            xlim([xlim1 xlim2]);
            % ylim([minData maxData]);
            xlabel('\fontsize{8}Frequency (Hz)');
            ylabel('\fontsize{8}Data');
        end
end