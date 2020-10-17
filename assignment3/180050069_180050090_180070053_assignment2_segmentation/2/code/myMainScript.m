%% MyMainScript

tic;
%% Your code here
figure('Name','Segmentation of baboonColor.png'), myMeanShiftSegmentation('../data/baboonColor.png')
figure('Name','Segmentation of bird.jpg'), myMeanShiftSegmentation('../data/bird.jpg')
figure('Name','Segmentation of flower.jpg'), myMeanShiftSegmentation('../data/flower.jpg')
toc;
