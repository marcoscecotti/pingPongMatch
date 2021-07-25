function [audio1,audio2]=complete(audio1,audio2)
    tam1=length(audio1);
    tam2=length(audio2);
    
    diferencia=abs(tam1-tam2);
    
    ceros=zeros(1,diferencia);
    
    if tam1<tam2
        audio1=[audio1' ceros];
        audio1=audio1';
    else
        audio2=[audio2' ceros];
        audio2=audio2';
    end
end