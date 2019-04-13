function finalResultId  = SparseDeep(region,img_num)
load('..\caltech101_Silhouettes_Mfile\cal101Silhouettes50.mat');
regionNum =  size(region,1); % region�Ӽ�
D = cal101SilhouettesMaskEdge';

param.lambda=0.15; % not more than 20 non-zeros coefficients
param.numThreads=-1; % number of processors/cores to use; the default choice is -1
                     % and uses all the cores of the machine
param.mode=2; 
disp(num2str(regionNum));
load(['image_' num2str(img_num) 'sparse.mat']);%% Ū�J�w�g�]Sparse�A�p�G�O�Ĥ@���]�n����
mkdir(['result\Ranking\SparseDeep\' num2str(img_num)]);
for i = 1:regionNum
    mkdir(['result\Ranking\SparseDeep\' num2str(img_num) '\image_' num2str(i)]);
        %% �Ĥ@���]Sparse�A����]Sparse�i�H����
%     %% sparse
%     region{i,1} = imresize(region{i,1},[50 50]);
%     region{i,1} = rgb2gray(region{i,1});
%     region{i,1} = double(reshape(region{i,1},2500,1));
%     alpha=mexLasso(region{i,1},D,param); % alpha = mexLasso(test image,dictionary,param)�A�u�|�C�X�D�salpha
%     alpha_f(i,:)=full(abs(alpha));  %�C�X�Ҧ�alpha
    %% ���n����
    %% deep
    for j = 1 : 26
        load(['deep/test_img/image_' num2str(img_num) '/predict' num2str(i) '/predictor' num2str(j) '.mat']);
        prob_all(667*(j-1)+1:667*j,1) = prob(:,2);
    end
    prob_f(i,:) = prob_all;
    
    %% combine sparse�Mdeep
    result_f(i,:) = ((alpha_f(i,:)./sum(alpha_f(i,:))) + prob_f(i,:))/2;
    [result(i,1) result(i,3)] = max(result_f(i,:));
    result(i,2) = i; %result = �Y�� + regionId + objectId
    disp(num2str(i));
%     a(1,:) = result_f(i,:);
%     a(2,:) = 1 : 17342;
%     a = a';
%     a = sortrows(a);
%     a = flipud(a);
%     for j = 1 : 8
%         imwrite(reshape(cal101SilhouettesMaskEdge(a(j,2),:),[50 50]),['result\Ranking\SparseDeep\' num2str(img_num) '\image_' num2str(i)  '\' num2str(j) '.png']);
%     end
%     clear a
end
%% �Ĥ@���]Sparse�A���n����
% save(['image_' num2str(img_num) 'sparse.mat'],'alpha_f');
%%
finalResult = result;
finalResultId = [finalResult(:,2:3),finalResult(:,1)]; %finalResultId = regionId + objectId + coeff