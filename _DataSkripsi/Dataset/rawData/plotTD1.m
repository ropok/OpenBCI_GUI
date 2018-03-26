% Plot PSD dengan subplot
function plotTD1(dataVar, data1, data2, durasi, minData, maxData, Warna, detik)
% max1 = []; max2 = [];
fs = 200;
durasiFs = durasi * fs;
detik = [detik detik+durasi];
t = [0:durasiFs-1]/fs;
    figure();
        subplot(2,1,1);
            hold on;
                for i = 1:4
                    plot(t, dataVar{data1,i});
                end
            hold off;
            ylim([minData maxData]);
            title({'\fontsize{10}Time Domain'; ['\fontsize{8}' sprintf('%s : %d-%d s',Warna,detik)]; '\fontsize{8}BP : 10.5-11.5 Hz'});
            % legend('Fp_1','Fp_2','C_3', 'C_4' , 'Location','northeast' , 'Orientation','vertical');

        subplot(2,1,2);
            hold on;
                for i = 1:4
                    plot(t, dataVar{data2,i});
                end
            hold off;
            ylim([minData maxData]);
            title('\fontsize{8}BP : 12.5-13.5 Hz');
            legend('Fp_1','Fp_2','C_3', 'C_4' , 'Location','southoutside' , 'Orientation','horizontal');
end