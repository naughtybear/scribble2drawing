function [bestR,backgroundId] = composition(region,regionInfo,finalRegion)
regionNum = size(finalRegion,1);
[dbAttribute] = xlsread('..\caltech101_attribute.xlsx','Sheet2'); %dbAttribute:�C����I����label
load('..\caltech101_Silhouettes_Mfile\cal101Silhouettes28.mat');
for r=1:2^regionNum-1
%% creat selection list    
    str = dec2bin(r,regionNum);
    for j=1:length(str)
        selectionList(r,j)=str2num(str(j))*j;
    end

%% overlapping term1
    overlapping = zeros(115,164);
    for i = 1:regionNum
        if selectionList(r,i) ~=0
            finalregionId = selectionList(r,i);
            regionId = finalRegion(finalregionId,1);
            area = zeros(115,164); %�s�Ф@�ӻP��Ϥ@�ˤj�B������0���x�}
            area(regionInfo(regionId,1):regionInfo(regionId,3),regionInfo(regionId,2):regionInfo(regionId,4)) = 1; %�⦳OBJ����m�Ь�1
            overlapping = overlapping + area;
            coeff = finalRegion(i,3);
        end
    end
    union = sum(sum((overlapping) > 0));
    intersect = sum(sum((overlapping) > 1));%�j��1��ܨ��Ӧ�m�Q2�ӥH�W��OBJ�л\
    overlapping_ratio(r) = intersect/union;
    nonoverlapping_ratio(r) = (1-overlapping_ratio(r)) + (union/(1158164)); %nonoverlapping + OBJ����i�v�����(��2����]�O: 
%     if nonoverlapping_ratio(r) == 1
%         nonoverlapping_ratio(r) = nonoverlapping_ratio(r) + union;
%     end
    
 %% coeff term2  
    coeff = 0;
    for i = 1:regionNum
        if selectionList(r,i) ~=0
            coeff = coeff + finalRegion(i,3);
        end
    end
    similarity(r) = coeff/regionNum;
  %% background term3
   votes = zeros(1,11);
   for i=1:regionNum
        if selectionList(r,i) ~=0
            pictureId = finalRegion(i,2);
            classId =  label(1,pictureId); %picture�O�ݲĴX��
            votes = votes + dbAttribute(classId,:); %dbAttribute:�C����I����label
        end
    end
    [Sum, backgroundId] = max(votes);
    bgRelation(r) = Sum/regionNum;    
end
%% total score
score = [nonoverlapping_ratio', similarity'/max(similarity), bgRelation'];
% scoreSum = 0.3*nonoverlapping_ratio + 0.3*similarity/max(similarity) + 0.1*bgRelation; %3��term�e�i�H�[�Y�Ʊ���G
scoreSum = nonoverlapping_ratio;
%% save bestR
[bestComposition ,bestCompositionId] = max(scoreSum);
% bestComposition = 2^size(finalRegion,1)-1; 
count = 1;
for i=1:regionNum
        if selectionList(bestCompositionId,i) ~=0
            bestR(count) = selectionList(bestCompositionId,i);
            count = count+1;
        end
end