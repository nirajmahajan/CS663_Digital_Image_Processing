function myForegroundMask(img)
    A = imread(img); 
    mask = arrayfun(@(x) (x>10),A);
    [rows,columns]=size(A);
    masked = A;
    for i = 1:rows
        for j = 1:columns
            if mask(i,j)==0
                masked(i,j) = 0;
            end
        end
    end
    
%     save(['../images/a/a7.mat'],'masked');
    subplot(1,3,1), imshow(A), title('original')
    subplot(1,3,2), imshow(mask), title('mask')
    subplot(1,3,3), imshow(masked), title('masked')
    temp = split(img,'/');
    filename = temp(3);
    filename = 'masked_'+string(filename);
    loc = fullfile('../data/',filename);
    imwrite(masked,loc);
end
