mixAmount = 4;
% a = [3,2,2,2]; %test
% b = [3,2,1,4]; %ground truth
load('similarClass5ObjScribble.mat');
load('list.mat');
test = finalRank;
groundTruth = list(:,8:12);
for k = 1:100
    tmpcorrect = 0;
    for i = 1:mixAmount %判斷是否被配對 ，1為有，0沒有 i:test,top i
            isPair = zeros(1,mixAmount);
            for j = 1 : 3 %j:gt                
                if (isPair(1,j) == 0)
                    if test(k,i) == groundTruth(k,j)
                        tmpcorrect = tmpcorrect+1;
                        isPair(k,j) =1;
                    end
                end
            end

    end
    correct(k,1) = tmpcorrect;
    accuracy(k,1) = correct(k,1)/3;
end
averageAccuracy = mean(accuracy);