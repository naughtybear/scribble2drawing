clc ;
clear ;
close all ;
addpath(genpath('/home/naughtybear/python/Drawing_AI/code/master/sketch'))

kid_draw = dir(['../image_test/thinning/' '*.png' ]);
style = dir(['../image_test/style/' '*.jpg']);
num_kid = length(kid_draw);
num_style = length(style);


for i = 1:25 %跑25張圖

        img_kid = imread(['../image_test/thinning/' kid_draw(i).name ]);
        img_style = imread(['../image_test/style/' style(8).name ]);

        %% 找region
        select_region(img_kid,i);
        %% 建region圖
%         create_region(i);
        %% 建立region的h5檔
%         create_test(i);
        %% 單獨跑sparse
        sketch_sparse(img_style,i);
        %% 單獨跑deep
%          sketch_deep(img_style,i);
        %% 跑sparse+deep
%          sketch_SparseDeep(img_style,i);
        %% 跑sparse*deep
%         sketch_SparseDeep_multi(img_style,i);         
end

