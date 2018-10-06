noiseScalingFactor = 0.02; % scale noise externally
for p = 1:20000
    NoisyTestSet;
    recordedTimeNoisyTest(p) = timesteps;
    recordedStartingNoise(p) = startingNoise;
    % increment the noise scaling factor
    if p == 50000*noiseScalingFactor
        noiseScalingFactor = noiseScalingFactor + 0.02;
    end
end
for j = 1:(p/1000)
    recordedMeansNoisyTestSet = mean((1+1000*(j-1)):(1000+1000*(j-1)));
    recordedStdNoisyTestSet = std((1+1000*(j-1)):(1000+1000*(j-1)));
end