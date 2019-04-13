function poisson = poissonEditing(region,regionInfo,finalRegion)
%% background voting
[dbAttribute] = xlsread('..\caltech101_attribute.xlsx','Sheet2');
load('..\caltech101_Silhouettes_Mfile\cal101Silhouettes28.mat');
cal101Path = '..\RandomizedCaltech101Crop\';
cal101MaskPath = '..\RandomizedCaltech101MasksCrop\';
backgrounrPath = '..\sketch background\';
for i=1:size(finalRegion,1)
    pictureId = finalRegion(i,2);
    classId =  label(1,pictureId);
    regionAttribute(i,:) = dbAttribute(classId,:);
end
[Sum, backgroundId] = max(sum(regionAttribute)); % get final background
%-------------------------------------------------------------------------------
%% change sequence by coordinate Y
finalRegionNum = size(finalRegion,1);
for i=1:finalRegionNum
    pasteSequence(i,1:2) = finalRegion(i,:);
    pasteSequence(i,3:6) = regionInfo(finalRegion(i,1),:); 
end
pasteSequence = sortrows(pasteSequence,3); %pasteSequence = regionId + objId + y1 x1 y2 x2
%% poisson editing
TargIm = imread([backgrounrPath,int2str(backgroundId),'.jpg']) ;
% TargIm = imread('D:\chun\sketch\sketch background\2.jpg');
TargIm = imresize(TargIm,[115 164]);
% imshow(background);
for i =1:finalRegionNum
    [regionClass,regionClassId] = findClassPictureId(pasteSequence(i,2),label,eachLabelNumSum);
    cal101=dir([cal101Path,classnames{1, regionClass},'\*.jpg']); 
    cal101mask=dir([cal101MaskPath,classnames{1, regionClass},'\*.jpg']); 
    SourceIm = imread([cal101Path,classnames{1, regionClass},'\',cal101(regionClassId).name]);
    regionWidth = regionInfo(pasteSequence(i,1),4)-regionInfo(pasteSequence(i,1),2)+1;
    regionHeight = regionInfo(pasteSequence(i,1),3)-regionInfo(pasteSequence(i,1),1)+1;
    SourceIm = imresize(SourceIm,[regionHeight regionWidth]);
    SourceMask = imread([cal101MaskPath,classnames{1, regionClass},'\',cal101mask(regionClassId).name]);
    SourceMask = imresize(SourceMask,[regionHeight regionWidth]);
    SourceX = regionInfo(pasteSequence(i,1),2);
    SourceY = regionInfo(pasteSequence(i,1),1);
    poisson = PoissonEditingDemo(TargIm,SourceIm,SourceMask,SourceX, SourceY);
    TargIm = poisson;
end
poisson = TargIm;