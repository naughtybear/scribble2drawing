function result = thining(image)

image = 255-image;

thining = im2bw(gray,0.5);
% canny = edge(gray,'sobel');
result = bwmorph(thining,'thin');