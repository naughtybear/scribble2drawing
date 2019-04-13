function [bestR,backgroundId] = composition_origin_deep(regionInfo,finalRegion)
regionNum = size(finalRegion,1);
[dbAttribute] = xlsread('..\caltech101_attribute.xlsx','Sheet2'); %dbAttribute:每類對背景的label
load('..\caltech101_Silhouettes_Mfile\cal101Silhouettes50.mat');
for r=1:2^regionNum-1
%% creat selection list    
    str = dec2bin(r,regionNum);
    for j=1:length(str)
        selectionList(r,j)=str2num(str(j))*j;
    end

%% overlapping term1
    overlapping = zeros(125,177);
    for i = 1:regionNum
        if selectionList(r,i) ~=0
            finalregionId = selectionList(r,i);
            regionId = finalRegion(finalregionId,1);
%             area = zeros(115,164); %新創一個與原圖一樣大且全都為0的矩陣
            area = zeros(125,177); %新創一個與原圖一樣大且全都為0的矩陣
            area(regionInfo(regionId,1):regionInfo(regionId,3),regionInfo(regionId,2):regionInfo(regionId,4)) = 1; %把有OBJ的位置標為1
            overlapping = overlapping + area;
        end
    end
    union = sum(sum((overlapping) > 0));
    intersect = sum(sum((overlapping) > 1));%大於1表示那個位置被2個以上的OBJ覆蓋
    overlapping_ratio(r) = intersect/union;
    nonoverlapping_ratio(r) = (1-overlapping_ratio(r)) + (union/(125*177)); %nonoverlapping + OBJ佔整張影像比例(第2項原因是:
%     nonoverlapping_ratio(r) = (1-overlapping_ratio(r)); %nonoverlapping + OBJ佔整張影像比例(第2項原因是: 
%     if nonoverlapping_ratio(r) == 1
%         nonoverlapping_ratio(r) = nonoverlapping_ratio(r) + union;
%     end
    
 %% coeff term2  (deep機率)
    coeff = 0;
    x = 0;
    for i = 1:regionNum
        if selectionList(r,i) ~=0
            coeff = coeff + finalRegion(i,3);
            x = x+1;
        end
    end
    similarity(r) = coeff/x;
  %% background term3
   votes = zeros(1,11);
   x = 0;
   for i=1:regionNum
        if selectionList(r,i) ~=0
            pictureId = finalRegion(i,2);
            classId =  label(1,pictureId); %picture是屬第幾類
            votes = votes + dbAttribute(classId,:); %dbAttribute:每類對背景的label
            x = x+1;
        end
    end
    [Sum, backgroundId_t(r)] = max(votes);
    bgRelation(r) = Sum/x;    
end
%% total score
% score = [nonoverlapping_ratio', similarity'/max(similarity), bgRelation'];
scoreSum = nonoverlapping_ratio + similarity + bgRelation; %3個term前可以加係數控制結果
% scoreSum = nonoverlapping_ratio;
%% save bestR
[bestComposition ,bestCompositionId] = max(scoreSum);
backgroundId = backgroundId_t(bestCompositionId);
% bestComposition = 2^size(finalRegion,1)-1; 
count = 1;
for i=1:regionNum
        if selectionList(bestCompositionId,i) ~=0
            bestR(count) = selectionList(bestCompositionId,i);
            count = count+1;
        end
end
a = 0;

