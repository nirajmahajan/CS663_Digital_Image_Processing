function [predictor] = getPredictor(pcaModel, xtrain, k)
    predictor = struct;
    predictor.mean = pcaModel.mean;
    predictor.n = size(xtrain, 1);
    predictor.transform_matrix = pcaModel.eigvecs(:, 1:k);
    predictor.transform= @(x) (x-predictor.mean)*predictor.transform_matrix;
    predictor.transformed = predictor.transform(xtrain);
end

