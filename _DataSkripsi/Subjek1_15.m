% J15 = [CH1 CH2 CH3 CH4];
load('J15.txt');
J15_N = [J15(2:605,1:3);J15(1623:2227,1:3);J15(3244:4054,1:3);J15(5070:5678,1:3);J15(6698:7505,1:3);J15(8517:9125,1:3)];
J15_L = [J15(606:1622,1:3);J15(4055:5064,1:3);J15(7506:8516,1:3)];
J15_R = [J15(2228:3248,1:3);J15(5679:6697,1:3);J15(9126:10136,1:3)];

% figure(1); plot(J15);
% figure(2); plot(J15_N);
% figure(3); plot(J15_L);
% figure(4); plot(J15_R);

% figure(1); 
% subplot(4,1,1); plot(J15); title('J15');
% subplot(4,1,2); plot(J15_N); title('J15_N');
% subplot(4,1,3); plot(J15_L); title('J15_L');
% subplot(4,1,4); plot(J15_R); title('J15_R');

[b,a] = butter(2,[0.49 0.51],'stop');
f_J15_N = filter(b,a,J15_N);
f_J15_L = filter(b,a,J15_L);
f_J15_R = filter(b,a,J15_R);

figure(1); 
subplot(3,1,1); plot(J15_N); title('J15_N');
subplot(3,1,2); plot(J15_L); title('J15_L');
subplot(3,1,3); plot(J15_R); title('J15_R');

figure(2);
subplot(3,1,1); plot(f_J15_N); title('fJ15_N');
subplot(3,1,2); plot(f_J15_L); title('fJ15_L');
subplot(3,1,3); plot(f_J15_R); title('fJ15_R');