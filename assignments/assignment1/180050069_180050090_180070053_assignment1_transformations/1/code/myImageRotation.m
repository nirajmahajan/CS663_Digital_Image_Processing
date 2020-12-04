%% Function for image rotation

function result=myImageRotation(image, x, y)
    x1=floor(x);
    y1=floor(y);
    x2=x1+1;
    y2=y1+1;
    result=(image(1,1)*(x2-x)*(y2-y)+image(2,1)*(x2-x)*(y-y1)...
                   +image(2,2)*(x-x1)*(y-y1)+image(1,2)*(x-x1)*(y2-y));
end