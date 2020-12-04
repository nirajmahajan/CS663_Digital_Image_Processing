%% MyMainScript
close all;
clearvars;
clc;

tic;
%% Your code here
storedStructure = load("../data/assignment5_DFT3dataimage_low_frequency_noise.mat");
input_img1 = storedStructure.Z;
input_img1_pad = padarray(input_img1,size(input_img1)./2,0,"both");
ft_img = fftshift(fft2(input_img1_pad));
log_ft_img = log(abs(ft_img)+1);

%Notch Filter
Filter = ones(size(input_img1_pad));
for i=263:1:271
    for j=273:1:281
        if ((i-266)^2+(j-276)^2)<=14
            Filter(j,i)=0;
        end
    end
end

for i=243:1:251
    for j=232:1:240
        if ((i-246)^2+(j-236)^2)<=14
            Filter(j,i)=0;
        end
    end
end

output_img_ft = ft_img.*Filter;
log_ft_oimg = log(abs(output_img_ft)+1);

output_img = real(ifft2(ifftshift(output_img_ft)));
output_img = output_img(129:384, 129:384);

figure(1); imshow(log_ft_img,[min(log_ft_img(:)) max(log_ft_img(:))]); 
title('Log of Fourier Transform'); colormap('jet'); colorbar;

figure(2); imshow(log_ft_oimg,[min(log_ft_oimg(:)) max(log_ft_oimg(:))]); 
title('Log of Fourier Transform'); colormap('jet'); colorbar;


myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
 
figure(3)
imagesc(single(input_img1)); 
title('Original Image')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

figure(4)
imagesc(single(output_img)); 
title('Filtered Image')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

toc;
