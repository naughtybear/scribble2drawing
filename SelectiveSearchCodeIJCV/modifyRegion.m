function modifyregion = modifyRegion(region, regionInfo)
%% modify region to square 把圖放在正中間

regionNum = size(regionInfo,1);

for i = 1:regionNum
    width = size(region{i,1},2);
    height = size(region{i,1},1);
    if width > height
        tmp = zeros(width,width,3);
        startY = round(width/2 - height/2);
        tmp(startY : startY + height-1,:,:) = region{i,1};
     elseif height > width
        tmp = zeros(height,height,3);
        startX = round(height/2 - width/2);
        tmp(:,startX : startX + width-1,:) = region{i,1};
    else
        tmp = region{i,1};
    end
    modifyregion{i,1} = tmp;
end