function [ windMap ] = generate2DWindMap( sz, scale, strength, debug )
    if(nargin < 4)
        debug = 0;
    end
    if(nargin < 3)
        strength = 10;
    end
    if(nargin < 2)
        scale = 20;
    end
       
    windMap = zeros(sz);
    windMap(ceil(rand(scale,1)*sz(1)*sz(2))) = (rand(scale,1)-0.5)*strength;
    xwnd = (-(sz(1)):(sz(1)))';
    ywnd = -(sz(2)):(sz(2));
    wnd = (repmat(xwnd,1,numel(ywnd)).^2 + repmat(ywnd,numel(xwnd),1).^2).^.5;
    wnd = normpdf(wnd,0,mean(size(wnd))/scale/1);
    wnd = wnd / sum(wnd(:));
    
    windMap = filter2(wnd,windMap)*2000;
    if(debug)
        imagesc(windMap)
    end
end

