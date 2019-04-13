function mix = cat2obj(sketch ,obj)
for i = 1:784
     if obj(1,i) == 1
            obj(1,i) = 255;
     end
end
% width = int8((size(sketch,1)+28)/2);
tmp = reshape(obj,[28 28]);
% tmp = imresize(tmp,[width width]);
blueObj =  cat(3,zeros(28,28,2),tmp);

% [x,y,z] = size(sketch);
% blueObj = imresize(blueObj,[x x]);
tmp = imresize(sketch,[28 28]);

mix = tmp + blueObj;
    
    