% -- Looping JST dengan menggunakan table
close all; clc;
for i = 2:8
    data = eval(['data1.subjek' num2str(i)]);
    subjek{i} = JST(data, 20, 50); % JST(inputs, maxHiddenNode, maxAttemps)

    clear data;
end