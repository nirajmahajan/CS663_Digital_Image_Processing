%% MyMainScript
close all;
clearvars;
clc;

tic;
%% Your code here
storedStructure = load("../data/boat.mat");
input_img1 = storedStructure.imageOrig;
[rows cols]=size(input_img1);
nm_fac=max(input_img1(:));
input_img1=input_img1/nm_fac;

input_img1_smooth=imgaussfilt(input_img1, 0.65);

Gx = [1 +2 +1; 0 0 0; -1 -2 -1]; Gy = Gx';
der_x = conv2(input_img1_smooth, Gx, 'same');
der_y = conv2(input_img1_smooth, Gy, 'same');

eigen_value1=zeros(rows, cols); %principle eigen vale
eigen_value2=zeros(rows, cols); %other eigen value
C=zeros(rows, cols);  %corner-ness measure
weights=zeros(5,5); %window of the kernel is 5*5
k=0.04; %corner-ness constant
sigma=1.4; %weights standard deviation
for i=1:5
    for j=1:5
       weights(i,j)=exp(-((i-3)^2+(j-3)^2)/(2*sigma^2)); 
    end
end

for i=3:rows-2
    for j=3:cols-2
        [C(i,j), A]=myHarrisCornerDetector(weights, der_x(i-2:i+2,j-2:j+2), der_y(i-2:i+2,j-2:j+2), k);
        eigen_value=sort(eig(A));
        eigen_value1(i,j)=eigen_value(2);
        eigen_value2(i,j)=eigen_value(1);
    end
end

%Non-max suppression
for i=2:rows-1
    for j=2:cols-1
        window=C(i-1:i+1,j-1:j+1);
        maximum=max(window(:));
        if C(i,j)~=maximum
            C(i,j)=0;
        end
    end
end
%%
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

figure(1)
imagesc(single(input_img1)); 
title('Original Image')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

figure(2)
imagesc(single(input_img1_smooth)); 
title('Smoothed Image')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

figure(3)
subplot(1,2,1), imagesc(single(der_x)); 
title('Derivative along x')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

subplot(1,2,2), imagesc(single(der_y)); 
title('Derivative along y')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

figure(4)
imagesc(single(C)); 
title('Cornerness Measure')
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

figure(5)
subplot(1,2,1), imagesc(single(eigen_value1)); 
title('Principle Eigen Value')
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

subplot(1,2,2), imagesc(single(eigen_value2)); 
title('Other Eigen Value')
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar
toc;

