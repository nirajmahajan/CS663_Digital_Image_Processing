function workOnImage(I, name, fig, h_sigma, mask)
    % Corrupts, Filters and displays the input image
    
    corrupted = corrupt(I);
    filtered = myPatchBasedFiltering(I, h_sigma, mask);
    figure(fig);
    title(sprintf('Analysis of %s',name));
    subplot(1,3,1);
    imshow(uint8(I));
    title('Orignal')
    subplot(1,3,2);
    imshow(uint8(corrupted));
    title('Corrupted')
    subplot(1,3,3);
    imshow(uint8(filtered));
    title('Filtered');
    savefig(sprintf('../images/%s.png',name));
end

