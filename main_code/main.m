clc ;
clear ;
close all ;

addpath(genpath('/home/naughtybear/python/Drawing_AI/code/master_v3_StyleTransfer'))

kid_draw = dir(['../image_test/image/SparseDeep_multi/' '*.mat' ]);
% kid_draw = dir(['..\image_test\scribble\' '*.jpg' ]);
style = dir(['../image_test/style/' '*.jpg']);
num_kid = length(kid_draw);
num_style = length(style);

i=1;
j=1;
%for i = 1:25 %num_kid
%    for j = 1 : num_style
        disp(j);
        load(['../image_test/image/SparseDeep_multi/image_synthesis_' num2str(i) ]);
%         img_kid = imread(['..\image_test\scribble\' kid_draw(i).name ]);
        img_style = imread(['../image_test/style/' style(j).name ]);
        tic
        result = neural_style(synthesis,img_style);
        toc
        imwrite(result,['../result/SparseDeep_multi/image'  num2str(i) '_style' num2str(j) '.png']) ;
        imshow(synthesis);
%    end
%end