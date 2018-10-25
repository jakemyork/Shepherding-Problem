values = linspace(5,100,20);
numSheep = 5;
countNeural = 0;
for j = 1:20
    for p = 1:1000
        NeuralTestbed;
        if timesteps < 1000
            countNeural = countNeural + 1;
            totalTimeNumbers(countNeural) = timesteps;
        end
    end
    failureRateNumbers(j) = (1000-countNeural)/1000;
    means(j) = mean(totalTimeNumbers);
    stds(j) = std(totalTimeNumbers);
    totalTimeNumbers = 0;
    disp(j);
    countNeural = 0;
    numSheep = numSheep + 5;
end
save('numbersTestData.mat','means','stds','failureRateNumbers');