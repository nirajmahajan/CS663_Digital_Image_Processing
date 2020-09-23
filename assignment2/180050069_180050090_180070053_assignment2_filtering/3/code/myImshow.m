function myImshow(image)
    myNumOfColors = 200;
    myColorScale = [ (0:1/(myNumOfColors-1):1)' , (0:1/(myNumOfColors-1):1)' , (0:1/(myNumOfColors-1):1)' ];
    imagesc (single (image)); % phantom is a popular test image
    colormap (myColorScale);
    colormap jet;
    daspect ([1 1 1]);
    axis tight;
    colorbar
    savefig('../images/isotropic_filter.png',name);
end

