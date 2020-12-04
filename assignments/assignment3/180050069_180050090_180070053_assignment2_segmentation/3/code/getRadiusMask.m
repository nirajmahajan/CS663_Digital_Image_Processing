function [radii] = getRadiusMask(foreground, cutoff)
    [r,c] = size(foreground);
    radii = zeros(r,c) + cutoff;
    n_foregrounds = sum(foreground(:));
    foreground_coordinates = zeros(n_foregrounds, 2);
    
    
    
    % get foreground coordinates
    [rfc,cfc] = find(foreground);
    foreground_coordinates(:,1) = rfc;
    foreground_coordinates(:,2) = cfc;
            
    
    % isolate a rectangle around our image
    rmin = min(foreground_coordinates(:,1));
    cmin = min(foreground_coordinates(:,2));
    rmax = max(foreground_coordinates(:,1));
    cmax = max(foreground_coordinates(:,2));
    
    % get background coordinates
    [rfc,cfc] = find(~foreground);
    mask1 = (rfc >= rmin-cutoff) & (rfc <= rmax+cutoff);
    mask2 = (cfc >= cmin-cutoff) & (cfc <= cmax+cutoff);
    mask = mask1 & mask2;
    rfc = rfc(mask);
    cfc = cfc(mask);
    
    
    % assign_radii
    for i = 1:length(rfc(:))
        ri = rfc(i);
        ci = cfc(i);
        a = [ri,ci];
        dist = min(sqrt(sum(power((foreground_coordinates-a),2),2)));
        radii(ri,ci) = round(dist);
    end
    
    radii(radii > cutoff) = cutoff;
    radii(foreground) = 0;
    
end

