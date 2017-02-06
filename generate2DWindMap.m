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
    windMap(ceil(rand(scale,1)*sz(1)*sz(2))) = (rand(scale,1)-0.5);
    xwnd = ((-sz(1):sz(1))')/sz(1);
    ywnd = (-sz(2):sz(2))/sz(2);
    wnd = (repmat(xwnd,1,numel(ywnd)).^2 + repmat(ywnd,numel(xwnd),1).^2).^.5;
    wnd = normpdf(wnd,0,1/scale^0.5);
    wnd = wnd / sum(wnd(:));
    
    windMap = filter2(wnd,windMap);
    windMap = windMap/(max(windMap(:))-min(windMap(:)))*strength*2;
    if(debug)
        imagesc(windMap)
    end
end

