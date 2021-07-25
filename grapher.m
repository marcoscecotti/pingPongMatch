clear;
% Amplitud de recorte de picos
amp=0.17;
% Distancia de ventaneo de picos
dist=3500;
% Sacan 2 y 2 alternados
saque=1;

%1- Leo los audios:
nombrejugador1 = "Ceco";
nombrejugador2 = "Milton";
audio1=audioread('partida3_jugador1.mp3');
audio2=audioread('partida3_jugador2.mp3');

%2- Completo para que tengan el mismo tamaño
[audio1,audio2]=complete(audio1,audio2);

%3- Acotamos la amplitud para comparar con el mismo valor:
audio1N = acotar(audio1);
audio2N = acotar(audio2);

%4- Determino el pico para la sincronizada
[~,hp1]=find_big_signalAux(audio1N, amp, dist);

%5- Sincronizo:
[audio1,audio2]=synchronize(audio1N,audio2N,hp1);

%6- Determino los picos
[locs1,~]=find_big_signalAux(audio1,amp,dist);
[locs2,~]=find_big_signalAux(audio2,amp,dist);

%7- Armo las regiones para hacer la correlacion
sizeaudio = length(audio1);
delay = windowing(locs1,locs2,sizeaudio,audio1,audio2);

%8- Sacamos los puntajes
n = length(locs1);
puntaje1 = 0;
puntaje2 = 0;
iAux = 1;

for i=1:n
    if i == n
        % Calculo hasta el final
       [p1,p2,saque] = calcular_punto(delay(iAux:i),saque);
       puntaje1 = puntaje1 + p1;
       puntaje2 = puntaje2 + p2;
       break;
    end
    if locs1(i+1) - locs1(i) > 88200 % 88.200 = 2seg
       % Calculo en los intervalos
       [p1,p2,saque] = calcular_punto(delay(iAux:i),saque);
       iAux = i+1;
       puntaje1 = puntaje1 + p1;
       puntaje2 = puntaje2 + p2;
    end
end

if puntaje1>puntaje2
    disp(strcat("Ganador: " , nombrejugador1, " ", int2str(puntaje1), "-", int2str(puntaje2) ));
elseif puntaje1<puntaje2
    disp(strcat("Ganador: " , nombrejugador2, " ", int2str(puntaje2), "-", int2str(puntaje1)));
else
    disp(strcat("Empate ",int2str(puntaje1), "-", int2str(puntaje2) ));
end


