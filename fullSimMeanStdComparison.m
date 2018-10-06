countOriginal = 0;
countNeural = 0;
for i = 1:10000
    fullSimNoPlottingOriginal;
    if timesteps < 1000
        countOriginal = countOriginal + 1;
        totalTimeOriginal(countOriginal) = timesteps;
    end
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
        totalTimeNeural(countNeural) = timesteps;
    end
end
meansOriginal = mean(totalTimeOriginal);
stdeviationOriginal = std(totalTimeOriginal);
meansNeural = mean(totalTimeNeural);
stdeviationNeural = std(totalTimeNeural);