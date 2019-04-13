clc ;
clear ;
close all ;

for i = 1 : 25 %¤»±i¹Ï
    load(['result\v1\deep\image_hausdorff_' num2str(i) '.mat']);
    deep(i) = sum(value);
    load(['result\v1\sparse\image_hausdorff_' num2str(i) '.mat']);
    sparse(i) = sum(value);
    load(['result\v3\SparseDeep\image_hausdorff_' num2str(i) '.mat']);
    SparseDeep(i) = sum(value);
end

d_m = mean(deep);
s_m = mean(sparse);
sd_m = mean(SparseDeep);