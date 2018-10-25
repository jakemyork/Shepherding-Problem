height = 150; % length of arena
width = 150; % width of arena
x = 1; % easy for row indexing
y = 2;
numSheep = 20; % the number of sheep being simulated
sheepRadius = 2; % this value is how far the sheep need to be from other sheep
clusterRadius = sheepRadius*numSheep^(2/3);
drivingDistance = sheepRadius*sqrt(numSheep);
trainingNumber = 20000;

% create training instances
for n = 1:trainingNumber
    % pseudo-random limits on sheep spawn locations
    outerModx = rand(1);
    innerModx = outerModx*rand(1);
    outerMody = rand(1);
    innerMody = outerMody*rand(1);
    % reset all variables for this iteration
    sheepMatrix = zeros(20,2);
    directions = zeros(20,2);
    norms = zeros(1,20);
    GCM = zeros(1,2);
    collectingPos = zeros(1,2);
    temp = zeros(1,2);
    furthestIndex = 0;
    furthestNorm = 0;
    scalingFactorCollect = 0;
    
    % calculate random values for the (x,y) coordinates for each sheep
    for s = 1:numSheep
        sheepMatrix(s,x) = (outerModx*width - innerModx*width)*rand(1)+ innerModx*width;
        sheepMatrix(s,y) = (outerMody*height - innerMody*height)*rand(1)+ innerMody*height;
    end
    % calculate the GCM of the flock
    GCM(x) = mean(sheepMatrix(:,x)); GCM(y) = mean(sheepMatrix(:,y));
    GCMNorm = norm(GCM);
    % calculate the direction vectors from each sheep to the GCM
    for s = 1:numSheep
    directions(s,x) = sheepMatrix(s,x) - GCM(x);
    directions(s,y) = sheepMatrix(s,y) - GCM(y);
    end
    % determine furthest sheep and how far away it is from the GCM
    for s = 1:numSheep
        temp = [directions(s,x) directions(s,y)];
        norms(s) = norm(temp);
        if (norms(s) > furthestNorm)
            furthestNorm = norms(s);
            furthestIndex = s;
        end
    end
    if furthestNorm < clusterRadius
        boolClustered = true;
    else
        boolClustered = false;
    end
    furthestSheepCoords = [sheepMatrix(furthestIndex,1) sheepMatrix(furthestIndex,2)];
    % calculate position of collecting position based on furthestIndex and GCM
    scalingFactorCollect = (furthestNorm + sheepRadius)/furthestNorm;
    collectingPos(x) = (directions(furthestIndex,x)*scalingFactorCollect+GCM(x));
    collectingPos(y) = (directions(furthestIndex,y)*scalingFactorCollect+GCM(y));
    % calculate driving position based on GCM location, back of the flock, and the driving distance
    scalingFactorBackofFlock = (GCMNorm + furthestNorm)/GCMNorm;
    backOfFlock(x) = (GCM(x)*scalingFactorBackofFlock);
    backOfFlock(y) = (GCM(y)*scalingFactorBackofFlock);
    scalingFactorGCM = (GCMNorm + drivingDistance+furthestNorm)/GCMNorm;
    drivingPos(x) = (GCM(x)*scalingFactorGCM);
    drivingPos(y) = (GCM(y)*scalingFactorGCM);

    % reshape to fit the needs of the output
    sheepMatrixReshaped = reshape(sheepMatrix, [numSheep*2,1]);
    GCMReshaped = reshape(GCM,[2,1]);
    backOfFlockReshaped = reshape(backOfFlock,[2,1]);
    furthestSheepReshaped = reshape(furthestSheepCoords,[2,1]);
    collectingPosReshaped = reshape(collectingPos,[2,1]);
    drivingPosReshaped = reshape(drivingPos,[2,1]);

    % create collectingNetwork input vector (for test only)
    collectingInput = [GCMReshaped;furthestSheepReshaped];
    isClusteredInput = collectingInput;
    % create collectingNetwork input vector (for test only)
    drivingInput = [GCMReshaped;backOfFlockReshaped];

    % store this training instance
    for s = 1:numSheep*2
        inputGCM(s,n) = sheepMatrixReshaped(s,1);
    end
    for s = 1:2
        outputGCM(s,n) = GCMReshaped(s,1);
        inputCollectingPos(s,n) = GCMReshaped(s,1);
        inputDrivingPos(s,n) = GCMReshaped(s,1);
        outputCollectingPos(s,n) = collectingPosReshaped(s,1);
        outputDrivingPos(s,n) = drivingPosReshaped(s,1);
    end
    for s = 3:4
        inputCollectingPos(s,n) = furthestSheepReshaped(s-2,1);
        inputDrivingPos(s,n) = backOfFlockReshaped(s-2,1);
    end
    inputClustered = inputCollectingPos;
    outputClustered(n) = boolClustered;
end




