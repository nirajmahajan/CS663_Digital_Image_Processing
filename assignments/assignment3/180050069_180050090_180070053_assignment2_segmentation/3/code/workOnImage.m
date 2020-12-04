function workOnImage(I, name, fig, hi, lo, gaussian_sigma, cutoff)
    
    edges = cannyEdgeDetector(I, hi, lo, gaussian_sigma);
    [foreground, I_fore, I_back] = getForeground(edges, I);
    fig_base = (fig-1)*11;
    
    f = figure(fig_base+1);
    imshow(I);
    title('Original Image')
    saveas(f, sprintf('../images/%s_original.png',name));
    pause(0.2);
    savefig(sprintf('../images/figs/%s_original.fig',name));
    
    f = figure(fig_base+2);
    imshow(foreground);
    title('Foreground Mask')
    saveas(f, sprintf('../images/%s_mask.png',name));
    pause(0.2);
    savefig(sprintf('../images/figs/%s_mask.fig',name));
    
    f = figure(fig_base+3);
    imshow(I_fore);
    title('Foreground Image')
    saveas(f, sprintf('../images/%s_foreground.png',name));
    pause(0.2);
    savefig(sprintf('../images/figs/%s_foreground.fig',name));
    
    f = figure(fig_base+4);
    imshow(I_back);
    title('Background Image')
    saveas(f, sprintf('../images/%s_background.png',name));
    pause(0.2);
    savefig(sprintf('../images/figs/%s_background.fig',name));
    
    radii = getRadiusMask(foreground, cutoff);
    f = figure(fig_base+5);
    myImshow(radii, 0);
    title('Spatially Varying Radii');
    saveas(f, sprintf('../images/%s_radii.png',name));
    pause(0.2);
    savefig(sprintf('../images/figs/%s_radii.fig',name));

    % display blurring kernel
    for i = 1:5
        f = figure(fig_base+5 + i);
        scale = 0.2 * i;
        k = getKernel(round(cutoff*scale), cutoff);
        imshow(k/max(k(:)));
        title(sprintf('%.02f*%c', scale,945));
        saveas(f, sprintf('../images/%s_kernel_%.02f.png',name,scale));
        pause(0.2);
        savefig(sprintf('../images/figs/%s_kernel_%.02f.fig',name,scale));
    end
    
    blurred = mySpatiallyVaryingKernel(I, radii, foreground, cutoff);
    f = figure(fig_base+11);
    imshow(blurred/max(blurred(:)));
    title('Spatially Blurred Image');
    saveas(f, sprintf('../images/%s_spatially_blurred.png',name));
    pause(0.2);
    savefig(sprintf('../images/figs/%s_spatially_blurred.fig',name));

    
end