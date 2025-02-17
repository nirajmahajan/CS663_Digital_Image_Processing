function [x,y, impulse, visibility, log_fft] = getTranslation(I1,I2)
    [r1,c1] = size(I1);
    [r2,c2] = size(I2);
    assert(r1 == r2);
    assert(c1 == c2);
    
    % calculate FFTs
    F1 = fftshift(fft2(I1));
    F2 = fftshift(fft2(I2));
    
    % compute the cross-power spectrum, and the corresponding impulse
    Prod = (F1.*conj(F2))./(abs(F1.*F2) + 1e-50);
    log_fft = log(1+abs(Prod));
    prod = abs(ifft2(ifftshift(Prod)));
    impulse = prod/max(prod(:));
    
    % interpret the translation from the obtained impulse
    [~, linearIndexesOfMaxes] = max(prod(:));
    y = rem(linearIndexesOfMaxes-1,300);
    x = (linearIndexesOfMaxes-y-1)/300;
    startx = x;
    starty = y;
    if (x > idivide(int32(c1),2))
       x = x - c1;
    end
    if (y > idivide(int32(r1),2))
       y = y - r1;
    end
    
    % create a yellow circle around the impulse for better visibility
    visibility = cat(3,impulse,impulse,impulse);
    visibility = visibility/max(visibility(:));
    circle = zeros(20,20,3);
    for i = 1:20
        for j = 1:20
            if (abs((i-10)^2 + (j-10)^2 - 81) < 20)
                circle(i,j,:) = [1,1,0];
            end
        end
    end
    visibility(starty-9:starty+10, startx-9:startx+10,:) = visibility(starty-9:starty+10, startx-9:startx+10,:) + circle;
end

