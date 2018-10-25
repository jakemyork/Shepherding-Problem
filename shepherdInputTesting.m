% testing sheep numbers inputs starting at 1 and ending at 40
numSheep = 5;
for p = 1:40000
    NeuralTestbed;
    totalTimeNumbers(p) = timesteps;
    disp(p)
    % increment the number of sheep
    if i == 1000*numSheep
        numSheep = numSheep + 5;
    end
end
for j = 1:(p/1000)
    recordedMeansNumbersSet(j) = mean(totalTimeNumbers((1+1000*(j-1)):(1000+1000*(j-1))));
    recordedStdNumbersSet(j) = std(totalTimeNumbers((1+1000*(j-1)):(1000+1000*(j-1))));
end
save('numbersTestData.mat','totalTimeNumbers','recordedMeansNumbersSet','recordedStdNumbersSet');