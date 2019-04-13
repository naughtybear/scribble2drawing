function finalResultId = deepCompare(region,img_num)
load('..\caltech101_Silhouettes_Mfile\cal101Silhouettes50.mat');
regionNum =  size(region,1); % region個數
prob_all = zeros(17342,1);
% mkdir(['result\Ranking\deep\' num2str(img_num)]);
for i = 1 : regionNum
%     mkdir(['result\Ranking\deep\' num2str(img_num) '\image_' num2str(i)]);
    for j = 1 : 26
        load(['deep/test_img/image_' num2str(img_num) '/predict' num2str(i) '/predictor' num2str(j) '.mat']);
        prob_all(667*(j-1)+1:667*j,1) = prob(:,2);
    end
    
    prob_f(i,:) = prob_all;
    [result(i,1) result(i,3)] = max(prob_f(i,:));
    result(i,2) = i; %result = 係數 + regionId + objectId
    disp(num2str(i));
%     a(1,:) = prob_f(i,:);
%     a(2,:) = 1 : 17342;
%     a = a';
%     a = sortrows(a);
%     a = flipud(a);
%     for j = 1 : 8
%         imwrite(reshape(cal101SilhouettesMaskEdge(a(j,2),:),[50 50]),['result\Ranking\deep\' num2str(img_num) '\image_' num2str(i)  '\' num2str(j) '.png']);
%     end
%     clear a
end
% finalResult = sortrows(result); %按係數由小到大排
% finalResult = flipud(finalResult); %把排行上下翻轉
finalResult = result;

finalResultId = [finalResult(:,2:3),finalResult(:,1)]; %finalResultId = regionId + objectId + coeff