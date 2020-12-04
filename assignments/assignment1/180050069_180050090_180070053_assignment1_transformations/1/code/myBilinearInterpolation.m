%% Function for image enlargement

function result=myBilinearInterpolation(image, x, y, A)
    result=(image(1,1)*(4-x)*(3-y)+image(2,1)*(x-1)*(3-y)...
                   +image(2,2)*(x-1)*(y-1)+image(1,2)*(4-x)*(y-1))/A;
end