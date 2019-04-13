function composition = pasteObj(region,regionInfo,finalRegion,bestR,backgroundId)
%% background voting
% [dbAttribute] = xlsread('..\caltech101_attribute.xlsx','Sheet2');
load('..\caltech101_Silhouettes_Mfile\cal101Silhouettes28.mat');
cal101Path = '..\RandomizedCaltech101Crop\';
cal101MaskPath = '..\RandomizedCaltech101MasksCrop\';
backgrounrPath = '..\sketch background\';
% for i=1:size(finalRegion,1)
%     pictureId = finalRegion(i,2);
%     classId =  label(1,pictureId);
%     regionAttribute(i,:) = dbAttribute(classId,:);
% end
% [Sum, backgroundId] = max(sum(regionAttribute)); % get final background
% %-------------------------------------------------------------------------------
%% change sequence by coordinate Y 按照y座標排，先貼y較小的
RegionNum = size(bestR,2);
for i=1:RegionNum
    pasteSequence(i,1:2) = finalRegion(bestR(i),1:2);
    pasteSequence(i,3:6) = regionInfo(finalRegion(bestR(i),1),:); 
end
pasteSequence = sortrows(pasteSequence,3); %pasteSequence = regionId + objId + y1 x1 y2 x2
%% 
TargIm = imread([backgrounrPath,int2str(backgroundId),'.jpg']) ;
% TargIm = imread('D:\chun\sketch\sketch background\2.jpg');
TargIm = imresize(TargIm,[115 164]);
% imshow(background);
for i =1:RegionNum
    [regionClass,regionClassId] = findClassPictureId(pasteSequence(i,2),label,eachLabelNumSum);
    cal101=dir([cal101Path,classnames{1, regionClass},'\*.jpg']); 
    cal101mask=dir([cal101MaskPath,classnames{1, regionClass},'\*.jpg']); 
    SourceIm = imread([cal101Path,classnames{1, regionClass},'\',cal101(regionClassId).name]);
    regionWidth = regionInfo(pasteSequence(i,1),4)-regionInfo(pasteSequence(i,1),2)+1;
    regionHeight = regionInfo(pasteSequence(i,1),3)-regionInfo(pasteSequence(i,1),1)+1;
    SourceIm = imresize(SourceIm,[regionHeight regionWidth]);
    SourceMask = imread([cal101MaskPath,classnames{1, regionClass},'\',cal101mask(regionClassId).name]);
    SourceMask = imresize(SourceMask,[regionHeight regionWidth]);
    tmp = cat(3,SourceMask,SourceMask);
    SourceMask = cat(3,tmp,SourceMask);
    SourceX = regionInfo(pasteSequence(i,1),2);
    SourceY = regionInfo(pasteSequence(i,1),1);
    TargIm(SourceY:SourceY+regionHeight-1,SourceX:SourceX+regionWidth-1,:) = TargIm(SourceY:SourceY+regionHeight-1,SourceX:SourceX+regionWidth-1,:)-SourceMask+(SourceIm-(255-SourceMask));  
end
composition = TargIm;