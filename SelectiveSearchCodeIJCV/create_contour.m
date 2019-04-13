function create_contour(regionInfo,finalRegion,img_num)


%% background voting
% [dbAttribute] = xlsread('..\caltech101_attribute.xlsx','Sheet2');
load('..\caltech101_Silhouettes_Mfile\cal101Silhouettes50.mat');
cal101Path = '..\RandomizedCaltech101Crop\';
cal101MaskPath = '..\RandomizedCaltech101MasksCrop\';
% %-------------------------------------------------------------------------------
RegionNum = size(finalRegion,1);
mkdir(['contour_result/image_' num2str(img_num)])
mkdir(['contour_image_result/image_' num2str(img_num)])
for i =1:RegionNum
    [regionClass,regionClassId] = findClassPictureId(finalRegion(i,2),label,eachLabelNumSum);
    cal101=dir([cal101Path,classnames{1, regionClass},'\*.jpg']); 
    cal101mask=dir([cal101MaskPath,classnames{1, regionClass},'\*.jpg']); 
    SourceIm = imread([cal101Path,classnames{1, regionClass},'\',cal101(regionClassId).name]);
%     SourceIm = imresize(SourceIm,[regionHeight regionWidth]);
    SourceMask = imread([cal101MaskPath,classnames{1, regionClass},'\',cal101mask(regionClassId).name]);
%     SourceMask = imresize(SourceMask,[regionHeight regionWidth]);
    tmp = cat(3,SourceMask,SourceMask);
    SourceMask = cat(3,tmp,SourceMask);
    result = -SourceMask+(SourceIm-(255-SourceMask));
    imwrite(reshape(cal101SilhouettesMaskEdge(finalRegion(i,2),:),50,50),['contour_result\image_' num2str(img_num) '\contour_' num2str(finalRegion(i,1)) '.png']);
    imwrite(result,['contour_image_result\image_' num2str(img_num) '\contour_' num2str(finalRegion(i,1)) '.png']);
end