%% MyMainScript
close all;
clearvars;
clc;

tic;
%% Your code here Barbara Image
storedStructure = load("../data/barbara.mat");
input_img1 = storedStructure.imageOrig;
[rows cols]=size(input_img1);
noise = 5*randn([rows cols]); %Additive gaussian noise with standard deviation set to 5(5% of intensity range)
input_img1_noise=input_img1+noise;

win=7; %window of dimension 7*7
padded_img1=padarray(input_img1_noise, [(win-1)/2 (win-1)/2], 0);
[rows_pad cols_pad]=size(padded_img1);
start=(win+1)/2;
sigma_s=1.5;
sigma_i=9.75;
filtered_image1=zeros([rows cols]);

for i=start:rows_pad-start+1
    for j=start:cols_pad-start+1
        filtered_image1(i-start+1, j-start+1)=myBilateralFiltering(padded_img1(i,j), padded_img1(i-start+1:i+start-1,j-start+1:j+start-1), sigma_s, sigma_i);
    end
end

err_matrix=(filtered_image1-input_img1).^2;
rms_err=sqrt(sum(err_matrix(:))/(rows*cols))

myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

figure(1)
subplot(1,3,1), imagesc(single(input_img1)); 
title('Original Image')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

subplot(1,3,2), imagesc(single(input_img1_noise)); 
title('Noisy Image')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

subplot(1,3,3), imagesc(single(filtered_image1)); 
title('Filtered Image')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar
%% Grass Image
input_img2 = double(imread("../data/grass.png"));
[rows cols]=size(input_img2);
noise = 12.5*randn([rows cols]); %Additive gaussian noise with standard deviation set to 12.5(5% of intensity range)
input_img2_noise=input_img2+noise;

win=3; %window of dimension 3*3
padded_img2=padarray(input_img2_noise, [(win-1)/2 (win-1)/2], 0);
[rows_pad cols_pad]=size(padded_img2);
start=(win+1)/2;
sigma_s=1.03;
sigma_i=42;
filtered_image2=zeros([rows cols]);

for i=start:rows_pad-start+1
    for j=start:cols_pad-start+1
        filtered_image2(i-start+1, j-start+1)=myBilateralFiltering(padded_img2(i,j), padded_img2(i-start+1:i+start-1,j-start+1:j+start-1), sigma_s, sigma_i);
    end
end
err_matrix=(filtered_image2-input_img2).^2;
rms_err=sqrt(sum(err_matrix(:))/(rows*cols))

myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

figure(2)
subplot(1,3,1), imagesc(single(input_img2)); 
title('Original Image')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

subplot(1,3,2), imagesc(single(input_img2_noise)); 
title('Noisy Image')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

subplot(1,3,3), imagesc(single(filtered_image2)); 
title('Filtered Image')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar
%% HoneyComb Image
input_img3 = double(imread("../data/honeyCombReal.png"));
[rows cols]=size(input_img3);
noise = 12.75*randn([rows cols]); %Additive gaussian noise with standard deviation set to 12.75(5% of intensity range)
input_img3_noise=input_img3+noise;

win=3; %window of dimension 3*3
padded_img3=padarray(input_img3_noise, [(win-1)/2 (win-1)/2], 0);
[rows_pad cols_pad]=size(padded_img3);
start=(win+1)/2;
sigma_s=1.25;
sigma_i=40;
filtered_image3=zeros([rows cols]);

for i=start:rows_pad-start+1
    for j=start:cols_pad-start+1
        filtered_image3(i-start+1, j-start+1)=myBilateralFiltering(padded_img3(i,j), padded_img3(i-start+1:i+start-1,j-start+1:j+start-1), sigma_s, sigma_i);
    end
end
err_matrix=(filtered_image3-input_img3).^2;
rms_err=sqrt(sum(err_matrix(:))/(rows*cols))

myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

figure(3)
subplot(1,3,1), imagesc(single(input_img3)); 
title('Original Image')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

subplot(1,3,2), imagesc(single(input_img3_noise)); 
title('Noisy Image')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

subplot(1,3,3), imagesc(single(filtered_image3)); 
title('Filtered Image')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar
%% Spatial Gaussian Filter I have used colorjet so as to get better visulatization for the gaussian filter
gaussian_filter1=zeros([7 7]);
for i=1:7
        for j=1:7
            gaussian_filter1(i,j)=255*exp(-((i-4)^2+(j-4)^2)/(2*1.5^2));
        end
end
figure(4), imagesc(single(gaussian_filter1)); 
title('Spatial Gaussian Filter for Barbara image')
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

gaussian_filter2=zeros([3 3]);
for i=1:3
        for j=1:3
            gaussian_filter2(i,j)=255*exp(-((i-2)^2+(j-2)^2)/(2*1.03^2));
        end
end
figure(5), imagesc(single(gaussian_filter2)); 
title('Spatial Gaussian Filter for Grass image')
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

gaussian_filter3=zeros([3 3]);
for i=1:3
        for j=1:3
            gaussian_filter3(i,j)=255*exp(-((i-2)^2+(j-2)^2)/(2*1.25^2));
        end
end
figure(6), imagesc(single(gaussian_filter3)); 
title('Spatial Gaussian Filter for HoneyComb image')
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar
toc;
