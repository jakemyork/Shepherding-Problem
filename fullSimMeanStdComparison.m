countOriginal = 0;
countNeural = 0;
for i = 1:1000
%     fullSimNoPlottingOriginal;
%     if timesteps < 1000
%         countOriginal = countOriginal + 1;
%         totalTimeOriginal(countOriginal) = timesteps;
%     end
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
        totalTimeNeural(countNeural) = timesteps;
    end
end
% meansOriginal = mean(totalTimeOriginal);
% stdeviationOriginal = std(totalTimeOriginal);
% meansNeural = mean(totalTimeNeural);
% stdeviationNeural = std(totalTimeNeural);
failureRate(1) = (1000-countNeural)/1000;
disp(1);