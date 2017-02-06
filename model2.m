dlx = 1000; % 1km
dly = 1000; % 1km
maxSelfSpeed = 1; % m/s
endT = 3600;
startPoint = [500.1e3;30.99e3];

windSpeed = zeros(2,1000,1000); %1mx1m grid. 1m/s unit
windSpeed(1,:,:) = permute(generate2DWindMap([1000 1000],2000,200,0),[3 1 2]);
windSpeed(2,:,:) = permute(generate2DWindMap([1000 1000],2000,2,0), [3 1 2]);

% windSpeed(1,:,:) = windSpeed(1,:,:)/(max(max(windSpeed(1,:,:)))-min(min(windSpeed(1,:,:))));
% windSpeed(1,:,:) = (windSpeed(1,:,:)+0.5);%*255;
% 
% windSpeed(2,:,:) = windSpeed(2,:,:)/(max(max(windSpeed(2,:,:)))-min(min(windSpeed(2,:,:))));
% windSpeed(2,:,:) = (windSpeed(2,:,:)+.5);%*255;
% 
% windSpeed(3,:,:) = windSpeed(2,:,:);
% windSpeed(2,:,:) = 0;
% image(permute(windSpeed,[2,3,1]))

rootEdge = EdgeTree([]);
currCell = ceil(startPoint ./ [dlx;dly]);
currWind = windSpeed(:,currCell(1),currCell(2));
localCoords = startPoint - (currCell - [1;1]).*[dlx;dly];

tracePath([dlx;dly], localCoords,currWind + [0;1],currWind - [0;1]);
