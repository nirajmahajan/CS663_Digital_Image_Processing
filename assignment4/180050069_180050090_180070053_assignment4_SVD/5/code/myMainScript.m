%% MyMainScript
clear;clc; close all;
tic;
fig_counter = 1;
% Your code here
% returns nxd dimensional arrays
[orl_xtrain, orl_xtest, orl_ytrain, orl_ytest] = loadORL('../../datasets/ORL/', 1:32, 6);
pca_model = fitPCA(orl_xtrain, 0);
kays = [2, 10, 20, 50, 75, 100, 125, 150, 175];
figure(double(fig_counter))
set(gcf, 'Position', [100, 100, 500, 500])
tiledlayout(3,3,'TileSpacing','none','Padding','none');
for iter = 1:size(kays,2)
    k = kays(iter);
    predictor = getPredictor(pca_model, orl_xtrain, k);
    orig = orl_xtrain(1,:);
    transform = (predictor.transform(orig)*predictor.transform_matrix') + predictor.mean;
    nexttile;
    imshow(reshape(transform/max(transform(:)), 112, 92));
    title(sprintf('k = %d', k));
end
saveas(fig_counter,'../images/reconstruct.png')
pause(0.02)
savefig(fig_counter,'../images/reconstruct.fig')
fig_counter = fig_counter + 1;

figure(double(fig_counter))
set(gcf, 'Position', [700, 100, 700, 700])
tiledlayout(5,5,'TileSpacing','none','Padding','none');
for iter = 1:25
    transform = predictor.transform_matrix(:,iter);
    transform = transform - min(transform(:));
    transform = transform / max(transform(:));
    nexttile;
    imshow(reshape(transform, 112, 92));
    if iter == 1
        title(sprintf('%dst largest', iter));
    elseif iter == 2
        title(sprintf('%dnd largest', iter));
    elseif iter == 3
        title(sprintf('%drd largest', iter));
    else
        title(sprintf('%dth largest', iter));
    end
            
    
end
saveas(fig_counter,'../images/eigenfaces.png')
pause(0.02)
savefig(fig_counter,'../images/eigenfaces.fig')
toc;