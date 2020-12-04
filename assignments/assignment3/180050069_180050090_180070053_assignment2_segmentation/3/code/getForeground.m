function [foreground,I_fore, I_back] = getForeground(edges, I)
    I_fore = I;
    I_back = I;
    % apply imfill
    [r,c] = size(edges);
    cr = floor(r/2);
    cc = floor(c/2);
    in = [cr,cc];
    foreground = imfill(logical(edges),[in(:)], 4);
    
    window_size = 18;
    for i = 1:1
        foreground = medfilt2(foreground, [window_size,window_size]);
    end
    
    window_size = 5;
    for i = 1:4
        foreground = medfilt2(foreground, [window_size,window_size]);
    end
    
    
    % reverse time
    temp = ~foreground;
    [r,c] = size(foreground);
    fg = zeros(r,c);
    fg(temp) = 1;
    window_size = 3;
    h = 1/window_size*ones(window_size,1);
    H = h*h';
    for iter = 1:1
        fg = filter2(H,fg);
        fg(fg > 0) = 1;
    end
    
    
    filter = ~(fg == 0);
    filter = ~bwareafilt(filter, 1);
    meanR = I(:,:,1);
    meanG = I(:,:,2);
    meanB = I(:,:,3);
    meanR(filter) = 0;
    meanG(filter) = 0;
    meanB(filter) = 0;
    I_fore(:,:,1) = meanR;
    I_fore(:,:,2) = meanG;
    I_fore(:,:,3) = meanB;
    
    filter = ~filter;
    meanR = I(:,:,1);
    meanG = I(:,:,2);
    meanB = I(:,:,3);
    meanR(filter) = 0;
    meanG(filter) = 0;
    meanB(filter) = 0;
    I_back(:,:,1) = meanR;
    I_back(:,:,2) = meanG;
    I_back(:,:,3) = meanB;
    foreground = filter;
end

