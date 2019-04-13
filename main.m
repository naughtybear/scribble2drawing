clc ;
clear ;
close all ;

addpath(genpath('/home/naughtybear/python/Drawing_AI/code/combine'));

style_num = 4;
count = 1;
style = dir(['./image_test/style/' '*.jpg']);

tic;
%thining_result = thinning('./input/image000.jpg');
%thining_result = im2uint8(thining_result);
%thining_result = imread('result/thinning_result/IMG_0001.png');
disp('thining finish');
%select_region(thining_result, count);
disp('select_region finish');
%synthesis = sketch_sparse(count);
synthesis = imread(['result/sel_reg/image_synthesis_1.png']);
disp('sketch_sparse finish');
img_style = imread(['./image_test/style/' style(style_num).name ]);
result = neural_style(synthesis,img_style);
%imshow(result);
imwrite(result,['./result/final/image'  num2str(count) '_style' num2str(style_num) '.png']) ;
toc;