%% MyMainScript
clear;clc; close all;
tic;
% Your code here
% returns nxd dimensional arrays
[orl_xtrain, orl_xtest, orl_ytrain, orl_ytest] = loadORL('../../datasets/ORL/', 1:32, 6);
pca_model = fitPCA(orl_xtrain, 0);
accuracies = zeros(1,13);
kays = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
fprintf('Results on ORL dataset\n');
for iter = 1:size(kays,2)
    k = kays(iter);
    predictor = getPredictor(pca_model, orl_xtrain, k);
    acc = predict(predictor, orl_xtest, orl_ytest, orl_ytrain);
    fprintf('Accuracy for k = %d = %f\n', k, acc);
    accuracies(iter) = acc;
end
figure(1)
plot(kays, accuracies, 'color', 'b', 'linewidth', 2);
title('Accuracies for ORL dataset');
ylabel('Percentage');
xlabel('k');
saveas(1,'../images/orl.png')
pause(0.02);
savefig(1,'../images/orl.fig')
fprintf('\n\n')

% returns nxd dimensional arrays
pca_model = fitPCAeig(orl_xtrain);
accuracies = zeros(1,13);
kays = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
fprintf('Results on ORL dataset with eig\n');
for iter = 1:size(kays, 2)
    k = kays(iter);
    predictor = getPredictor(pca_model, orl_xtrain, k);
    acc = predict(predictor, orl_xtest, orl_ytest, orl_ytrain);
    fprintf('Accuracy for k = %d = %f\n', k, acc);
    accuracies(iter) = acc;
end
figure(2)
plot(kays, accuracies, 'color', 'b', 'linewidth', 2);
title('Accuracies for ORL dataset using eig');
ylabel('Percentage');
xlabel('k');
saveas(2,'../images/orl_eig.png')
pause(0.02);
savefig(2,'../images/orl_eig.fig')
fprintf('\n\n')


temp = 1:39;
temp(14) = [];
[yale_xtrain, yale_xtest, yale_ytrain, yale_ytest] = loadYale('../../datasets/CroppedYale/', temp, 40);
pca_model = fitPCA(yale_xtrain, 0);
accuracies = zeros(1,13);
kays = [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
fprintf('Results on Yale dataset (with top 3)\n');
for iter = 1:size(kays,2)
    k = kays(iter);
    predictor = getPredictor(pca_model, yale_xtrain, k);
    acc = predict(predictor, yale_xtest, yale_ytest, yale_ytrain);
    fprintf('Accuracy for k = %d = %f\n', k, acc);
    accuracies(iter) = acc;
end
figure(3)
plot(kays, accuracies, 'color', 'b', 'linewidth', 2);
title('Accuracies for Yale dataset (with top 3)');
ylabel('Percentage');
xlabel('k');
saveas(3,'../images/yale.png')
pause(0.02);
savefig(3,'../images/yale.fig')
fprintf('\n\n')

temp = 1:39;
temp(14) = [];
pca_model = fitPCA(yale_xtrain, 1);
accuracies = zeros(1,13);
kays = [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
fprintf('Results on Yale dataset (w/o top 3 eigenvectors)\n');
for iter = 1:size(kays,2)
    k = kays(iter);
    predictor = getPredictor(pca_model, yale_xtrain, k);
    acc = predict(predictor, yale_xtest, yale_ytest, yale_ytrain);
    fprintf('Accuracy for k = %d = %f\n', k, acc);
    accuracies(iter) = acc;
end
figure(4)
plot(kays, accuracies, 'color', 'b', 'linewidth', 2);
title('Accuracies for Yale dataset (w/o top 3 eigenvectors)');
ylabel('Percentage');
xlabel('k');
saveas(4,'../images/yale_noptop3.png')
pause(0.02);
savefig(4,'../images/yale_notop3.fig')
fprintf('\n\n')
toc;
