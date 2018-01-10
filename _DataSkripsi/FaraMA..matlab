span = 0.5;
sMethod = 'moving';

garisMovingAverage = smooth(t, data, span, sMethod);

	plot(tP,dataMean{1,i}.ans,'k' , tMB,dataMean{2,i}.ans,'r' , tMB,dataMean{3,i}.ans,'b' , tP,dataNormMA{1,i},'k-', tMB,dataNormMA{2,i}, 'r-', tMB,dataNormMA{3,i},'b-'); % dengan MA
