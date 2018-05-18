IW = net.IW{1};
LW = net.LW{2};
IB = net.b{1};
LB = net.b{2};

input = normalize_var(input,0,1);
HL = input*IW';

[datum,~] = size(input);
for i = 1 : datum
    HL(i,:) = HL(i,:) + IB';
end
HL = normalize_var(HL,-1,1);

output = HL*LW';
for i = 1:datum
    output(i,:) = output(i,:) + LB';
end

output = output';


% 
% Manually SIM
% 
% [input] -> [HiddenLayer] -> [output]

HL = tansig(input*net.IW{1,1}' + net.b{1}')
output = purelin(HL*net.LW{2,1}' + net.b{2}')

% Test
hiddenlayer = input*net.IW{1,1}' + net.b{1}';
hiddenlayer = 2/(1+exp(-2*hiddenlayer))-1 % tansig
outputlayer = hiddenlayer*net.LW{2,1}' + net.b{2}';
