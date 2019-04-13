function writeimage_deep(modifyregion,finalRegion,bestR,img_num)
load('..\caltech101_Silhouettes_Mfile\cal101Silhouettes227.mat');
bestR_num = size(bestR,2);
for i = 1 :bestR_num
    imwrite(modifyregion{finalRegion(bestR(i),1)},['result\deep\image_' num2str(img_num) '_region_' num2str(i) '.png']);
    imwrite(reshape(cal101SilhouettesMaskEdge(finalRegion(bestR(i),2),:),[227 227]),['result\deep\image_' num2str(img_num) '_contour_' num2str(i) '.png']);
end


