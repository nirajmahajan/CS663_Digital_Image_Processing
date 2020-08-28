%% Function for image enlargement

function result=myNearestNeighborInterpolation(image, x, y)
    x=(x+2)/3;
    y=(y+1)/2;
    min_dist=1000;
    dist=0;
    for i=1:2
        for j=1:2
            dist=sqrt((x-i)^2+(y-j)^2);
            if(dist<min_dist)
                result=image(i,j);
            end
        end
    end
end