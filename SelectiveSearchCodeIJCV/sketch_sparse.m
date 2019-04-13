function [synthesis] = sketch_sparse(img_num)
tic;

load(['store_mat/region_' num2str(img_num) '.mat']);
%% sparse coding
compareResult = sparsecodingCompare(modifyregion,img_num);
% for i = 1:size(compareResult)
%     imwrite(compareResult{i}, ['result/compare_result/' num2str(i) '.png'])
% end
finalRegion = deleteOverlapRegion(compareResult, regionInfo);
% for i = 1:size(finalRegion)
%     imwrite(finalRegion{i}, ['result/fina_region/' num2str(i) '.png'])
% end

%% hausdorff驗證
%hausdorff_test(modifyregion, finalRegion,img_num,'sparse') ;
disp('2222')
%% 如果跑hausdorff驗證，此段註解
[bestR,backgroundId] = composition_o(regionInfo,finalRegion); %最佳化
disp('3333')
writeimage_sparse(modifyregion,finalRegion,bestR,img_num); %讀出region contour
disp('4444')
synthesis = pasteObj(regionInfo,finalRegion,bestR,backgroundId);
save(['store_mat/image_synthesis_' num2str(img_num) '.mat'],'synthesis');
imwrite(synthesis,['result/sel_reg/image_synthesis_' num2str(img_num) '.png']);

toc;
