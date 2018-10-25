j=1;
height = 160;
width = 160;
countNeural = 0;
for i = 1:5000
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
    end
end
failureRate(j) = (5000-countNeural)/5000;
disp(j);
j=j+1;
height = height + 10;
width = width + 10;
countNeural = 0;
for i = 1:5000
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
    end
end
failureRate(j) = (5000-countNeural)/5000;
disp(j);
j=j+1;
height = height + 10;
width = width + 10;
countNeural = 0;
for i = 1:5000
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
    end
end
failureRate(j) = (5000-countNeural)/5000;
disp(j);
j=j+1;
height = height + 10;
width = width + 10;
countNeural = 0;
for i = 1:5000
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
    end
end
failureRate(j) = (5000-countNeural)/5000;
disp(j);
j=j+1;
height = height + 10;
width = width + 10;
countNeural = 0;
for i = 1:5000
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
    end
end
failureRate(j) = (5000-countNeural)/5000;
disp(j);
j=j+1;
height = height + 10;
width = width + 10;
countNeural = 0;
for i = 1:5000
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
    end
end
failureRate(j) = (5000-countNeural)/5000;
disp(j);
j=j+1;
height = height + 10;
width = width + 10;
countNeural = 0;
for i = 1:5000
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
    end
end
failureRate(j) = (5000-countNeural)/5000;
disp(j);
j=j+1;
height = height + 10;
width = width + 10;
countNeural = 0;
for i = 1:5000
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
    end
end
failureRate(j) = (5000-countNeural)/5000;
disp(j);
j=j+1;
height = height + 10;
width = width + 10;
countNeural = 0;
for i = 1:5000
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
    end
end
failureRate(j) = (5000-countNeural)/5000;
disp(j);
j=j+1;
height = height + 10;
width = width + 10;
countNeural = 0;
for i = 1:5000
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
    end
end
failureRate(j) = (5000-countNeural)/5000;
disp(j);
j=j+1;
height = height + 10;
width = width + 10;
countNeural = 0;
for i = 1:5000
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
    end
end
failureRate(j) = (5000-countNeural)/5000;
disp(j);
j=j+1;
height = height + 10;
width = width + 10;
countNeural = 0;
for i = 1:5000
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
    end
end
failureRate(j) = (5000-countNeural)/5000;
disp(j);
j=j+1;
height = height + 10;
width = width + 10;
countNeural = 0;
for i = 1:5000
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
    end
end
failureRate(j) = (5000-countNeural)/5000;
disp(j);
j=j+1;
height = height + 10;
width = width + 10;
countNeural = 0;
for i = 1:5000
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
    end
end
failureRate(j) = (5000-countNeural)/5000;
disp(j);
j=j+1;
height = height + 10;
width = width + 10;
countOriginal = 0;
countNeural = 0;
for i = 1:5000
    fullSimNoPlottingNeural;
    if timesteps < 1000
        countNeural = countNeural + 1;
    end
end
failureRate(j) = (5000-countNeural)/5000;
disp(j);
values = [160 170 180 190 200 210 220 230 240 250 260 270 280 290 300];
plot(values,(100.*failureRate(1,:)));