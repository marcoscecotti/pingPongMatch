function delay = windowing(locs1,locs2,sizeaudio,audio1,audio2)

size = length(locs1);

% El valor 1000 es por la izquierda del pico que siempre tiene un poco

for i=1:size-1
    if locs1(i) < locs2(i)
        if locs2(i+1)-1000 > sizeaudio
            pos=((locs1(i)-1000):sizeaudio);
            intervalo1=audio1(1, pos);
            intervalo2=audio2(1, pos);
        else
            pos=((locs1(i)-1000):(locs2(i+1)-1000));
            intervalo1=audio1(1,pos);
            intervalo2=audio2(1,pos);
        end
        % Multiplicamos por 1 la parte que nos interesa del intervalo
        % lo demás por 0
        % Idea similar al clipping
        intervalo1=intervalo1.*(pos<(locs1(i+1)-1000));
        intervalo2=intervalo2.*(pos>(locs2(i)-1000));
    else
         if locs1(i+1) > sizeaudio
            pos=((locs2(i)-1000):sizeaudio);
            intervalo1=audio1(1, pos);
            intervalo2=audio2(1, pos);
         else  
            pos=((locs2(i)-1000):(locs1(i+1)-1000));
            intervalo1=audio1(1,pos);
            intervalo2=audio2(1,pos);
         end
        % Multiplicamos por 1 la parte que nos interesa del intervalo
        % lo demás por 0
        % Idea similar al clipping
        intervalo1=intervalo1.*(pos>(locs1(i)-1000));
        intervalo2=intervalo2.*(pos<(locs2(i+1)-1000));
    end
    %[~,~,D] = alignsignals(intervalo1,intervalo2);
    %delay(i)=D;
    [similarity,lag] = xcorr(intervalo1,intervalo2);
    [~,I] = max(abs(similarity));
    D=lag(I);
    delay(i)=D;
end

% Ultima iteración, va hasta el final del audio (no el pico siguiente
% -1000)
if locs1(size) < locs2(size)
    pos = locs1(size)-1000:sizeaudio;
    intervalo1 = audio1(pos);
    intervalo2 = audio2(pos);
    intervalo2 = intervalo2.*(pos>(locs2(size)-1000)); % Recorte
else
    pos = locs2(size)-1000:sizeaudio;
    intervalo1 = audio1(pos);
    intervalo2 = audio2(pos);
    intervalo1 = intervalo1.*(pos>(locs1(size)-1000)); % Recorte
end

% [~,~,D] = alignsignals(intervalo1,intervalo2);
% delay(size)=D;
[similarity,lag] = xcorr(intervalo1,intervalo2);
[~,I] = max(abs(similarity));
D=lag(I);
delay(size)=D;
end
