function saveFile(folder)
    close all; 
    % clear; clc;
    files = dir([folder '*.txt']);

    for h=1:length(files)
        ans = load([folder files(h).name]);
        data = ans(:,2:5);
        [token,fileName] = strtok(files(h).name, 's');
        save(fileName,'data','-ascii');
    end
end