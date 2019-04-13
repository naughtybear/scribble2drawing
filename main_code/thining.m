function result = thining(image)
% channel = size(image,3);
% if channel == 1
%     tmp = cat(3,image,image);
%     image = cat(3,tmp,image);
% end
% image = 255-image;
% resize = imresize(uint8(image),[115 164]);
% gray = rgb2gray(resize);
% thining = im2bw(gray,0.5);
% % canny = edge(gray,'sobel');
% result = bwmorph(thining,'thin');
image = 255-image;
% resize = imresize(uint8(image),[115 164]);
result = im2bw(image,0.5);
% result = bwmorph(thining,'thin');