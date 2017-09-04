%%%%%%%%%%%%%%%%%%%%%%%%&&&&&&&&%&&&&&
%              Bismillah             &
%           Penelitian EMG           &
%       by : Muhammad Fajri Azka     &
%         ELINS - UGM - 2013         &
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Source Code For Data EMG Analisys
% Using FFT 
% Checking Frequency from Data Active 

% Date Modified : 22-03-2017

clc;
clear;

%% Load data

load J15.txt;
x=J15;         % ambil data
% x=x(:,2:5);    % pemotongan data
fs=200;         % frekuensi sampling
 
%save('namafile.mat','variabel');

%% Koef filter 1-124Hz, Notch 50Hz

%[b,a]=butter(2,[60 99]/(fs/2));       % filter butterworth orde 2
[bn,an]=butter(2,[49 51]/(fs/2),'stop');   % Notch DC bias OpenBCI 50Hz

%% Filtering & notch

for i=1:4
    %x(i,:)=filter(b,a,x(i,:));      % Filtering data
    x(i,:)=filter(bn,an,x(i,:));    % Notch DC bias OpenBCI 50Hz
end


%% pembagian data dalam cell untuk setiap 10 detik per channel

for j=1:4
     figure(j);
    for i=1:4
        n = (((30*fs)+1)+((i-1)*fs*10)); % detik 40 - mulai gerakan
        
        if i==1
            data{j,1} = x(j,n+fs*1:(n+fs*3-1)); % ganti waktunya aktif disini
        elseif i==2
            data{j,2} = x(j,n+fs*1:(n+fs*3-1)); % ganti waktunya aktif disini
        elseif i==3
            data{j,3} = x(j,n+fs*1:(n+fs*3-1)); % ganti waktunya aktif disini
        else
            data{j,4} = x(j,n+fs*1:(n+fs*3-1)); % ganti waktunya aktif disini
        end
                
        % Penyimpanan data sementara
        datatemp = data{j,i};
        
        % proses FFT
        Ak = abs(fft(datatemp))/length(datatemp);
        k = 0:1:length(datatemp)-1;
        f = k*250/length(datatemp);
             
        % Penyimpanan data FFT
        Dfft{j,i}=Ak;
        
        % Plotting FFT
        subplot(4,1,i);plot(f,Dfft{j,i});
        if i==1
            title(sprintf('Data FFT CH-%d Gerakan-%d',j,i));axis([2 100 0 20]);
        elseif i==2
            title(sprintf('Data FFT CH-%d Gerakan-%d',j,i));axis([2 100 0 20]);
        elseif i==3
            title(sprintf('Data FFT CH-%d Gerakan-%d',j,i));axis([2 100 0 20]);
        else
            title(sprintf('Data FFT CH-%d Gerakan-%d',j,i));axis([2 100 0 20]);
        end
    end
    i=1;
end


% for j=1:4
%     figure(j)  
%     for i=1:4
%         subplot(4,1,i), plot(f,Dfft{i,j+1})
%         if i==1
%             title(sprintf('CH-%d',i));axis([0 124 0 20]);
%         elseif i==2
%             title(sprintf('CH-%d',i));axis([0 124 0 20]);
%         elseif i==3
%             title(sprintf('CH-%d',i));axis([0 124 0 20]);
%         else
%             title(sprintf('CH-%d',i));axis([0 124 0 20]);
%         end
%     end 
% end
