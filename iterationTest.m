largestGCMDiff = 0;
largestcpDiff = 0;
largestdpDiff = 0;
height = 160;
width = 160;
q = 1;
for p = 1:15000
    testSet;
    collectiveMatrix(1,p) = abs(norm(GCM - transpose(GCMNeural)));      
    collectiveMatrix(2,p) = round(abs(isClustered - isClusteredNeural));
    collectiveMatrix(3,p) = abs(norm(collectingPos - transpose(collectingPosNeural)));   
    collectiveMatrix(4,p) = abs(norm(drivingPos - transpose(drivingPosNeural)));
    if p == (1000*q)
        height = height + 10;
        width = width + 10;
        q = q + 1;
    end
end
for j = 1:(p/1000)
    meansOneInstance(1,j) = mean(collectiveMatrix(1,((1+1000*(j-1)):(1000+1000*(j-1)))));
    meansOneInstance(2,j) = mean(collectiveMatrix(2,((1+1000*(j-1)):(1000+1000*(j-1)))));
    stdeviationOneInstance(2,j) = std(collectiveMatrix(2,((1+1000*(j-1)):(1000+1000*(j-1)))));
    meansOneInstance(3,j) = mean(collectiveMatrix(3,((1+1000*(j-1)):(1000+1000*(j-1)))));
    meansOneInstance(4,j) = mean(collectiveMatrix(4,((1+1000*(j-1)):(1000+1000*(j-1)))));
end
values = [160 170 180 190 200 210 220 230 240 250 260 270 280 290 300];
plot(values,meansOneInstance(1,:)); hold on;
plot(values,meansOneInstance(2,:)); hold on;
plot(values,meansOneInstance(3,:)); hold on;
plot(values,meansOneInstance(4,:));