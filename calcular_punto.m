function [p1, p2,saque] = calcular_punto(delay,saque)
    % quien gano el punto
    puntaje1 = 0;
    puntaje2 = 0;
    n = length(delay);
    for i=1:2:n
       if (i + 1) <= n
           if delay(i) * delay(i+1) < 0
               if delay(i) < 0
                   % Audio1 siempre tiene delay > 0
                   puntaje1 = puntaje1+1;
               else
                   puntaje2 = puntaje2+1;
               end
           end
       else
           if delay(i) < 0
               puntaje1 = puntaje1+1;
           else
               puntaje2 = puntaje2+1;
           end
       end      
    end
    % Saca jugador 1
    if puntaje1 > puntaje2 && saque <= 2
        p1=0;
        p2=1;
        saque = saque+1;
    elseif puntaje2 > puntaje1 && saque <= 2
        p1=1;
        p2=0;
        saque=saque+1;
        
    % Saca jugador 2
    elseif puntaje1 > puntaje2 && saque>2
        p1=1;
        p2=0;
        saque=saque+1;
        if saque==5
            saque=1;
        end
    elseif puntaje2 > puntaje1 && saque>2
        p1=0;
        p2=1;
        saque=saque+1;
        if saque==5
            saque=1;
        end
    end
end