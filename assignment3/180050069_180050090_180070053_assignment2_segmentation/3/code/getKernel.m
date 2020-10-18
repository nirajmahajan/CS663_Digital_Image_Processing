function [K] = getKernel(radius, cutoff)
    size = round(2*(radius-1) + 1);
    Kernel = zeros(size,size);
    for ri = 1:size
        for ci = 1:size
            rad_temp = sqrt((ri-radius)^2 + (ci-radius)^2);
            if rad_temp <= radius
                Kernel(ri,ci) = 1;
            end
        end
    end
    
    Kernel = Kernel / sum(Kernel(:));
    
    kernelsize = round(2*(cutoff-1) + 3);
    centre = cutoff + 1;
    K = zeros(kernelsize, kernelsize);
    K(centre-radius+1:centre+radius-1,centre-radius+1:centre+radius-1) = Kernel;
end

