function finalResultId  = sparsecodingCompare(region)
load('../caltech101_Silhouettes_Mfile/cal101Silhouettes28.mat');
regionNum =  size(region,1); % region個數
D = cal101SilhouettesEdge';

param.lambda=0.15; % not more than 20 non-zeros coefficients
param.numThreads=-1; % number of processors/cores to use; the default choice is -1
                     % and uses all the cores of the machine
param.mode=2; 
for i = 1:regionNum
    region{i,1} = imresize(region{i,1},[28 28]);
    region{i,1} = rgb2gray(region{i,1});
    region{i,1} = double(reshape(region{i,1},784,1));
    alpha=mexLasso(region{i,1},D,param); % alpha = mexLasso(test image,dictionary,param)，只會列出非零alpha
    alpha_f(i,:)=full(abs(alpha));  %列出所有alpha
    [result(i,1) result(i,3)] = max(alpha_f(i,:));
    result(i,2) = i; %result = 係數 + regionId + objectId
end
finalResult = sortrows(result); %按係數由小到大排
finalResult = flipud(finalResult); %把排行上下翻轉
finalResultId = [finalResult(:,2:3),finalResult(:,1)]; %finalResultId = regionId + objectId + coeff