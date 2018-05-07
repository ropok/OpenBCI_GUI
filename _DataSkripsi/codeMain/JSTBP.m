


net = newff(data,tg,10,{'tansig','purelin'},'trainlm');
% net.performFcn = 'mse';
% net.trainParam.showWindow = 0;
net.trainParam.epochs = 5000;
net.trainParam.goal = 1e-09;
% net.trainParam.mu = 0.001;
net.trainParam.lr = 0.1;
% net.trainParam.mc = 0.1;
net.trainParam.max_fail = 1000;
net.trainParam.min_grad = 1000;
net = train (net,data,tg);