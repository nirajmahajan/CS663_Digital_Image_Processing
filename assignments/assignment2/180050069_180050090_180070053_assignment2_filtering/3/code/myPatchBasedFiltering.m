function [O] = myPatchBasedFiltering(I, h_sigma, mask)
    % Define constants
    [r,c] = size(I);
    window_size = 25; 
    patch_size = 9;
    halfpatch = (patch_size-1)/2;
    halfwindow = (window_size-1)/2;
    padsize = halfwindow+halfpatch;
    global_logical_mask = ones(r,c);
    % Pad the array
    I = padarray(I,[padsize,padsize], 0 , 'both');
    global_logical_mask = padarray(global_logical_mask,[padsize,padsize], 0 , 'both') == 1;
    O = double(zeros(r,c));
    
    for ri = 1:r
        for ci = 1:c
            % Extract the target patch, ie, the ri, ci the pixel is about
            % to be updated
%             [ri,ci]
            tr_start = ri - halfpatch + padsize;
            tc_start = ci - halfpatch + padsize;
            tr_end = ri + halfpatch + padsize;
            tc_end = ci + halfpatch + padsize;
            logical_mask = global_logical_mask(tr_start:tr_end,tc_start:tc_end);
            logical_mask = logical_mask(:);
            target_patch = I(tr_start:tr_end,tc_start:tc_end);
            target_patch = target_patch(:);
            % overlay logical mask to extract pixels that are originaly in the image
            target_patch = target_patch(logical_mask);
            temp_mask = mask(:);
            temp_mask = temp_mask(logical_mask);
            % overlay gaussian mask
            target_patch = target_patch .*temp_mask;
            temp_mask = reshape(temp_mask, sum(logical_mask),1);
            target_patch = reshape(target_patch, sum(logical_mask),1);
%             size(target_patch)
            
            % generate the neighborhood limits
            nbr_start = (ri + padsize) - halfwindow;
            nbc_start = (ci + padsize) - halfwindow;
            nbr_end = (ri + padsize) + halfwindow;
            nbc_end = (ci + padsize) + halfwindow;
            neighborhood_patch = I(nbr_start:nbr_end,nbc_start:nbc_end);
            nbrs = neighborhood_patch(:);

            % generate the neighborhood limits with padding (so as to use im2 col later)
            nr_start = (ri + padsize) - padsize;
            nc_start = (ci + padsize) - padsize;
            nr_end = (ri + padsize) + padsize;
            nc_end = (ci + padsize) + padsize;
            neighborhood_patch = I(nr_start:nr_end,nc_start:nc_end);
            neighbour_cols = im2col(neighborhood_patch, [patch_size,patch_size]);
            neighbour_cols = neighbour_cols(logical_mask,:);
            neighbour_cols = neighbour_cols.*temp_mask;
%             mid = (window_size*window_size-1)/2;
%             neighbour_cols(:,mid) = [];
%             nbrs(mid) = [];
            
            weights = gaussianKernel(neighbour_cols, target_patch,h_sigma);
            
            weights = weights/ sum(weights(:));
            
            O(ri,ci) = sum(weights(:).* nbrs);
            
        end
    end
end

