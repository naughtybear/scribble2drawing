clear;
load('..\caltech101_Silhouettes_Mfile\cal101Silhouettes28.mat');
% regionNum =  size(region,1); % region個數
% region{1,1} = imread('mix2.jpg');
% ori = imread('mix2.jpg');
D = cal101SilhouettesEdge';
param.lambda=0.15; % not more than 20 non-zeros coefficients
param.numThreads=-1; % number of processors/cores to use; the default choice is -1
                     % and uses all the cores of the machine
param.mode=2;

for i=1:17342
    alpha_f(i,2)=i;
end
% output_dir1=dir(['D:\chun\sketch\merge\3obj\*.jpg']);

for i= 1:100
    imgfile = fullfile('D:\chun\sketch\merge\5obj_scribble',[int2str(i) '.jpg']);
    imgfile = imread(imgfile);
    imgfile = double(reshape(imgfile,784,1));
    alpha=mexLasso(imgfile,D,param); % alpha = mexLasso(test image,dictionary,param)，只會列出非零alpha
    alpha_f(:,1)=full(alpha);
    finalResult = sortrows(alpha_f); %按係數由小到大排
    finalResult = flipud(finalResult); %把排行上下翻轉
    for j=1:150 %前150名的結果
        finalRank(i,j) = label(1,finalResult(j,2)); %class
    end
end
 


% for i = 1:1
%     region{i,1} = imresize(region{i,1},[28 28]);
%     region{i,1} = rgb2gray(region{i,1});
      %列出所有alpha
%     [result(i,1) result(i,3)] = max(alpha_f(i,:));
%     result(i,2) = i; %result = 係數 + regionId + objectId
% end

% finalResultId = finalResult(:,2:3); %finalResultId = regionId + objectId
% subplot(1,4,1);imshow(ori);
% subplot(1,4,2);imshow(reshape(cal101SilhouettesEdge(finalResult(1,2),:),[28 28]));
% subplot(1,4,3);imshow(reshape(cal101SilhouettesEdge(finalResult(2,2),:),[28 28]));
% subplot(1,4,4);imshow(reshape(cal101SilhouettesEdge(finalResult(3,2),:),[28 28]));