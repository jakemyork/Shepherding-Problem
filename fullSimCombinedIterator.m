countOriginal = 0;
countNeural = 0;
for i = 1:100000
    fullSimCombined;
    if timesteps < 1000
        countOriginal = countOriginal + 1;
        totalTimeOriginal(countOriginal) = timesteps;
    end
    if timestepsSecond < 1000
        countNeural = countNeural + 1;
        totalTimeNeural(countNeural) = timestepsSecond;
    end
    disp(i);
end
meansOriginal = mean(totalTimeOriginal);
stdeviationOriginal = std(totalTimeOriginal);
meansNeural = mean(totalTimeNeural);
stdeviationNeural = std(totalTimeNeural);