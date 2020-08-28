%% Function for image enlargement

function result=myBicubicInterpolation(image, x, y, A_inv, der_x, der_y, der_xy)
    X=[image(1,1), image(2,1), image(1,2), image(2,2), der_x(1,1), der_x(2,1),...
        der_x(1,2), der_x(2,2), der_y(1,1), der_y(2,1), der_y(1,2),... 
        der_y(2,2), der_xy(1,1), der_xy(2,1), der_xy(1,2), der_xy(2,2)]';
    coeffs=A_inv*X;
    result=0;
    it=1;
    for j=0:3
        for i=0:3
           result=result+coeffs(it)*(x^i)*(y^j);
           it=it+1;
        end
    end
end