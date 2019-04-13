function create_region(img_num)

load(['region\region_' num2str(img_num) '.mat']);

mkdir(['region_result/image_' num2str(img_num)])
for i = 1 : size(modifyregion,1)
    imwrite(modifyregion{i,1},['region_result\image_' num2str(img_num) '\region_' num2str(i) '.png']);
end