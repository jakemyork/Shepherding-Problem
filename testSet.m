% height = 150; % length of arena
% width = 150; % width of arena
x = 1; % easy for row indexing
y = 2;
numSheep = 20; % the number of sheep being simulated
sheepRadius = 2; % this value is how far the sheep need to be from other sheep
clusterRadius = sheepRadius*numSheep^(2/3);
drivingDistance = sheepRadius*sqrt(numSheep);
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
    isClustered = true;
else
    isClustered = false;
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

% reshape to fit the needs of the network inputs
sheepMatrixReshaped = reshape(sheepMatrix, [numSheep*2,1]);
GCMReshaped = reshape(GCM,[2,1]);
backOfFlockReshaped = reshape(backOfFlock,[2,1]);
furthestSheepReshaped = reshape(furthestSheepCoords,[2,1]);

% create collectingNetwork input vector (for test only)
isClusteredInput = [GCMReshaped;furthestSheepReshaped];
collectingInput = [GCMReshaped;furthestSheepReshaped];
drivingInput = [GCMReshaped;backOfFlockReshaped];


[GCMNeural,nil1,nil2] = GCMNetwork(sheepMatrixReshaped,x,y);
[isClusteredNeural,nil1,nil2] = isClusteredNetwork(isClusteredInput,x,y);
% ensure this is a logical
isClusteredNeural = round(isClusteredNeural);
[collectingPosNeural,nil1,nil2] = collectingPosNetwork(collectingInput,x,y);
[drivingPosNeural,nil1,nil2] = drivingPosNetwork(drivingInput,x,y);

% circleSize = 20;
% figure(1);
% clf('reset');
% rectangle('Position',[0 0 width height]);
% set(gcf,'color','w');
% set(gca,'visible','off');
% hold on; h1 = scatter(GCM(x),GCM(y),circleSize,'filled','magenta');
% hold on; h2 = scatter(GCMNeural(x),GCMNeural(y),'d','magenta');
% hold on; scatter(collectingPos(x),collectingPos(y),circleSize,'filled','MarkerFaceColor',[0.2 0.8 0.2]);
% hold on; scatter(collectingPosNeural(x),collectingPosNeural(y),circleSize,'d','MarkerEdgeColor',[0.2 0.8 0.2]);
% hold on; scatter(drivingPos(x),drivingPos(y),circleSize,'filled','red');
% hold on; scatter(drivingPosNeural(x),drivingPosNeural(y),circleSize,'d','red');
% hold on; scatter(sheepMatrix(:,x),sheepMatrix(:,y),circleSize,'filled','MarkerFaceColor',[0.2 0.2 0.9]);
% %uistack(h1,'top');uistack(h2,'top');
% legend('GCM','GCM neural','collecting position','collecting position neural','driving position','driving position neural','sheep positions');
% xlim([-50 50+width]); ylim([-50 100+height]);






