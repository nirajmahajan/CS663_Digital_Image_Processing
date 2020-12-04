%% Function for generating eigenvectors corresponding to k largest eigenvalues

function [eig_vec, eig_val] = generalizedEigen(A, B, k)
    [V D] = eig(A, B);
    [d ind] = sort(diag(D));
    Ds = D(ind, ind);
    Vs = V(:, ind);
    eig_vec = Vs(:, end-k+1:end);
    eig_val = Ds(:, end-k+1:end);
end