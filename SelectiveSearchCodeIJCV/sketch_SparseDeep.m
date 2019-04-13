function sketch_SparseDeep(style,img_num)
tic;

load(['region\region_' num2str(img_num) '.mat']);
%% sparse coding+deep
compareResult = SparseDeep(modifyregion,img_num);
finalRegion = deleteOverlapRegion(compareResult, regionInfo);

%% ��contour��
% create_contour(regionInfo,finalRegion,img_num);

%% hausdorff����
% hausdorff_test(modifyregion, finalRegion,img_num,'SparseDeep') ;

%% �p�G�]hausdorff���ҡA���q����
% [bestR,backgroundId] = composition_origin_deep(regionInfo,finalRegion); %�̨Τ�
% writeimage_SparseDeep(modifyregion,finalRegion,bestR,img_num); %Ū�Xregion contour
% synthesis = pasteObj(regionInfo,finalRegion,bestR,backgroundId);
% save(['result\SparseDeep\image_synthesis_' num2str(img_num) '.mat'],'synthesis');
% imwrite(synthesis,['result\SparseDeep\image_synthesis_' num2str(img_num) '.png']);

toc;
