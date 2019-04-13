function feature = featureExtraction(region)
 regionNum =  size(region,1); % region個數
 
 
 %%% sparse coding feature
%*************************************************************************************************************************************
load('D:\chun\sketch\sparseDic.mat');

addpath (genpath('spams-matlab-v2.5-svn2014-07-04'));


param.lambda=0.15; % not more than 20 non-zeros coefficients
param.numThreads=-1; % number of processors/cores to use; the default choice is -1
                     % and uses all the cores of the machine
param.mode=2;        % penalized formulation

for i = 1:regionNum
    region{i,1} = rgb2gray(region{i,1});
    region{i,1} = imresize(region{i,1},[28 28]);
    region{i,1} = double(reshape(region{i,1},784,1));
    alpha=mexLasso(region{i,1},D,param); % alpha = mexLasso(test image,dictionary,param)，只會列出非零alpha
    alpha_f(i,:)=full(alpha);  %列出所有alpha
 
end
%*****************************************************************************************************************************
feature = alpha_f;
