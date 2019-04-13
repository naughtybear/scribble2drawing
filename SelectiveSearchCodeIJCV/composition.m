function [bestR,backgroundId] = composition(regionInfo,finalRegion)
regionNum = size(finalRegion,1);
[dbAttribute] = xlsread('..\caltech101_attribute.xlsx','Sheet2'); %dbAttribute:�C����I����label
load('..\caltech101_Silhouettes_Mfile\cal101Silhouettes50.mat');
if regionNum < 3
    combos = combntns(uint8(1:regionNum),regionNum);
else
    combos = combntns(uint8(1:regionNum),3);
end
combos_num = size(combos,1);
region_num = size(combos,2);
for r=1:combos_num
%% creat selection list    
    str = dec2bin(r,regionNum);
    for j=1:length(str)
        selectionList(r,j)=str2num(str(j))*j;
    end

%% overlapping term1
    overlapping = zeros(125,177);
    for i = 1:region_num
        finalregionId = combos(r,i);
        regionId = finalRegion(finalregionId,1);
        area = zeros(125,177); %�s�Ф@�ӻP��Ϥ@�ˤj�B������0���x�}
        area(regionInfo(regionId,1):regionInfo(regionId,3),regionInfo(regionId,2):regionInfo(regionId,4)) = 1; %�⦳OBJ����m�Ь�1
        overlapping = overlapping + area;
    end
    union = sum(sum((overlapping) > 0));
    intersect = sum(sum((overlapping) > 1));%�j��1��ܨ��Ӧ�m�Q2�ӥH�W��OBJ�л\
    overlapping_ratio(r) = intersect/union;
    nonoverlapping_ratio(r) = (1-overlapping_ratio(r)) + (union/(125*177)); %nonoverlapping + OBJ����i�v�����(��2����]�O: 
%     if nonoverlapping_ratio(r) == 1
%         nonoverlapping_ratio(r) = nonoverlapping_ratio(r) + union;
%     end
    
 %% coeff term2  
    coeff = 0;
    for i = 1:region_num
        coeff = coeff + finalRegion(combos(r,i),3);
    end
    similarity(r) = coeff/region_num;
  %% background term3
   votes = zeros(1,11);
   for i=1:region_num
       pictureId = finalRegion(combos(r,i),2);
       classId =  label(1,pictureId); %picture�O�ݲĴX��
       votes = votes + dbAttribute(classId,:); %dbAttribute:�C����I����label
    end
    [Sum, backgroundId] = max(votes);
    bgRelation(r) = Sum/region_num;    
end
%% total score
% score = [nonoverlapping_ratio', similarity'/max(similarity), bgRelation'];
% scoreSum = nonoverlapping_ratio + similarity/max(similarity) + bgRelation; %3��term�e�i�H�[�Y�Ʊ���G
scoreSum = nonoverlapping_ratio + similarity + bgRelation; %3��term�e�i�H�[�Y�Ʊ���G
% scoreSum = nonoverlapping_ratio;
%% save bestR
[bestComposition ,bestCompositionId] = max(scoreSum);
bestR = combos(bestCompositionId,:);
