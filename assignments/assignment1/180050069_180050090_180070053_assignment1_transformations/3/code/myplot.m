function myplot(in_path,out_path, fn)
    img = imread(in_path);
    
    if size(img, 3) ~= 1
        img = rgb2gray(img);
    end


    global_he = histogram_equalization(img);
    better_he = half_histogram_equalization(img);

    figure(fn)
    subplot(2,2,[1,2]);
    imshow(img);
    title('Orignal Image');
    colorbar;

    subplot(2,2,3);
    imshow(global_he);
    title('Simple Histogram Equalization');
    colorbar;
    
    subplot(2,2,4);
    imshow(better_he);
    title('Median Intensity HE');
    colorbar;

    saveas(fn,out_path)
end

