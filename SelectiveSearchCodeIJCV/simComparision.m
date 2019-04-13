function finalRegion = simComparision(feature)
dbFeature = load('D:\chun\sketch\sparseFeature.mat');
db = load('D:\chun\sketch\caltech101_Silhouettes_Mfile\cal101Silhouettes28.mat');
regionNum = size(feature,1);
dbImgNum = size(dbFeature.alpha_f,2);
for i=1:regionNum
    for j=1:dbImgNum
        err(j,1) = j;
        err(j,2) = immse(feature(i,:)',dbFeature.alpha_f(:,j)); %err = objId + mse
    end
    localRank = sortrows(err, 2); %按mse小到大排
    localMin(i,2) = i; % region id
    localMin(i,3) = localRank(1,1); % object id
    localMin(i,1) = localRank(1,2); % mse error
    
end
rank = sortrows(localMin);

[finalRegion(:,2), finalRankId, ic] = unique(rank(:,3),'stable'); %取出不重複的結果

for i = 1:size(finalRegion,1)
    finalRegion(i,1) = rank(finalRankId(i),2); %finalRegion = regionId+simObjectId
end
