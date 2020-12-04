%% MyMainScript

tic;
%% Your code here
figure('Name','Sharpening on superMoonCrop.mat'), myUnsharpMasking('../data/superMoonCrop.mat')
figure('Name','Sharpening on lionCrop.mat'), myUnsharpMasking('../data/lionCrop.mat')

toc;
