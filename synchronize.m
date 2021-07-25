function [audio1,audio2] = synchronize(audio1, audio2,hp1)

    % 25.000 tiene de cola el golpe de sincronización
    audio1Aux = audio1(1:hp1+25000); 
    audio2Aux = audio2(1:hp1+25000);

    %[~,~,D] = alignsignals(audio1Aux,audio2Aux);
    [similarity,lag] = xcorr(audio1Aux,audio2Aux);
    [~,I] = max(abs(similarity));
    D=lag(I);
    shift = abs(D);

    completaCeros = zeros(1,shift);
    %CAMBIE > POR <
    if D < 0
        audio1 = [completaCeros audio1];
        audio2 = [audio2 completaCeros];
    else
        audio2 = [completaCeros audio2];
        audio1 = [audio1 completaCeros];
    end


end

