
function plot2x2(dataVar, Fokus, durasi, folderPrint, subjek)
fs=200;
t = [0:length(dataVar{1,1})-1]/fs;
cekFokus = strcmp(Fokus,'Merah');
if (cekFokus)
    detik = [3 3+durasi; 19 19+durasi; 35 35+durasi];
    label = 'M';
    else
        detik = [11 11+durasi; 27 27+durasi; 43 43+durasi];
        label = 'B';
end
titleSub = {'Fp_1';'Fp_2';'C_3';'C_4'} ;
    for j = 1:3
        figure();  
        for i = 1:4
            maxLim = max(max([dataVar{j,1} dataVar{j,2} dataVar{j,3} dataVar{j,4} dataVar{j+3,1} dataVar{j+3,2} dataVar{j+3,3} dataVar{j+3,4}]));
            minLim = min(min([dataVar{j,1} dataVar{j,2} dataVar{j,3} dataVar{j,4} dataVar{j+3,1} dataVar{j+3,2} dataVar{j+3,3} dataVar{j+3,4}]));
            subplot(2,2,i);
            hold on;
            plot(t, dataVar{j,i});
            plot(t, dataVar{j+3,i});
            hold off;
            xlabel('\fontsize{8}Waktu (s)'); ylabel('\fontsize{8}Nilai');
            ylim([minLim maxLim]);
            title(['\fontsize{9}' sprintf('%s',titleSub{i})]);
        end
        mtit(sprintf('Time Domain: %s (%d-%d s)',Fokus,detik(j,:)));
        legend('BP11Hz','BP13Hz', 'Location','best' , 'Orientation','horizontal');
        print([folderPrint sprintf('TD_%s_%s%d',subjek,label,j)],'-dpng');
    end

end