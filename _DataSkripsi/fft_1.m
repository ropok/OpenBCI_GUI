clc;
clear;

%Variables
fs = 200;	% sesuai ganglion pakai 200Hz
% N = Neutral : White
% L = Left 	  : Red
% R = Right	  : Blue

% step 1. Ambil data .txt (Raw Data)
load('D:\Jaler\_Data Skripsi\J25.txt');
data_raw = J25;

% step 2. Notch 50Hz
[b,a] = butter(2,[49 51]/(fs/2), 'stop');

for i=1:4
	data_raw(:,i)=filter(b,a,data_raw(:,i));
	% data_raw=filter(b,a,data_raw);
end

% step 3. Pembagian sesuai warna berisi channel 1-4
N_1 = [data_raw(1:134,1);data_raw(626:1222,1);data_raw(1964:2032,1);data_raw(2853:2884,1);...
    data_raw(3257:3296,1);data_raw(3608:3632,1);data_raw(4059:4072,1);data_raw(4322:4354,1)];
N_2 = [data_raw(1:134,2);data_raw(626:1222,2);data_raw(1964:2032,2);data_raw(2853:2884,2);...
    data_raw(3257:3296,2);data_raw(3608:3632,2);data_raw(4059:4072,2);data_raw(4322:4354,2)];
N_3 = [data_raw(1:134,3);data_raw(626:1222,3);data_raw(1964:2032,3);data_raw(2853:2884,3);...
    data_raw(3257:3296,3);data_raw(3608:3632,3);data_raw(4059:4072,3);data_raw(4322:4354,3)];
N_4 = [data_raw(1:134,4);data_raw(626:1222,4);data_raw(1964:2032,4);data_raw(2853:2884,4);...
    data_raw(3257:3296,4);data_raw(3608:3632,4);data_raw(4059:4072,4);data_raw(4322:4354,4)];

L_1 = [data_raw(135:625,1);data_raw(2033:2852,1);data_raw(3633:4058,1)];
L_2 = [data_raw(135:625,2);data_raw(2033:2852,2);data_raw(3633:4058,2)];
L_3 = [data_raw(135:625,3);data_raw(2033:2852,3);data_raw(3633:4058,3)];
L_4 = [data_raw(135:625,4);data_raw(2033:2852,4);data_raw(3633:4058,4)];

R_1 = [data_raw(1223:1963,1);data_raw(2885:3256,1);data_raw(3297:3607,1);data_raw(4073:4321,1)];
R_2 = [data_raw(1223:1963,2);data_raw(2885:3256,2);data_raw(3297:3607,2);data_raw(4073:4321,2)];
R_3 = [data_raw(1223:1963,3);data_raw(2885:3256,3);data_raw(3297:3607,3);data_raw(4073:4321,3)];
R_4 = [data_raw(1223:1963,4);data_raw(2885:3256,4);data_raw(3297:3607,4);data_raw(4073:4321,4)];

% Membuat Array dari Pembagian sinyal
% data_notched = [N_1, N_2, N_3, N_4; L_1, L_2, L_3, L_4; R_1, R_2, R_3, R_4];
% data_notched = dataset(N_1, N_2, N_3, N_4, L_1, L_2, L_3, L_4, R_1, R_2, R_3, R_4);
data_notch_N = dataset(N_1, N_2, N_3, N_4);
data_notch_L = dataset(L_1, L_2, L_3, L_4);
data_notch_R = dataset(R_1, R_2, R_3, R_4);

% Check pembagian grafik Warna:Channel dengan plot (notch)
% for j=1:3
% 	figure(j);
% 	if (j == 1)
% 		for k=1:4
% 			subplot(4,1,k); plot(data_notch_N(:,k)); title(strcat('Neutral Channel ', num2str(k)));
% 		end
% 	end
% 	if (j == 2)
% 		for k=1:4
% 			subplot(4,1,k); plot(data_notch_L(:,k)); title(strcat('Left Channel ', num2str(k)));
% 		end
% 	end
% 	if (j == 3)
% 		for k=1:4
% 			subplot(4,1,k); plot(data_notch_R(:,k)); title(strcat('Right Channel ', num2str(k)));
% 		end
% 	end
% end

% step 4. proses FFT
for j=1:3
	figure(j);
	if (j == 1)
		for i=1:4
			datatemp = data_notch_N(:,i);
			% Ak = abs(fft(data_notch_N(:,i))/length(data_notch_N(:,i)));
			% k = 0:1:length(data_notch_N(:,i))-1;
			% f = k*fs/length(data_notch_N(:,i));

			Ak = abs(fft(datatemp))/length(datatemp);
			k = 0:1:length(datatemp)-1;
			f = k*fs/length(datatemp);
			subplot(4,1,i); plot(f,Ak); title(strcat('Neutral Channel ', num2str(i)));
		end
	end
	% if (j == 2)
	% 	for k=1:4
	% 		subplot(4,1,k); plot(data_notch_L(:,k)); title(strcat('Left Channel ', num2str(k)));
	% 	end
	% end
	% if (j == 3)
	% 	for k=1:4
	% 		subplot(4,1,k); plot(data_notch_R(:,k)); title(strcat('Right Channel ', num2str(k)));
	% 	end
	% end
end

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

