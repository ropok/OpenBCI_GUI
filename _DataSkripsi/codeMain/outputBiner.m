function output = outputBiner(input)
    [~,sizeInput] = size(input);
    for i = 1:sizeInput
        if(input(1,i)>input(2,i))
            output(1,i) = 1;
            output(2,i) = 0;
        else
            output(1,i) = 0;
            output(2,i) = 1;
        end
    end
    
end