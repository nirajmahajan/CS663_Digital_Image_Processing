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

toc;
