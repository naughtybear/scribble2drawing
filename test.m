clc ;
clear ;
close all ;

load('cal101/caltech101_Silhouettes_Mfile/cal101Silhouettes50.mat');

test3 = zeros([17342, 35, 35]);
test2 = reshape(cal101SilhouettesMaskEdge, [17342, 50, 50]);
for i = 1:17342
    test3(i,:,:) = imresize (squeeze(test2(i,:,:)), [35, 35]);
end
%test3 = imresize(test2, [35, 35]);
% test3 = reshape(cal101SilhouettesEdge(1, :), [28, 28]);
% test4 = imread('./result/thinning_result/IMG_0012.png');
% test5 = imresize(test4, [50, 50]);
% test2 = imresize(test4, [35, 35]);% testpic = imread('./input/1.jpg');
% testpic = imresize(testpic, [125, 177]);
figure(1)
imshow(squeeze(test2(1,:,:)));
disp(size(test3(1, :, :)));
tmp = test2(1, :, :);
%disp(test2(50,:, :))
figure(2)
imshow(squeeze(test3(1,:,:)));
figure(3)
imshow(reshape(cal101SilhouettesEdge(1,:), [28, 28]))