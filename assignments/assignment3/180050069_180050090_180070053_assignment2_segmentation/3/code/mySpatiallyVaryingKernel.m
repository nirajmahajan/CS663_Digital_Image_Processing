function [blurred] = mySpatiallyVaryingKernel(I, radii_matrix, foreground_mask, cutoff)
    Kernels = cell([cutoff+1,1]);
    Filtered = cell([cutoff+1,1]);
    for i = 0:cutoff
        Kernels{i+1} = getKernel(i, cutoff);
    end
   
    [r,c,~] = size(I);
   
   
    padsize = cutoff;
    padded = double(padarray(I, [padsize,padsize], 'replicate'));
    for coi = 0:cutoff
        Filtered{coi+1} = imfilter(padded, Kernels{cutoff+1});
        Filtered{coi+1} = Filtered{coi+1}(1+padsize:r+padsize,1+padsize:c+padsize,:);
    end
   
    blurred = Filtered{cutoff+1};
    
    for coi = 1:cutoff-1
        temp = Filtered{coi};
        mask = (radii_matrix == coi);
        blurred(mask) = temp(mask);
    end
    
    ImR = I(:,:,1);
    ImG = I(:,:,2);
    ImB = I(:,:,3);
    blurredR = blurred(:,:,1);
    blurredG = blurred(:,:,2);
    blurredB = blurred(:,:,3);
    blurredR(foreground_mask) = ImR(foreground_mask);
    blurredG(foreground_mask) = ImG(foreground_mask);
    blurredB(foreground_mask) = ImB(foreground_mask);
    blurred(:,:,1) = blurredR;
    blurred(:,:,2) = blurredG;
    blurred(:,:,3) = blurredB;
end

