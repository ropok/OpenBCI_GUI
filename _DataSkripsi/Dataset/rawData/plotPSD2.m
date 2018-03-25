% Plot PSD dengan subplot
function plotPSD2(dataVar, data1, data2, maxData, Warna, detik)
max1 = []; max2 = [];
    figure();
        subplot(2,1,1);
            hold on;
                for i = 1:4
                    plot(dataVar{data1,i}.frequencies, dataVar{data1,i}.data);
                    max1 = max([max1 max(dataVar{data1,i}.data)]);
                end
                hline(max1,'k');
            hold off;
            xlim([10 15]); ylim([0 maxData]);
            title({'\fontsize{10}Power Spectral Density'; sprintf('%s : %d-%d s',Warna,detik); '\fontsize{8}BP : 10.5-11.5 Hz'});
            legend('Fp_1','Fp_2','C_3', 'C_4' , 'Location','northeast' , 'Orientation','vertical');

        subplot(2,1,2);
            hold on;
                for i = 1:4
                    plot(dataVar{data2,i}.frequencies, dataVar{data2,i}.data);
                    max2 = max([max2 max(dataVar{data2,i}.data)]);
                end
                hline(max2,'k');
            hold off;
            xlim([10 15]); ylim([0 maxData]);
            title('\fontsize{8}BP : 12.5-13.5 Hz');
            legend('Fp_1','Fp_2','C_3', 'C_4' , 'Location','northeast' , 'Orientation','vertical');

end