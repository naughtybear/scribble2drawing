function sketch_SparseDeep_multi(style,img_num)
tic;

load(['region\region_' num2str(img_num) '.mat']);
%% sparse coding+deep
compareResult = SparseDeep_multi(modifyregion,img_num);
finalRegion = deleteOverlapRegion(compareResult, regionInfo);

%% ��contour��
% create_contour(regionInfo,finalRegion,img_num);

%% hausdorff����
% hausdorff_test(modifyregion, finalRegion,img_num,'SparseDeep_plus') ;

%% �p�G�]hausdorff���ҡA���q����
[bestR,backgroundId] = composition_origin_deep(regionInfo,finalRegion); %�̨Τ�
writeimage_SparseDeep_plus(modifyregion,finalRegion,bestR,img_num); %Ū�Xregion contour
synthesis = pasteObj(regionInfo,finalRegion,bestR,backgroundId);
save(['result\SparseDeep_multi\image_synthesis_' num2str(img_num) '.mat'],'synthesis');
imwrite(synthesis,['result\SparseDeep_multi\image_synthesis_' num2str(img_num) '.png']);

toc;
