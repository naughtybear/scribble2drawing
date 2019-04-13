clc
clear
close all

% for i = 1:15
%     contour = imread(['Z:\users\ylt\master\sketch\SelectiveSearchCodeIJCV\result\data2\' num2str(i) '-2.png']);
%     contour = double(imresize(contour,[50 50],'nearest'));
%     region = imread(['Z:\users\ylt\master\sketch\SelectiveSearchCodeIJCV\result\data2\' num2str(i) '-1.png']);
% %     region = double(imresize(region,[50 50],'nearest'));
%     region = imresize(region,[50 50],'nearest');
%     region = sum(region,3)./3/255;
% %     region = region/255;
%     contour = contour/255;
%     temp(i) = avg_of_hausdorff(region,contour);
% end

for i = 1:25
    img_name = dir(['Z:\users\ylt\master\sketch\SelectiveSearchCodeIJCV\result\compare\scribble\' num2str(i) '\*.png']); 
    img_num = length(img_name);
    for j = 1 : img_num
        contour_deep = imread(['Z:\users\ylt\master\sketch\SelectiveSearchCodeIJCV\result\compare\deep\' num2str(i) '\' num2str(j) '.png']);
        contour_sparse = imread(['Z:\users\ylt\master\sketch\SelectiveSearchCodeIJCV\result\compare\sparse\' num2str(i) '\' num2str(j) '.png']);
        contour_SD = imread(['Z:\users\ylt\master\sketch\SelectiveSearchCodeIJCV\result\compare\SparseDeep\' num2str(i) '\' num2str(j) '.png']);
        contour_SD_MULTI = imread(['Z:\users\ylt\master\sketch\SelectiveSearchCodeIJCV\result\compare\SparseDeep_multi\' num2str(i) '\' num2str(j) '.png']);
        contour_deep = double(imresize(contour_deep,[50 50],'nearest'));
        contour_sparse = double(imresize(contour_sparse,[50 50],'nearest'));
        contour_SD = double(imresize(contour_SD,[50 50],'nearest'));
        contour_SD_MULTI = double(imresize(contour_SD_MULTI,[50 50],'nearest'));
        contour_deep = contour_deep/255;
        contour_sparse = contour_sparse/255;
        contour_SD = contour_SD/255;
        contour_SD_MULTI = contour_SD_MULTI/255;
        region = imread(['Z:\users\ylt\master\sketch\SelectiveSearchCodeIJCV\result\compare\scribble\' num2str(i) '\' num2str(j) '.png']);
        region = imresize(region,[50 50],'nearest');
        region = sum(region,3)./3/255;
        
%         temp_deep(i,j) = hausdorff(region,contour_deep);
%         temp_sparse(i,j) = hausdorff(region,contour_sparse);
%         temp_SD(i,j) = hausdorff(region,contour_SD);
%         temp_SD_PLUS(i,j) = hausdorff(region,contour_SD_PLUS);

        temp_deep(i,j) = avg_of_hausdorff(region,contour_deep);
        temp_sparse(i,j) = avg_of_hausdorff(region,contour_sparse);
        temp_SD(i,j) = avg_of_hausdorff(region,contour_SD);
        temp_SD_MULTI(i,j) = avg_of_hausdorff(region,contour_SD_MULTI);
        
    end
    mean_deep(i) = sum(temp_deep(i,:))/img_num;
    mean_sparse(i) = sum(temp_sparse(i,:))/img_num;
    mean_SD(i) = sum(temp_SD(i,:))/img_num;
    mean_SD_PLUS(i) = sum(temp_SD_MULTI(i,:))/img_num;
    
end