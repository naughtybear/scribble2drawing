function finalResultId  = sparsecodingCompare(region,img_num)
    load('cal101/caltech101_Silhouettes_Mfile/cal101Silhouettes50.mat');
    regionNum =  size(region,1); % region個數
    %cal101SilhouettesMaskEdge = double(~cal101Silhouettes);
    D = cal101SilhouettesEdge';
    
    param.lambda=0.15; % not more than 20 non-zeros coefficients
    param.numThreads=-1; % number of processors/cores to use; the default choice is -1
                         % and uses all the cores of the machine
    param.mode=2; 
    disp(num2str(regionNum));
%    load(['./store_mat/image_' num2str(img_num) 'sparse.mat']); %% 讀入已經跑Sparse，如果是第一次跑要註解
    % mkdir(['result/Ranking/' num2str(img_num)]);
    tic;
    for i = 1:regionNum
         mkdir(['result/Ranking/' num2str(img_num) '/image_' num2str(i)]);
    %     %% 第一次跑Sparse不要註解，之後跑Sparse可以註解
         region{i,1} = imresize(region{i,1},[28, 28]);
         region{i,1} = rgb2gray(region{i,1});
         region{i,1} = double(reshape(region{i,1}, 784,1));
         alpha=mexLasso(region{i,1},D,param); % alpha = mexLasso(test image,dictionary,param)，只會列出非零alpha
         alpha_f(i,:)=full(abs(alpha));  %列出所有alpha
    toc;
    
        %% 不要註解
        result_f(i,:) = alpha_f(i,:)./max(alpha_f(i,:));
%         [result(i,1) result(i,3)] = max(result_f(i,:));
%         result(i,2) = i; %result = 係數 + regionId + objectId
        disp(num2str(i));
        
        a(1,:) = result_f(i,:);
        a(2,:) = 1 : 17342;
        a = a';
        a = sortrows(a);
        a = flipud(a);
        count = zeros(1,101);
        coef = 1;
        for j = 1 : 8
            imwrite(reshape(cal101SilhouettesEdge(a(j,2),:),[28 28]),['result/Ranking/' num2str(img_num) '/image_' num2str(i)  '/' num2str(j) '.png']);
            category = int32(label(a(j,2)));
            %disp(category/2);
            count(category/2) = count(category/2) + 1 * coef;
        end
        
        [tmp, most_category] = max(count);
        for j = 1 : 8
            most_category = int32(most_category);
            category = int32(label(a(j,2)))/2;
            %disp('hhhh');
            %disp(category/2);
            if category==most_category
                %disp('dada')
                result(i,1) = a(j,1);
                result(i,2) = i;
                result(i,3) = a(j,2);
                break;
            end
        end
        clear a
    end
    
    %% 第一次跑Sparse，不要註解
    save(['./store_mat/image_' num2str(img_num) 'sparse.mat'],'alpha_f');
    
    %% 
    finalResult = result;
    finalResultId = [finalResult(:,2:3),finalResult(:,1)]; %finalResultId = regionId + objectId + coeff