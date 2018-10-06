%% This section does all calculation of initial conditions of the simulation

height = 150; % height of arena (y-axis)
width = 150; % width of arena (x-axis)
x = 1; % easy for row indexing
y = 2;
numSheep = 20; % the number of sheep being simulated
sheepRadius = 2; % how far the sheep need to be from other sheep to be "comfortable"
shepherdRadius = 65; % this is how close the shepherd can be before influencing the sheep
clusterRadius = sheepRadius*numSheep^(2/3); % determining the radius of clustering of the flock
drivingDistance = sheepRadius*sqrt(numSheep); % distance from GCM to driving position
circleSize = 20; % for plotting circles

% sheep initially spawn randomly in the upper right quadrant of the arena
% so they are bound between 0.5 and 1 in both x and y
outerMod = 1;
innerMod = 0.5;
% the shepherd will spawn in any other quadrant so the spawning arrangement
% is a little different - see code below
shepOuterMod = 0.5;

% initialise variables to blank canvases
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
    sheepMatrix(s,x) = (outerMod*width - innerMod*width)*rand(1)+ innerMod*width;
    sheepMatrix(s,y) = (outerMod*height - innerMod*height)*rand(1)+ innerMod*height;
end
% calculate initial position for the shepherd - here, either the shepherd
% is bound to the left half of the arena or the bottom half of the arena
shepherdRand = rand(1);
if shepherdRand < 0.5
    % in this case, the shepherd is bound to the left half of the arena
    shepherdPos(x) = (shepOuterMod*width)*rand(1);
    shepherdPos(y) = height*rand(1);
else
    % in this case, the shepherd is bound to the lower half of the arena
    shepherdPos(x) = width*rand(1);
    shepherdPos(y) = (shepOuterMod*height)*rand(1);
end
%% This section will calculate all positions and vectors for each time step until the simulation is complete
for timesteps = 1:1000
    % these values must be reset each time
    furthestIndex = 0;
    furthestNorm = 0;
    % calculate the GCM of the flock
    GCM(x) = mean(sheepMatrix(:,x));
    GCM(y) = mean(sheepMatrix(:,y));
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
    furthestSheepCoords = [sheepMatrix(furthestIndex,1) sheepMatrix(furthestIndex,2)];
    % determine if the furthest sheep from the GCM is outside of the
    % clustering radius
    if furthestNorm < clusterRadius
        isClustered = true;
    else
        isClustered = false;
    end
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

    % recalculate new positions of each sheep and the shepherd based on
    % their various radii and vectors related to each other
    
    % for each sheep that we have
    for s = 1:numSheep
        % reset the vector forces to zero for this sheep
        xDiff = 0;
        yDiff = 0;
        xDifft = 0;
        yDifft = 0;
        % see if the shepherd is close enough to influence this sheep
        shepherdInfluence(s,x) = shepherdPos(x) - sheepMatrix(s,x);
        shepherdInfluence(s,y) = shepherdPos(y) - sheepMatrix(s,y);
        shepherdDistance = norm([shepherdInfluence(s,x) shepherdInfluence(s,y)]);
        % if the shepherd is too close then this sheep is repelled by the
        % shepherd and attracted to the flock GCM
        if shepherdDistance < shepherdRadius
            % we add a unit vector in the opposite direction from the
            % shepherd
            xDiff = xDiff - shepherdInfluence(s,x)/shepherdDistance;
            yDiff = yDiff - shepherdInfluence(s,y)/shepherdDistance;
            % we also add a GCM scaled unit vector towards the GCM
            xDiff = xDiff - 1.05*directions(s,x)/norm([directions(s,x) directions(s,y)]);
            yDiff = yDiff - 2*directions(s,y)/norm([directions(s,x) directions(s,y)]);
        end
        for t = 1:numSheep
            % for each sheep that is not this sheep
            if t ~= s
                % we calculate how far away that sheep is
                howFar(x) = sheepMatrix(t,x) - sheepMatrix(s,x);
                howFar(y) = sheepMatrix(t,y) - sheepMatrix(s,y);
                normHowFar = norm([howFar(x) howFar(y)]);
                % if that sheep is too close, then we add a sheepRadius
                % scaled vector away from that sheep
                if normHowFar < sheepRadius
                    xDifft = xDifft - sheepRadius*howFar(x)/normHowFar;
                    yDifft = yDifft - sheepRadius*howFar(y)/normHowFar;
                end
            end
        end
        % these values are already normalised so each sheep only
        % experiences one vector impulse as a result of all other sheep
        xDiff = xDiff + xDifft/t;
        yDiff = yDiff + yDifft/t;
        % we finally scale the resulting vector of this sheep back to its
        % speed, which is one
        normDiff = norm([xDiff yDiff]);
        % if the sheep needs to move at all, then normDiff will be non-zero
        if normDiff > 0
            xDiff = xDiff/normDiff;
            yDiff = yDiff/normDiff;
            % and then give this sheep its new position, checking for
            % boundaries of the arena
            if (sheepMatrix(s,x) + xDiff) > 0 && (sheepMatrix(s,x) + xDiff) < width
                sheepMatrix(s,x) = sheepMatrix(s,x) + xDiff;
            end
            if (sheepMatrix(s,y) + yDiff) > 0 && (sheepMatrix(s,y) + yDiff) < height
                sheepMatrix(s,y) = sheepMatrix(s,y) + yDiff;
            end
        end
    end
    % we now give the shepherd its new position
    % first, we determine if the shepherd must pause for this time step
    % because it is too close to a sheep
    tooClose = 0;
    for s = 1:numSheep
        % calculate how far each sheep is away
        howFar(x) = shepherdPos(x) - sheepMatrix(s,x);
        howFar(y) = shepherdPos(y) - sheepMatrix(s,y);
        normHowFar = norm([howFar(x) howFar(y)]);
        % check if the shepherd is too close
        if normHowFar < 3*sheepRadius
            % if so, then we don't do any more computation and the shepherd
            % stays in place
            tooClose = 1;
            break;
        end
    end
    % if at this point, the shepherd is not too close to a sheep
    if tooClose == 0
        % if the flock is clustered enough
        if isClustered == 1
            % then the shepherd goes to the driving position
            shepherdMove(x) = drivingPos(x) - shepherdPos(x);
            shepherdMove(y) = drivingPos(y) - shepherdPos(y);
        else
            % otherwise, it goes to the collecting position
            shepherdMove(x) = collectingPos(x) - shepherdPos(x);
            shepherdMove(y) = collectingPos(y) - shepherdPos(y);
        end
        % we then scale how far the shepherd moves (as it moves at a max
        % speed of 1.5 m/s)
        normShepherdMove = norm([shepherdMove(x) shepherdMove(y)]);
        if (shepherdPos(x) + 1.5*shepherdMove(x)/normShepherdMove) > 0 && (shepherdPos(x) + 1.5*shepherdMove(x)/normShepherdMove) < width
            shepherdPos(x) = shepherdPos(x) + 1.5*shepherdMove(x)/normShepherdMove;
        end
        if (shepherdPos(y) + 1.5*shepherdMove(y)/normShepherdMove) > 0 && (shepherdPos(y) + 1.5*shepherdMove(y)/normShepherdMove) < height
            shepherdPos(y) = shepherdPos(y) + 1.5*shepherdMove(y)/normShepherdMove;
        end
    end
    % if the shepherd is close enough to the goal, then we stop
    if norm([shepherdPos(x) shepherdPos(y)]) < 20 & norm([drivingPos(x) drivingPos(y)]) < 20
%
        break;
    end
end