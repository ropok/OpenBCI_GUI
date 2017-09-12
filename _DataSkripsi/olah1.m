clc;
clear;

%Variables
% N = Neutral : White
% L = Left 	  : Red
% R = Right	  : Blue
fs = 200;	% sesuai ganglion pakai 200Hz

% ambil data dan buang N pertama (pemanasan)
load('D:\Jaler\OpenBCI_GUI\_DataSkripsi\R11.txt');
data_raw = R11;
for i=1:4
	N{i} = [{data_raw(1616:2222,i)};{data_raw(3238:4053,i)};{data_raw(5065:5673,i)};...
        {data_raw(6691:7492,i)};{data_raw(8504:9106,i)}];
	L{i} = [{data_raw(607:1615,i)};{data_raw(4054:5064,i)};{data_raw(7493:8503,i)}];
	R{i} = [{data_raw(2223:3237,i)};{data_raw(5674:6690,i)};{data_raw(9107:10534,i)}];
end

% ambil data 2 detik (0-2 detik)
% N{i} : |1616-2222| = 606 (1 detik = 202)
% 		 |3238-4053| = 815 (1 detik = 203)
% 		 |5065-5673| = 608 (1 detik = 202)
% 		 |6691-7492| = 801 (1 detik = 200)
% 		 |8054-9106| = 602 (1 detik = 200)
% N1_1 = N{1,1}{1,1}(1:404,1);
% N1_2 = N{1,1}{1,1}(203:606,1);
% N1_3 = N{1,1}{2,1}(1:406,1);
% N1_4 = N{1,1}{2,1}(204:609,1);
% N1_5 = N{1,1}{2,1}(407:812,1);
% N1_6 = N{1,1}{3,1}(1:402,1);
% N1_7 = N{1,1}{3,1}(202:603,1);
% N1_8 = N{1,1}{4,1}(1:400,1);
% N1_9 = N{1,1}{4,1}(201:600,1);
% N1_10 = N{1,1}{4,1}(401:800,1);
% N1_11 = N{1,1}{5,1}(1:400,1);
% N1_12 = N{1,1}{5,1}(201:600,1);

