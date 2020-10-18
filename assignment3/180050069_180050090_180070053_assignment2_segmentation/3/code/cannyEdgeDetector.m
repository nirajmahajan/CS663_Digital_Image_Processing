function [Edges] = cannyEdgeDetector(Im, hi, lo, gaussian_sigma)
    % obtain the mean subtracted image
    meanR = Im(:,:,1);
    meanG = Im(:,:,2);
    meanB = Im(:,:,3);
    meanR = mean(meanR(:));
    meanG = mean(meanG(:));
    meanB = mean(meanB(:));
    I(:,:,1) = Im(:,:,1) - meanR;
    I(:,:,2) = Im(:,:,2) - meanG;
    I(:,:,3) = Im(:,:,3) - meanB;


    I = rgb2gray(I);
%     I = I(:,:,3);
    [r,c] = size(I);
    
    % apply gaussian filter
    I = imgaussfilt(I, gaussian_sigma);
    
    % get directional gradients
    [Gx, Gy] = imgradientxy(I);


    % compute the gradient magnitude, and thetas
    G = sqrt(power(Gx,2) + power(Gy,2));
    G = G / max(G(:));
    theta = atan2(Gy, Gx)*180/pi;
    
    % at the end, we want to round theta to nearest multiple of 45
    % we first add 22.5 to all angles and scale everything down by 45
    theta(theta < 0) = theta(theta < 0) + 360;
    theta = theta + 22.5;
    theta(theta >= 360) = theta(theta >= 360) - 360;
    % if greater than 180, subtract by 180 :)
    theta(theta >= 180) = theta(theta >= 180) - 180;
    theta = 45*round(theta/45);
    
%     Non maximal Suppression
%     for iter = 1:100
%         for ri = 2:r-1
%             for ci = 2:c-1
%                 dx = sign(cosd(theta(ri,ci)));
%                 dy = sign(sind(theta(ri,ci)));
%                 
%                 if ((G(ri,ci) < G(ri+dy, ci+dx)) || (G(ri,ci) < G(ri-dy, ci-dx)))
%                     G(ri,ci) = 0;
%                 end
%             end
%         end
%     end
%     figure, imshow(Gx/max(Gx(:)));
    
    % Hysteresis Thresholding
    Edges = zeros(r,c);
    Edges(G > hi) = 1;
    for iter = 1:1
        for ri = 2:r-1
            for ci = 2:c-1
                if((G(ri,ci) > lo) && (G(ri,ci) < hi))
                    Edges(ri,ci) = 0;
                    neighborhood = Edges(ri-1:ri+1,ci-1:ci+1);
                    if (sum(neighborhood(:)) > 0)
                        Edges(ri,ci) = 1;
                    end
                end
            end
        end
    end
    
    Edges = uint8(Edges*255);
    
    
end

