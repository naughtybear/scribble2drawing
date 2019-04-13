function hausdorff_test(modifyregion,finalRegion,img_num,ty)

load('cal101/caltech101_Silhouettes_Mfile/cal101Silhouettes50.mat');
num = size(finalRegion,1);
% mkdir(['result/compare/SparseDeep_multi/' num2str(img_num)]);
mkdir(['result/compare/scribble/' num2str(img_num)]);
for i = 1 :num
    region = imresize(modifyregion{finalRegion(i,1)},[50 50],'nearest');
    region = sum(region,3)./3;
    contour = reshape(cal101SilhouettesMaskEdge(finalRegion(i,2),:),[50 50]);
    % avg_of_hausdorff use avg instead of max, if you want to use normal
    % hausdorff pls use function hausdorff instead of avg_of_hausdorff
    temp(i) = avg_of_hausdorff(region,contour);
    imwrite(modifyregion{finalRegion(i,1)},['result/compare/scribble/' num2str(img_num) '/' num2str(i) '.png']);
%     imwrite(contour,['result/compare/SparseDeep_multi/' num2str(img_num) '/' num2str(i) '.png']);
end

value=sum(temp)/num;

if strcmp(ty, 'SparseDeep')
    save(['result/SparseDeep/image_hausdorff_' num2str(img_num) '.mat'],'value');
elseif strcmp(ty, 'sparse')
    save(['result/sparse/image_hausdorff_' num2str(img_num) '.mat'],'value');
elseif strcmp(ty, 'deep')
    save(['result/deep/image_hausdorff_' num2str(img_num) '.mat'],'value');
end

