function workOnImage(I, name, fig, h_sigma, mask)
    % Corrupts, Filters and displays the input image
    
    corrupted = corrupt(I);
    filtered = myPatchBasedFiltering(corrupted, h_sigma, mask);
    
    f = figure(fig);
    myImshow(uint8(I));
    title('Original')
    saveas(f, sprintf('../images/%s_original.png',name));
    pause(0.2);
    savefig(sprintf('../images/%s_original.fig',name));
    
    f = figure(fig+1);
    myImshow(uint8(corrupted));
    title('Corrupted')
    saveas(f, sprintf('../images/%s_corrupted.png',name));
    pause(0.2);
    savefig(sprintf('../images/%s_corrupted.fig',name));
    
    f = figure(fig+2);
    myImshow(uint8(filtered));
    title('Filtered');
    saveas(f, sprintf('../images/%s_filtered.png',name));
    pause(0.2);
    savefig(sprintf('../images/%s_filtered.fig',name));
    
    
    fprintf('Optimal Value for %s = %f\n',name,h_sigma);
    rmsd_opt = rmsd(I,filtered);
    fprintf(sprintf('RMSD at optimal sigma = %f\n',rmsd_opt));
    
%     filtered_up = myPatchBasedFiltering(corrupted, h_sigma*1.1, mask);
%     rmsd_up = rmsd(I,filtered_up);
%     fprintf(sprintf('RMSD at 1.1 * optimal sigma = %f\n',rmsd_up));
%     filtered_down = myPatchBasedFiltering(corrupted, h_sigma*0.9, mask);
%     rmsd_down = rmsd(I,filtered_down);
%     fprintf(sprintf('RMSD at 0.9 * optimal sigma = %f\n',rmsd_down));
end

