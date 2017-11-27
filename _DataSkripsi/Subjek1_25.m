% J25 = [CH1 CH2 CH3 CH4];
Fs = 200;
load('D:\Jaler\_Data Skripsi\J25.txt');
J25_N = [J25(2:134,1:4);J25(626:1222,1:4);J25(1964:2032,1:4);J25(2853:2884,1:4);...
    J25(3257:3296,1:4);J25(3608:3632,1:4);J25(4059:4072,1:4);J25(4322:4355,1:4)];
J25_L = [J25(135:625,1:4);J25(2033:2852,1:4);J25(3633:4058,1:4)];
J25_R = [J25(1223:1963,1:4);J25(2885:3256,1:4);J25(3297:3607,1:4);J25(4073:4321,1:4)];

% figure(1); 
% subplot(4,1,1); plot(J25); title('J25');
% subplot(4,1,2); plot(J25_N); title('J25_N');
% subplot(4,1,3); plot(J25_L); title('J25_L');
% subplot(4,1,4); plot(J25_R); title('J25_R');

[b,a] = butter(2,[49 51]/(Fs/2),'stop');
f_J25_N = filter(b,a,J25_N);
f_J25_L = filter(b,a,J25_L);
f_J25_R = filter(b,a,J25_R);

figure(1); 
subplot(3,1,1); plot(J25_N); title('J25_N');
subplot(3,1,2); plot(J25_L); title('J25_L');
subplot(3,1,3); plot(J25_R); title('J25_R');

figure(2);
subplot(3,1,1); plot(f_J25_N); title('fJ25_N');
subplot(3,1,2); plot(f_J25_L); title('fJ25_L');
subplot(3,1,3); plot(f_J25_R); title('fJ25_R');


% y = fft(J25_L); % compute DFT
% P2 = abs(y/length(y));     % Magnitude
% P1 = P2(1:length(y)/2+1);
% % P1(2:end-1) = 2*P1(2:end-1);
% f = fs*(0:(length(y)/2))/length(y);
% % f = (0:length(y)-1)*100/length(y);
% figure(3);
% plot(f,P1);

% Ts = 1/Fs;
% y = fft(J25_L);
% t = 0:Ts;
% x = linspace(0,Ts,length(y));
% figure(3);
% plot(x,abs(y));
data_difft = f_J25_L;
Ak = abs(fft(data_difft))/length(data_difft);
k = 0:1:length(data_difft)-1;
f = k*Fs/length(data_difft);
figure(3);
plot(f,Ak);