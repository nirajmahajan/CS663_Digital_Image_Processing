function [pcaModel] = fitPCA(xtrain, lighting)
    pcaModel = struct;
    pcaModel.mean = mean(xtrain,1);
    X = (xtrain-pcaModel.mean);
    [U,S,~] = svd(X', 'econ');
    S = diag(S);
    [out,idx] = sort(S, 'descend');
    U = U(:,idx);
    U = normc(U);
    S = out;
    if (lighting == 1)
        pcaModel.eigvecs = U(:,4:end);
        pcaModel.eigvals = S(4:end);
    else
        pcaModel.eigvecs = U;
        pcaModel.eigvals = S;
    end
end

