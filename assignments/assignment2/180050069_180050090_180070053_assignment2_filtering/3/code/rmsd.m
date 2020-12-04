function rmserror = rmsd(A,B)
    [row, col, depth] = size(A);
    sq_diff = power(A-B,2);
    rmserror = sqrt((1/(row*col*depth*1.0))*(sum(sq_diff(:))));
end

