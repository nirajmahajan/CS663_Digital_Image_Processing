%% MyMainScript
clear;clc; close all;
tic;
% Your code here
% returns nxd dimensional arrays
[xtrain, xval, yval, xtest, ytest] = loadORL('../../datasets/ORL/');
pca_model = fitPCA(xtrain, 0);
k = 50;
thresh = 2090;
predictor = getPredictor(pca_model, xtrain, k);
[fp, fn] = predict(predictor, xtest, ytest, thresh);
fprintf('False Positives = %d out of 48 Negatives\n', fp);
fprintf('False Negatives = %d out of 96 Positives\n', fn);

% % code for tuning thresh
% for thresh = 1500:2200
%     [fp, fn] = predict(predictor, xval, yval, thresh);
%     fprintf('Thresh %02.02f, fp = %d, fn = %d, min= %d\n', thresh, fp, fn, fp+fn);
% end

toc;