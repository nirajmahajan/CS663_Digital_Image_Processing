% Function to calculate the new intensity
function Intensity=myBilateralFiltering(I, window, sigma_s, sigma_i)
    [rows cols]=size(window);
    weighted_sum=0;
    nmfac=0; %normalizing factor
    for i=1:rows
        for j=1:cols
            coeff_i=exp(-(window(i,j)-I)^2/(2*sigma_i^2));
            coeff_s=exp(-((i-(rows+1)/2)^2+(j-(cols+1)/2)^2)/(2*sigma_s^2));
            weight=coeff_i*coeff_s;
            nmfac=nmfac+weight;
            weighted_sum=weighted_sum+weight*window(i,j);
        end
    end
    Intensity=weighted_sum/nmfac;
end