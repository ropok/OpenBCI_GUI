jMax = 4;
iMax = 3;

for i=1:iMax
    figure;
    hold;
    for j=1:jMax
    plot(PSD_M(i,j).frequencies, PSD_M(i,j).data);
    end
    hold;
    xlim([1 30]);
end

for i=1:iMax
    figure;
    hold;
    for j=1:jMax
    plot(PSD_B(i,j).frequencies, PSD_B(i,j).data);
    end
    hold;
    xlim([1 30]);
end


    figure;
    hold;
    for j=1:jMax
    plot(PSD_M(1,j).frequencies, PSD_M(1,j).data, 'r');
    plot(PSD_M(2,j).frequencies, PSD_M(2,j).data, 'g');
    plot(PSD_M(3,j).frequencies, PSD_M(3,j).data, 'b');
    end
    hold;
    xlim([1 30]);

    figure;
    hold;
    for j=1:jMax
    plot(PSD_B(1,j).frequencies, PSD_B(1,j).data, 'r');
    plot(PSD_B(2,j).frequencies, PSD_B(2,j).data, 'g');
    plot(PSD_B(3,j).frequencies, PSD_B(3,j).data, 'b');
    end
    hold;
    xlim([1 30]);



for j = 1:jMax
    figure;
    hold;
    plot(PSD_M(1,j).frequencies, PSD_M(1,j).data, 'r');
    plot(PSD_M(2,j).frequencies, PSD_M(2,j).data, 'g');
    plot(PSD_M(3,j).frequencies, PSD_M(3,j).data, 'b');
    hold;
    xlim([1 30]);
    figure;
    hold;
    plot(PSD_B(1,j).frequencies, PSD_B(1,j).data, 'r');
    plot(PSD_B(2,j).frequencies, PSD_B(2,j).data, 'g');
    plot(PSD_B(3,j).frequencies, PSD_B(3,j).data, 'b');
    hold;
    xlim([1 30]);
end