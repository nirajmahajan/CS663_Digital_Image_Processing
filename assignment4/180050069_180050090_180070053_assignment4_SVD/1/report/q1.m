%% MyMainScript
close all;
clearvars;
clc;

tic;
%% Your code here
rng(0);
A=randi([0,10],[5,3]);
[U S V] = MySVD(A);
disp(U*S*V');
disp(A);
toc;