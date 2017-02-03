dl = 1000; % 1m
dt = 60; %s
maxSelfSpeed = 1; % m/s
endT = 10;
startPoint = [50,50];

selfSpeeds = (-maxSelfSpeed:dl:maxSelfSpeed);
selfSpeeds = [zeros(numel(selfSpeeds),1) selfSpeeds'];

windSpeed = zeros(2,1000,1000); %1mx1m grid. 1m/s unit
windSpeed(1,:,:) = permute(generate2DWindMap([1000 1000],20,1000,1),[3 1 2]);

possiblePoints = cell((endT/dt)+1,1);
possiblePoints{1} = startPoint;
for it = 1:(endT/dt)
    currT = it*dt;
    for indPP = 1:size(possiblePoints{it},1)
        currPoint = possiblePoints{it}(indPP,:);
        speedList = repmat(windSpeed(:,round(currPoint(1)/dl),round(currPoint(2)/dl))',size(selfSpeeds,1),1) + selfSpeeds;
        tmpPointList = repmat(currPoint,size(speedList,1),1)+speedList;
        possiblePoints{it+1} = uniquetol([possiblePoints{it+1};tmpPointList],'ByRows',true);
    end
end