function finalResult = deleteOverlapRegion(compareResult, regionInfo)

regionNum = size(compareResult,1);
isOverlap = zeros(regionNum , 1);

for i = 1:regionNum
%     regionCenter = [(regionInfo(:,3) + regionInfo(:,1))/2, (regionInfo(:,4) + regionInfo(:,2))/2];
    compareResultInfo(i,:) =  regionInfo(compareResult(i,1),:);
end

for i = 1:regionNum %判斷是否overlap ，1為有overlap，0沒有
    if (isOverlap(i,1) == 0)
        for j = (i+1) : regionNum
            if (isOverlap(j,1) == 0)
                for k = 1:4
                    diff(1,k) = (compareResultInfo(j,k) - compareResultInfo(i,k))^2;
                end
                totalDiff = sum(diff);
                
                if totalDiff < 700
                    isOverlap(j,1) = 1;
                end
            end
        end
    end
end

count = 1;
for i = 1:regionNum %列出剩下region
    if isOverlap(i,1) == 0;
        finalResult(count,:) = compareResult(i,:);
        count = count+1;
    end
end
