load('list.mat');%100*101
load('..\caltech101_Silhouettes_Mfile\cal101Silhouettes28.mat');

for i = 1:100
    class1 =list(i,8);
    class2 = list(i,9);
    class3 = list(i,10);
    class4 = list(i,11);
    class5 = list(i,12);
    image1 = imread(fullfile('..\caltech101_Silhouettes_image\' ,sprintf ('%03d',class1), [num2str(sprintf ('%04d',eachLabelNumSum(1,class1))) '.jpg']));
    image2 = imread(fullfile('..\caltech101_Silhouettes_image\' ,sprintf ('%03d',class2), [num2str(sprintf ('%04d',eachLabelNumSum(1,class2))) '.jpg']));
    image3 = imread(fullfile('..\caltech101_Silhouettes_image\' ,sprintf ('%03d',class3), [num2str(sprintf ('%04d',eachLabelNumSum(1,class3))) '.jpg']));
    image4 = imread(fullfile('..\caltech101_Silhouettes_image\' ,sprintf ('%03d',class4), [num2str(sprintf ('%04d',eachLabelNumSum(1,class4))) '.jpg']));
    image5 = imread(fullfile('..\caltech101_Silhouettes_image\' ,sprintf ('%03d',class5), [num2str(sprintf ('%04d',eachLabelNumSum(1,class5))) '.jpg']));
    merge5 = image1+image2+image3+image4+image5;
    mergepath = 'D:\chun\sketch\merge\5obj';
    sv_path = fullfile (mergepath , [int2str(i) '.jpg'] );
    imwrite (merge5 , sv_path);
end