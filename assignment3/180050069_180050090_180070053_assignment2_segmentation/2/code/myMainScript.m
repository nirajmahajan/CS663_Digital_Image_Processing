%% MyMainScript

tic;
%% Your code here
figure('Name','Segmentation of baboonColor.png'), myMeanShiftSegmentation('../data/baboonColor.png',4,12,20,25,100,10,69)
figure('Name','Segmentation of bird.jpg'), myMeanShiftSegmentation('../data/bird.jpg',6,16,20,20,450,5,69)
figure('Name','Segmentation of flower.jpg'), myMeanShiftSegmentation('../data/flower.jpg',4,8,8,30,16,8,69)
toc;
