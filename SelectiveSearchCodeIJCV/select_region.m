function select_region(img,img_num)
close all;
tic;

%% 黑白反轉 ; 二值化
img = 255-img;
img = imresize(img,[125 177]);
img = im2bw(img,0.1);

%imshow(img);

%% selective Search
[region, regionInfo] = selectiveSearch(img);
%% 把region放到正中間
modifyregion = modifyRegion(region, regionInfo);
mkdir(['./result/region/' num2str(img_num)])
for i = 1: size(region)
    imwrite(region{i}, ['./result/region/' num2str(img_num) '/region' num2str(i) '.png']);
end
save(['store_mat/region_' num2str(img_num) '.mat'],'modifyregion','regionInfo');






