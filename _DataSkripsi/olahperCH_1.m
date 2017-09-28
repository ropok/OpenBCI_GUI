clc;
clear;

%Variables
% N = Neutral : White
% L = Left 	  : Red
% R = Right	  : Blue
fs = 200;	% sesuai ganglion pakai 200Hz
t = [0:399]/fs;
% ambil data dan buang N pertama (pemanasan)

%% R11
% load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\R11.txt');
% data_raw = R11;

%% R12
load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\R12.txt');
data_raw = R12;

% step 2. Notch 50Hz
[b,a] = butter(2,[49 51]/(fs/2), 'stop');
% bandpass Filter
[d,c] = butter(2,[0.5 50]/(fs/2), 'bandpass');
for i=1:4
	data_raw(:,i)=filter(b,a,data_raw(:,i));
	data_raw(:,i)=filter(d,c,data_raw(:,i));
end


for i=1:4
    %% R11
% 	N{i} = [{data_raw(1616:2222,i)};{data_raw(3238:4053,i)};{data_raw(5065:5673,i)};...
%         {data_raw(6691:7492,i)};{data_raw(8504:9106,i)}];
% 	L{i} = [{data_raw(607:1615,i)};{data_raw(4054:5064,i)};{data_raw(7493:8503,i)}];
% 	R{i} = [{data_raw(2223:3237,i)};{data_raw(5674:6690,i)};{data_raw(9107:10123,i)}];

    %% R12
    N{i} = [{data_raw(1616:2224,i)};{data_raw(3242:4045,i)};{data_raw(5059:5665,i)};...
        {data_raw(6679:7482,i)};{data_raw(8498:9102,i)}];
    L{i} = [{data_raw(607:1621,i)};{data_raw(4046:5058,i)};{data_raw(7483:8497,i)}];
    R{i} = [{data_raw(2225:3241,i)};{data_raw(5666:6678,i)};{data_raw(9103:10113,i)}];

end
% % cek panjang waktu (3 sekon)
% durasiWaktu = 3;
% data_netral = [8 16 24 32 40];
% data_left = [3 4 5 19 20 21 35 36 37];
% data_right = [11 12 13 27 28 29 43 44 45];

% for i=1:length(data_netral)
%     for j=1:4
%         n{i,j} = N{
%     end
    
% end


for i=1:4
	n{1,i} = N{1,i}{1,1}(1:400,1);
    n{2,i} = N{1,i}{1,1}(201:600,1);
    n{3,i} = N{1,i}{2,1}(1:400,1);
    n{4,i} = N{1,i}{2,1}(201:600,1);
    n{5,i} = N{1,i}{2,1}(401:800,1);
    n{6,i} = N{1,i}{3,1}(1:400,1);
    n{7,i} = N{1,i}{3,1}(201:600,1);
    n{8,i} = N{1,i}{4,1}(1:400,1);
    n{9,i} = N{1,i}{4,1}(201:600,1);
    n{10,i} = N{1,i}{4,1}(401:800,1);
    n{11,i} = N{1,i}{5,1}(1:400,1);
    n{12,i} = N{1,i}{5,1}(201:600,1);

    l{1,i} = L{1,i}{1,1}(1:400,1);
    l{2,i} = L{1,i}{1,1}(201:600,1);
    l{3,i} = L{1,i}{1,1}(401:800,1);
    l{4,i} = L{1,i}{1,1}(601:1000,1);
    l{5,i} = L{1,i}{2,1}(1:400,1);
    l{6,i} = L{1,i}{2,1}(201:600,1);
    l{7,i} = L{1,i}{2,1}(401:800,1);
    l{8,i} = L{1,i}{2,1}(601:1000,1);
    l{9,i} = L{1,i}{3,1}(1:400,1);
    l{10,i} = L{1,i}{3,1}(201:600,1);
    l{11,i} = L{1,i}{3,1}(401:800,1);
    l{12,i} = L{1,i}{3,1}(601:1000,1);

    r{1,i} = R{1,i}{1,1}(1:400,1);
    r{2,i} = R{1,i}{1,1}(201:600,1);
    r{3,i} = R{1,i}{1,1}(401:800,1);
    r{4,i} = R{1,i}{1,1}(601:1000,1);
    r{5,i} = R{1,i}{2,1}(1:400,1);
    r{6,i} = R{1,i}{2,1}(201:600,1);
    r{7,i} = R{1,i}{2,1}(401:800,1);
    r{8,i} = R{1,i}{2,1}(601:1000,1);
    r{9,i} = R{1,i}{3,1}(1:400,1);
    r{10,i} = R{1,i}{3,1}(201:600,1);
    r{11,i} = R{1,i}{3,1}(401:800,1);
    r{12,i} = R{1,i}{3,1}(601:1000,1);
end

% %% Plot Grafik per CH
% for i=1:4
% 	n_cat{i} = cat(2,n{:,i});
% 	n_mean{i} = mean(n_cat{i},2);
    
%     l_cat{i} = cat(2,l{:,i});
%     l_mean{i} = mean(l_cat{i},2);
    
%     r_cat{i} = cat(2,r{:,i});
%     r_mean{i} = mean(r_cat{i},2);
% end
% lw = 1.5;
% 	figure(1);
%     title('CH1');
% 	hold on
% 	plot(t,n_mean{1},'y','linewidth',lw);
% 	plot(t,l_mean{1},'r','linewidth',lw);
% 	plot(t,r_mean{1},'b','linewidth',lw);
% % 	plot(n_mean{4},'color',[0.227, 0.760, 0.917],'linewidth',lw);
%     legend('Putih/netral','Merah/left','Biru/right');
% 	hold off
% %     saveas(gcf,'FP-R11','png');
% %     set (gcf, 'paperpositionmode', 'manual','paperposition',[0 0 30 20])
%     set(gcf,'PaperUnits','inches','PaperPosition',[0 0 13.66 7.20])
%     print('_CH1','-dpng','-r300')

    
% 	figure(2);
%     title('CH 2');
% 	hold on
% 	plot(t,n_mean{2},'y','linewidth',lw);
% 	plot(t,l_mean{2},'r','linewidth',lw);
% 	plot(t,r_mean{2},'b','linewidth',lw);
% % 	plot(n_mean{4},'color',[0.227, 0.760, 0.917],'linewidth',lw);
%     legend('Putih/netral','Merah/left','Biru/right');
% 	hold off
% %     saveas(gcf,'FP-R11','png');
% %     set (gcf, 'paperpositionmode', 'manual','paperposition',[0 0 30 20])
%     set(gcf,'PaperUnits','inches','PaperPosition',[0 0 13.66 7.20])
%     print('_CH2','-dpng','-r300')
    
    
% 	figure(3);
%     title('CH3');
% 	hold on
% 	plot(t,n_mean{3},'y','linewidth',lw);
% 	plot(t,l_mean{3},'r','linewidth',lw);
% 	plot(t,r_mean{3},'b','linewidth',lw);
% % 	plot(n_mean{4},'color',[0.227, 0.760, 0.917],'linewidth',lw);
%     legend('Putih/netral','Merah/left','Biru/right');
% 	hold off
% %     saveas(gcf,'FP-R11','png');
% %     set (gcf, 'paperpositionmode', 'manual','paperposition',[0 0 30 20])
%     set(gcf,'PaperUnits','inches','PaperPosition',[0 0 13.66 7.20])
%     print('_CH3','-dpng','-r300')
    
    
% 	figure(4);
%     title('CH4');
% 	hold on
% 	plot(t,n_mean{4},'y','linewidth',lw);
% 	plot(t,l_mean{4},'r','linewidth',lw);
% 	plot(t,r_mean{4},'b','linewidth',lw);
% % 	plot(n_mean{4},'color',[0.227, 0.760, 0.917],'linewidth',lw);
%     legend('Putih/netral','Merah/left','Biru/right');
% 	hold off
% %     saveas(gcf,'FP-R11','png');
% %     set (gcf, 'paperpositionmode', 'manual','paperposition',[0 0 30 20])
%     set(gcf,'PaperUnits','inches','PaperPosition',[0 0 13.66 7.20])
%     print('_CH4','-dpng','-r300')

   % if sc1(i) == 1
   %      sc_ch == 'Fp1';
   %  elseif sc1(i) == 2
   %      sc_ch == 'Fp2';
   %  elseif sc1(i) == 3
   %      sc_ch == 'C3';
   %  elseif sc1(i) == 4;
   %      sc_ch = 'C4';
   % end
%% Scatter
for i=1:4
    for j=1:12
        n_mean(j,i) = mean(n{j,i});
        l_mean(j,i) = mean(l{j,i}); 
        r_mean(j,i) = mean(r{j,i});
    end
end

sc1 = [1 1 1 2 2 3];
sc2 = [2 3 4 3 4 4];
sc_ch1 = {'Fp1' 'Fp1' 'Fp1' 'Fp2' 'Fp2' 'C3'};
sc_ch2 = {'Fp2' 'C3' 'C4' 'C3' 'C4' 'C4'};

for i=1:6
    figure(i);
    hold on
   scatter(n_mean(:,sc1(i)),n_mean(:,sc2(i)),'xk'); % Netral - Putih
   scatter(l_mean(:,sc1(i)),l_mean(:,sc2(i)),'or'); % Left - Red
   scatter(r_mean(:,sc1(i)),r_mean(:,sc2(i)),'*b'); % Right - Blue
    hold off
   xlabel(sprintf('Channel %d : %s', sc1(i), sc_ch1{i}));
   ylabel(sprintf('Channel %d : %s', sc2(i), sc_ch2{i}));
   legend('Putih-Netral', 'Merah-Left', 'Biru-Right', 'Location', 'northeastoutside')
   judulFile = 'R12 : CH%d vs CH%d (Mean)';
   title(sprintf('R12 : CH%d vs CH%d (Mean)', sc1(i), sc2(i)));
%     set(gcf,'PaperUnits','inches','PaperPosition',[0 0 13.66 7.20])
%     print(sprintf(judulFile, sc1(i), sc2(i)),'-dpng','-r300'); 
%     print(sprintf('R12 : CH%d vs CH%d (Mean)', sc1(i), sc2(i)),'-r300'); 
end