function [hd,mindst] = hausdorff(L1,L2)
count = 0;
[r1,c1] = size(L1);
[r2,c2] = size(L2);
s1 = [r1,c1];
s2 = [r2,c2];
if min(s1)~=min(s2)
    error('THE COORDINATE LISTS DIFFER IN NUMBER OF DIMENSIONS!!!')
end
% FIX ORIENTATION TO MAKE SMALLER MATRIX DIM COLUMNS AND THUS SPATIAL DIMS
if min(s1)==min(s2) && r1<c1
    L1 = L1';
    [r1,c1] = size(L1);
end
if min(s1)==min(s2) && r2<c2
    L2 = L2';
    [r2,c2] = size(L2);
end
str = ' ';
% TAKE THE SHORTER COORDINATE LIST FOR THE LIST OF MINIMA
if r1>r2
    mindst = zeros(1,r2);
    for r = 1:r2
        if ~strcmp(str,[num2str(floor((r/r2)*100)) '%'])
            clc
            str = [num2str(floor((r/r2)*100)) '%'];
            disp(str)
        end
        dst = zeros(r1,1);
        for c = 1:c2
            dst = dst + (L1(:,c)-repmat(L2(r,c),[r1 1])).^2;
        end
        mindst(r) = min(sqrt(dst));
    end
else mindst = zeros(1,r1);
    count = 0;
    for r = 1:r1
        if ~strcmp(str,[num2str(floor((r/r1)*100)) '%'])
            clc
            str = [num2str(floor((r/r1)*100)) '%'];
            disp(str)
        end
        dst = zeros(r2,1);
        for c = 1:c1
            dst = dst + (L2(:,c)-repmat(L1(r,c),[r2 1])).^2;
        end
        mindst(r) = min(sqrt(dst));
        count = count + 1;
    end
end
hd = sum(mindst);
hd = hd/count;
clc
disp(['Hausdorff distance is ' num2str(hd)])
disp(['Mean of minima is ' num2str(mean(mindst))])
disp(['STD of minima is ' num2str(std(mindst))])