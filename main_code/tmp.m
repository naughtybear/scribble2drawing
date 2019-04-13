% clc
% clear all
% tic;
% 
% %need to change
% % matpath = 'D:\chun\sketch\caltech101_Silhouettes_Mfile';
% % matname = 'caltech101_silhouettes_cannyAll_28.mat';
% imgpath = '..\RandomizedCaltech101\';
% maskpath = '..\RandomizedCaltech101Masks\';
% cropimgpath = '..\RandomizedCaltech101Crop\';
% cropmaskpath = '..\RandomizedCaltech101MasksCrop\';
% load('..\caltech101_Silhouettes_Mfile\cal101Silhouettes28.mat');
% % load (fullfile(matpath , matname));
% % num = size(edge_train_28 , 1);
% 
% % if isdir(cropimgpath) == 0, mkdir(cropimgpath);    end
% % if isdir(cropmaskpath) == 0, mkdir(cropmaskpath);    end
% % % num = max(label);
% % for i = 1:101
% %     mkdir (fullfile (cropimgpath , classnames{1,i}));
% %     mkdir (fullfile (cropmaskpath , classnames{1,i}));
% % end
% 
% 
% for i =3:101
%     for j = 1:eachLabelNum(1,i)
%         cal101mask=dir([maskpath,classnames{1, i},'\*.png']); 
%         cal101=dir([imgpath,classnames{1, i},'\*.jpg']); 
%         tmp1 = imread([maskpath,classnames{1, i},'\',cal101mask(j).name]);
%         [result ,top ,down, left, right] = crop(tmp1);
%         sv_name = cal101(j).name;
%         sv_path1 = [cropmaskpath ,classnames{1, i},'\', cal101(j).name];
%         imwrite (result , sv_path1);
%         
%         tmp2 = imread([imgpath,classnames{1, i},'\',cal101(j).name]);
%         sv_path2 = [cropimgpath ,classnames{1, i},'\', cal101(j).name];
%         imwrite (tmp2(top:down,left:right,:) , sv_path2);
%         
%     end
% end
% 
% fid =fopen('list.txt');
scribble = imread('..\scribble3.jpg');
scribble = rgb2gray(scribble);
for i = 3:3
% a = fgetl(fid);
output_dir1=dir(['D:\chun\sketch\merge\' int2str(i) 'obj\*.jpg']);
% output_dir2=dir(['D:\chun\sketch\101_ObjectCategories\' a  '2\*.mat']);
for j = 1:100
    imgfile = fullfile('D:',['chun\sketch\merge\' int2str(i) 'obj'],output_dir1(j).name);
    %         annotation_file = fullfile('D:',['chun\sketch\101_ObjectCategories_Annotations\' a '\'],output_dir2(j).name);
    img = imread(imgfile);
    merge = img + scribble;
%     param.lambda=0.15; % not more than 20 non-zeros coefficients
%     param.numThreads=-1; % number of processors/cores to use; the default choice is -1
%                          % and uses all the cores of the machine
%     param.mode=2; 
%     img = double(reshape(img,784,1));
%     alpha=mexLasso(img,D,param); % alpha = mexLasso(test image,dictionary,param)，只會列出非零alpha
%     alpha_f(j,:)=full(alpha);  %列出所有alpha
%     [result(i,1) result(i,3)] = max(alpha_f(i,:));
%     result(i,2) = i; %result = 係數 + regionId + objectId

% finalResult = sortrows(result); %按係數由小到大排
% finalResult = flipud(finalResult); %把排行上下翻轉
% finalResultId = finalResult(:,2:3); %finalResultId = regionId + objectId
%         sv_name = sprintf ('%04d.jpg' , cnt);
sv_name = output_dir1(j).name;
% count = count+1;
sv_path = fullfile (['D:\chun\sketch\merge\' int2str(i) 'obj_scribble3']  , sv_name);
imwrite (merge , sv_path);
%         cnt= cnt + 1;
end
end

% for i=1:101
%     eachLabelNumSum(1,i+101) = eachLabelNumSum(1,i)+8671;
% end
% save cal101Silhouettes28 cal101Silhouettes cal101SilhouettesEdge classnames eachLabelNum
% 
% x = [regionInfo(finalRegion(i,1),2),regionInfo(finalRegion(i,1),4),regionInfo(finalRegion(i,1),4),regionInfo(finalRegion(i,1),2),regionInfo(finalRegion(i,1),2)];
% y = [regionInfo(finalRegion(i,1),3),regionInfo(finalRegion(i,1),3),regionInfo(finalRegion(i,1),1),regionInfo(finalRegion(i,1),1),regionInfo(finalRegion(i,1),3)];
% subplot(size(finalRegion,1),4,i*4-3);imshow(thin);hold on;plot(x,y,'r');

for i = 1:784
    if pic(1,i) == 1
        pic(1,i) = 255;
    end
end