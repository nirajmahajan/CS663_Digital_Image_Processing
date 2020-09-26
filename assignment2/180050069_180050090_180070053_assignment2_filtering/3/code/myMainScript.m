%% MyMainScript
clear; clc; close all;
tic;
rng(0);
%% Your code here
iso_sigma = 1.5;
mask = fspecial('gaussian', 9, iso_sigma);
fig = figure(1);
myImshow(mask);
savefig('../images/isotropic_filter.fig');
saveas(fig, '../images/isotropic_filter.png');
title('Mask used to make patches Isotropic')
toc;

tic;
im = double(load('../data/barbara.mat').imageOrig);
h_sigma = 0.8424;
workOnImage(im, 'Barbara', 2, h_sigma, mask);
toc;

tic;
im = double(imread('../data/grass.png'));
h_sigma = 1.81;
workOnImage(im, 'Grass', 3, h_sigma, mask);
toc;

tic;
im = double(imread('../data/honeyCombReal.png'));
h_sigma = 2.1;
workOnImage(im, 'Honeycomb', 4, h_sigma, mask);
toc;
