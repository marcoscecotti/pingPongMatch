function [locs,hp]=find_big_signalAux(audio,amp,dist)
    audio = abs(audio);
    tam = length(audio);
    
    %Evitamos el golpe de sincronizacion
    audioAux = audio(100000:tam); % 100.000 muestras
    [~,locs] = findpeaks(audioAux,'MinPeakDistance',dist,'MinPeakHeight',amp);
    locs = locs + 100000; % Sumamos 100.000 por los que restamos para el de sincronización
    audioAux = audio(1:100000); % De sincronización buscamos el mas alto
    [~,hp] = max(audioAux); % 
end

