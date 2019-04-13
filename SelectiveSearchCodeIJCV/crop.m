function [result ,top ,down, left, right] = crop(img)
% img = imread(img); 
height = size(img,1);
width = size(img,2);
% isOne = 1;
% left = 0;
% right = 0;
% top = 0;
% down = 0;
flag = 0;
%% left
for i = 1:width
    for j = 1:height
        if img(j,i)==1
            left = i;
            flag = 1;
            break;
        end
        
    end
    if flag == 1;
            break;
    end
end
flag = 0;
%% right
for i = width:-1:1
    for j = 1:height
        if img(j,i)==1
            right = i;
            flag = 1;
            break;
        end
         
    end
    if flag == 1;
            break;
    end
end
flag = 0;
%% top
for i = 1:height
    for j = 1:width
        if img(i,j)==1
            top = i;
            flag =1;
            break;
        end
         
    end
    if flag == 1;
            break;
    end
end
flag = 0;
%% down
for i = height:-1:1
    for j = 1:width
        if img(i,j)==1
            down = i;
            flag = 1;
            break;
        end
         
    end
    if flag == 1;
            break;
    end
end

result = img(top:down,left:right);
% imshow(result);
