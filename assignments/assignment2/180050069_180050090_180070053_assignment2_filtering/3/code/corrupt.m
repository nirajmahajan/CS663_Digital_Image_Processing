function [O] = corrupt(I)
%CORRUPT Adds gaussian noise to image
    O = I + 0.05*(max(I(:)) - min(I(:)))*randn(size(I));
end

