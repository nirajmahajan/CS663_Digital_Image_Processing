function [pcaModel] = fitPCAeig(xtrain)
    [C,~] = size(xtrain);
    
    pcaModel = struct;
    pcaModel.mean = mean(xtrain,1);
    X = (xtrain-pcaModel.mean)';
    [U,S] = eig((1/(C-1))*(X'*X));
    S = diag(S);
    [out,idx] = sort(S, 'descend');
    U = U(:,idx);
    U = X*U;
    S = out;
    pcaModel.eigvecs = normc(U);
    pcaModel.eigvals = S;
end

