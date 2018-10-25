noiseScalingFactor = 0.05; % scale noise externally
q = 1;
countNeural = 0;
for j = 1:20
    for p = 1:1000
        NoisyTestSet;
        if timesteps < 1000
            countNeural = countNeural + 1;
            totalTimeError(countNeural) = timesteps;
            
        end
        if timesteps == 0
                break;
            end
    end
    failureRateError(j) = (1000-countNeural)/1000;
    meansError(j) = mean(totalTimeError);
    stdError(j) = std(totalTimeError);
     totalTimeError = 0;
    disp(j);
    countNeural = 0;
    noiseScalingFactor = noiseScalingFactor + 0.05;
end
 save('errorTestData.mat','meansError','stdError','failureRateError');