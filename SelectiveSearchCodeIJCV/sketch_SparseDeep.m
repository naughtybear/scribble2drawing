function sketch_SparseDeep(style,img_num)
tic;

load(['region\region_' num2str(img_num) '.mat']);
%% sparse coding+deep
compareResult = SparseDeep(modifyregion,img_num);
finalRegion = deleteOverlapRegion(compareResult, regionInfo);

%% 建contour圖
% create_contour(regionInfo,finalRegion,img_num);

%% hausdorff驗證
% hausdorff_test(modifyregion, finalRegion,img_num,'SparseDeep') ;

%% 如果跑hausdorff驗證，此段註解
% [bestR,backgroundId] = composition_origin_deep(regionInfo,finalRegion); %最佳化
% writeimage_SparseDeep(modifyregion,finalRegion,bestR,img_num); %讀出region contour
% synthesis = pasteObj(regionInfo,finalRegion,bestR,backgroundId);
% save(['result\SparseDeep\image_synthesis_' num2str(img_num) '.mat'],'synthesis');
% imwrite(synthesis,['result\SparseDeep\image_synthesis_' num2str(img_num) '.png']);

toc;
