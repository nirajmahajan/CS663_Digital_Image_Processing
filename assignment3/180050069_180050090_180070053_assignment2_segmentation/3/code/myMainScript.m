%% MyMainScript
clear;clc;close all;
tic;
%% Your code here
I = imread('../data/flower.jpg');
hi = 0.315;
lo = 0.18;
cutoff = 20;
gaussian_sigma = 0.7;
workOnImage(I, 'flower', 1, hi, lo, gaussian_sigma, cutoff);

I = imread('../data/bird.jpg');
hi = 0.43;
lo = 0.25;
cutoff = 40;
gaussian_sigma = 0.7;
workOnImage(I, 'bird', 2, hi, lo, gaussian_sigma, cutoff);

f = figure(23);
imshow(I);
title('Original Image')
saveas(f, sprintf('../images/%s_original.png',name));
pause(0.2);
savefig(sprintf('../images/figs/%s_original.fig',name));

toc;
