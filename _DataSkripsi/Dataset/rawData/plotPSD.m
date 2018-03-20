
function plotPSD(data,Sdata)
    rataPSD = avgpower(data);
    figure;plot(data.Frequencies,data.Data);
    title({'Power Spectral Density';sprintf('Fokus: %s',Sdata);sprintf('Avgpower : %d Hz', rataPSD)});
    xlabel('Frequency (Hz)'); ylabel('data');
    print(sprintf('PSD_%s',Sdata),'-dpng');
end