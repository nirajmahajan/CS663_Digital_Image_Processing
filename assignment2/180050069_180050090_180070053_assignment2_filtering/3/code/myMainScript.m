%% MyMainScript
clear; clc; close all;
tic;
%% Your code here
iso_sigma = 1.5;
mask = fspecial('gaussian', 9, iso_sigma);
figure(1);
myImshow(mask);
title('Mask used to make patches Isotropic')

im = double(load('../data/barbara.mat').imageOrig);
h_sigma = 0.15;
workOnImage(im, 'Barbara', 2, h_sigma, mask);

im = double(imread('../data/grass.png'));
h_sigma = 0.01;
workOnImage(im, 'Grass', 3, h_sigma, mask);

im = double(imread('../data/honeyCombReal.png'));
h_sigma = 0.01;
workOnImage(im, 'Honeycomb', 4, h_sigma, mask);

toc;
