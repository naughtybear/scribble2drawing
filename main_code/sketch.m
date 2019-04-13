function result = sketch(testimg,style)
close all;
% style = imread('D:\chun\sketch\SelectiveSearchCodeIJCV\be0700_p_01_03.jpg');
tic;
% style = imread('..\Paintings\van Gogh\van Gogh;1889;Starry Night;Museum of Modern Art, New York, NY, USA.jpg'); %要套用的style

% test= imread(testimg);
test = testimg;
thin = thining(test); %細線化
% imshow(thin);
[region, regionInfo] = selectiveSearch(thin);% selective Search
modifyregion = modifyRegion(region, regionInfo); %把region放到正中間
compareResult = sparsecodingCompare(modifyregion); % sparse coding
finalRegion = deleteOverlapRegion(compareResult, regionInfo);
figure;
% feature = featureExtraction(region);
% finalRegion = simComparision(feature);

load('..\caltech101_Silhouettes_Mfile\cal101Silhouettes28.mat');
for i=1:size(finalRegion,1)
    x = [regionInfo(finalRegion(i,1),2),regionInfo(finalRegion(i,1),4),regionInfo(finalRegion(i,1),4),regionInfo(finalRegion(i,1),2),regionInfo(finalRegion(i,1),2)];
    y = [regionInfo(finalRegion(i,1),3),regionInfo(finalRegion(i,1),3),regionInfo(finalRegion(i,1),1),regionInfo(finalRegion(i,1),1),regionInfo(finalRegion(i,1),3)];
    subplot(size(finalRegion,1),5,i*5-4);imshow(thin);hold on;plot(x,y,'r');
    subplot(size(finalRegion,1),5,i*5-3);imshow(modifyregion{finalRegion(i,1),1});
    subplot(size(finalRegion,1),5,i*5-2);imshow(reshape(cal101SilhouettesEdge(finalRegion(i,2),:),[28 28]));
    [class,pictureId] = findClassPictureId(finalRegion(i,2),label,eachLabelNumSum);
    simObj = imread(['..\101_ObjectCategories\' classnames{1,class} '\image_' num2str(sprintf ('%04d',pictureId)) '.jpg']);
    subplot(size(finalRegion,1),5,i*5-1);imshow(simObj);
    subplot(size(finalRegion,1),5,i*5);imshow(cat2obj(modifyregion{finalRegion(i,1),1} ,cal101SilhouettesEdge(finalRegion(i,2),:)));
    hold off;
end
[bestR,backgroundId] = composition(region,regionInfo,finalRegion); %最佳化

synthesis = pasteObj(region,regionInfo,finalRegion,bestR,backgroundId);
result = neural_style(synthesis,style);
figure;hold on;
subplot(2,2,1);imshow(test);
subplot(2,2,2);imshow(synthesis);
subplot(2,2,3);imshow(style);
subplot(2,2,4);imshow(result);hold off;
% imwrite(tmp,'thintmp.jpg');

toc;
