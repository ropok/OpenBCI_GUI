function loading(String,min,max)
%loading - display Progress in %
%
% Syntax: loading(String, min, max)
%
% Long description : 
% o Put String as the Progress
% o Min as minimum progress
% o Max as maximum progress
% Example :
% loading('Load Data',1,100)
% Output : 
% int progress = (min/max)*100
% Please wait, Load Data Progress . . . . . . . . . . . + progress + %
% Load Data done.
    progress = (min/max)*100;
    textDisplayProgress = sprintf('Please wait, %s in progress . . . . . . . . . . . . %.0f %%',String,progress);
    textDisplayDone = sprintf('%s done.',String);
    if progress == 100
        clc;
        disp(textDisplayProgress);
        disp(textDisplayDone);
        else 
            disp(textDisplayProgress);
    end

end