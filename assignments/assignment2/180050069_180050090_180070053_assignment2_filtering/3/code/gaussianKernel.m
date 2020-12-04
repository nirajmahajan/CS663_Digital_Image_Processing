function weights = gaussianKernel(columns, patch, h_sigma)
%GAUSSIANKERNEL Takes two patches and return the gaussian difference
%between the two.
    euclidean_distance = sum(power(columns - patch, 2),1);
%     max(-euclidean_distance/(2*h_sigma^2))
    weights = exp(-euclidean_distance/(2*h_sigma^2));
    
end

