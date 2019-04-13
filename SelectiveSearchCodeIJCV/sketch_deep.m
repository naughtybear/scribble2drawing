function sketch_deep(style,img_num)
tic

%% deep learning
load(['region\region_' num2str(img_num) '.mat']);
compareResult = deepCompare(modifyregion,img_num);
finalRegion = deleteOverlapRegion(compareResult, regionInfo);

%% hausdorff驗證
hausdorff_test(modifyregion, finalRegion,img_num,'deep') ;

%% 如果跑hausdorff驗證，此段註解
% [bestR,backgroundId] = composition_origin_deep(regionInfo,finalRegion); %最佳化
% writeimage_deep(modifyregion,finalRegion,bestR,img_num); %讀出region contour
% synthesis = pasteObj(regionInfo,finalRegion,bestR,backgroundId);
% save(['result\deep\image_synthesis_' num2str(img_num) '.mat'],'synthesis');
% imwrite(synthesis,['result\deep\image_synthesis_' num2str(img_num) '.png']);

toc;
