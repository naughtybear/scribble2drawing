function [class,pictureId] = findClassPictureId(pictureId,label,eachLabelNumSum)
    class = label(1,pictureId);
    if class > 1
        pictureId = pictureId-eachLabelNumSum(1,class-1);
    end
   
