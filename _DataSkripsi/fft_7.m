clc;
clear;

%Variables
% N = Neutral : White
% L = Left 	  : Red
% R = Right	  : Blue
fs = 200;	% sesuai ganglion pakai 200Hz

% step 1. Ambil data .txt (Raw Data)
load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\J25.txt');
data_raw = J25;

% Test = zeros(1,5);
% step 2. Notch 50Hz
[b,a] = butter(2,[49 51]/(fs/2), 'stop');

for i=1:4
	data_raw(:,i)=filter(b,a,data_raw(:,i));
end

% step 3. Pembagian sesuai warna berisi channel 1-4
for i=1:4
	N{i} = [data_raw(626:1222,i);data_raw(1964:2032,i);data_raw(2853:2884,i);...
    data_raw(3257:3296,i);data_raw(3608:3632,i);data_raw(4059:4072,i);data_raw(4322:4354,i)];
	L{i} = [data_raw(135:625,i);data_raw(2033:2852,i);data_raw(3633:4058,i)];
	R{i} = [data_raw(1223:1963,i);data_raw(2885:3256,i);data_raw(3297:3607,i);data_raw(4073:4321,i)];
end

for i=1:3
% 	figure(i)
	if (i == 1)
        figure(i)
        set(gcf, 'name', 'White-Tengah');
		for j=1:4
			datatemp = N{j};
			Ak = abs(fft(datatemp))/length(datatemp);
			k = 0:1:length(datatemp)-1;
			f = k*fs/length(datatemp);
			Ak(1,1) = 0;0o
			subplot(4,1,j); plot(f,Ak);
			title(sprintf('White : CH-%d',j));
		end
	end
	if(i == 2)
        figure(i)
        set(gcf, 'name', 'Red-Kiri');
		for j=1:4
			datatemp = L{j};
			Ak = abs(fft(datatemp))/length(datatemp);
			k = 0:1:length(datatemp)-1;
			f = k*fs/length(datatemp);
			Ak(1,1) = 0;
			subplot(4,1,j); plot(f,Ak);
			title(sprintf('Red : CH-%d',j));
		end
	end	
	if(i == 3)
        figure(i)
        set(gcf, 'name', 'Blue-Kanan');
		for j=1:4
			datatemp = R{j};
			Ak = abs(fft(datatemp))/length(datatemp);
			k = 0:1:length(datatemp)-1;
			f = k*fs/length(datatemp);
			Ak(1,1) = 0;
			subplot(4,1,j); plot(f,Ak);
			title(sprintf('Blue : CH-%d',j));
		end
	end	
end

% datatemp = R_3;

% Ak = abs(fft(datatemp))/length(datatemp);
% k = 0:1:length(datatemp)-1;
% f = k*fs/length(datatemp);
% Ak(1,1) = 0;
% % if Ak(1,1) >= 4000
% %     Ak(1,1) = 0;
% % end


% figure(1)
% plot(f,Ak);

% step 4. proses FFT
% for j=1:3
% 	figure(j);
% 	if (j == 1)
% 		for i=1:4
% 			datatemp = data_notch_N(:,i);
% 			% Ak = abs(fft(data_notch_N(:,i))/length(data_notch_N(:,i)));
% 			% k = 0:1:length(data_notch_N(:,i))-1;
% 			% f = k*fs/length(data_notch_N(:,i));
% 
% 			Ak = abs(fft(datatemp))/length(datatemp);
% 			k = 0:1:length(datatemp)-1;
% 			f = k*fs/length(datatemp);
% 			subplot(4,1,i); plot(f,Ak); title(strcat('Neutral Channel ', num2str(i)));
% 		end
% 	end
% 	% if (j == 2)
% 	% 	for k=1:4
% 	% 		subplot(4,1,k); plot(data_notch_L(:,k)); title(strcat('Left Channel ', num2str(k)));
% 	% 	end
% 	% end
% 	% if (j == 3)
% 	% 	for k=1:4
% 	% 		subplot(4,1,k); plot(data_notch_R(:,k)); title(strcat('Right Channel ', num2str(k)));
% 	% 	end
% 	% end
% end

% Check pembagian grafik Warna:Channel dengan plot
% figure(1);
% subplot(4,1,1); plot(N_1); title('Channel 1');
% subplot(4,1,2); plot(N_2); title('Channel 2');
% subplot(4,1,3); plot(N_3); title('Channel 3');
% subplot(4,1,4); plot(N_4); title('Channel 4');

% figure(2); title('Red : Left')
% subplot(4,1,1); plot(L_1); title('Channel 1');
% subplot(4,1,2); plot(L_2); title('Channel 2');
% subplot(4,1,3); plot(L_3); title('Channel 3');
% subplot(4,1,4); plot(L_4); title('Channel 4');

% figure(3); title('Blue : Right')
% subplot(4,1,1); plot(R_1); title('Channel 1');
% subplot(4,1,2); plot(R_2); title('Channel 2');
% subplot(4,1,3); plot(R_3); title('Channel 3');
% subplot(4,1,4); plot(R_4); title('Channel 4');

