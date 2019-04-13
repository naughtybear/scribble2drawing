% Stentiford Thinning Algorithm

% Developed by mohanpalaniyappan
% Amrita E-Learning Research Lab
% mohanpalani82@gmail.com
% Reference
% IMAGE PROCESSING TECHNIQUES FOR MACHINE VISION
% Alberto Martin and Sabri Tosunoglu

clc
close all
clear all
% Read image from File
kid_file = dir(['kid_1/' '*.jpg']) ;
len = length(kid_file) ;
for x = 1 : len
    img = imread(['kid_1/' kid_file(x).name]) ;
%    img = imread('scribble2.jpg');
    img = rgb2gray(img);
%    img = imresize(img,[227,227]);
    
%     img = imread('IMG_0001.jpg');
     img = 255-img ;
    % resize the image
%     img = imresize(img,[128 128]);
    figure(3), imshow(img);
    % Template Type
    T1 = [0,1,1]';
    T2 = T1';
    T3 = [ 1,1,0]';
    T4 = T3';
    
    [row col plane] = size(img);
    imgBin = double(im2bw(img,0.51));
    ouImg = imgBin;
    S = [1 3 5 7];
    checKVal = 2;
    template = 1;
    outBinary  =zeros(row, col);
    con = 5;
    
    while (con < 15)
        for i = 2:row-1
            for j = 2:col-1
                window = imgBin(i-1:i+1,j-1:j+1);
                if (template == 1)
                    andOp1 = isequal(window(:,2),T1);
                    matchTemplate = andOp1;
                end
                if (template == 2)
                    andOp1 = isequal(window(2,:),T2);
                    matchTemplate = andOp1;
                end
                if (template == 3)
                    andOp1 = isequal(window(:,2),T3);
                    matchTemplate = andOp1;
                end
                if (template == 4)
                    andOp1 = isequal(window(2,:),T4);
                    matchTemplate = andOp1;
                end
                %         Connectivity number
                [Cn EndPoint] = connectivityFun(window);
                
                if imgBin(i,j)==1
                    if ((matchTemplate) == 1)
                        if Cn == 1
                            if (EndPoint ~= 0)
                                outBinary(i,j) = 1;
                            end
                        end
                    end
                end
            end
        end
        checKVal = sum(sum(outBinary));
        if (checKVal==0)
            con = con+1;
        end
        
        binVal = find(outBinary==1);
        imgBin(binVal) = 0;
        figure(2), imshow(outBinary,[]);
        outBinary  =zeros(row, col);
        template = template+1;
        
        %     Iteration
        if template == 5
            figure(1), imshow(imgBin,[]);title('OutPut Thinning Image');
            outBinary  =zeros(row, col);
            template = 1;
        end
    end
    close all;
    figure(3), imshow(img);title('Input Thinning Image');
    imgBin = 1 - imgBin ;
    figure(1), imshow(imgBin,[]);title('OutPut Thinning Image');
    if x < 10
        imwrite(imgBin,['IMG_000' num2str(x) '.png']) ;
    elseif (x >= 10) && (x < 100)
        imwrite(imgBin,['IMG_00' num2str(x) '.png']) ;
    else
        imwrite(imgBin,['IMG_0' num2str(x) '.png']) ;
    end
            
    
end