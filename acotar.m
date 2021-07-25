function acotada = acotar(audio)
    ymax = max(audio);
    acotada = audio/ymax;
    acotada = acotada';
end