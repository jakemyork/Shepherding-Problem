for i = 1:10000
    testSet;
    collectiveMatrix(1,i) = abs(norm(GCM - transpose(GCMNeural)));
    collectiveMatrix(2,i) = abs(isClustered - isClusteredNeural);
    collectiveMatrix(3,i) = abs(norm(collectingPos - transpose(collectingPosNeural)));
    collectiveMatrix(4,i) = abs(norm(drivingPos - transpose(drivingPosNeural)));
end
for i = 1:4
    meansOneInstance(i) = mean(collectiveMatrix(i,:));
    stdeviationOneInstance(i) = std(collectiveMatrix(i,:));
end