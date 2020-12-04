% Function to calculate the corner-ness measure
function [C A]=myHarrisCornerDetector(w, der_x, der_y, k)
    A=zeros(2,2);
    for l=1:5
        for m=1:5
            A=A+w(l,m).*[der_x(l,m)^2, der_x(l,m)*der_y(l,m); der_x(l,m)*der_y(l,m), der_y(l,m)^2];
        end
    end
    C=det(A)-k*trace(A)^2;
   
end