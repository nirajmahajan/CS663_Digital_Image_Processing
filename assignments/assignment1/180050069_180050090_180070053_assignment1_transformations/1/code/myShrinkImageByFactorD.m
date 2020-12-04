%% Function for generating image shrinking

function result=myShrinkImageByFactorD(image,d)
    [rows cols]=size(image);
    new_rows=floor(rows/d);
    new_cols=floor(cols/d);
    result=zeros(new_rows, new_cols);
    for i=1:new_rows
        for j=1:new_cols
            result(i,j)=image(d*(i-1)+1,d*(j-1)+1);
        end
    end
end