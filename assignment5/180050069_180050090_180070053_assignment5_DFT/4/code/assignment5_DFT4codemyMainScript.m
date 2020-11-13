%% MyMainScript

tic;
%% Your code here
input_img1 = imread("../data/barbara256.png");

input_img1_pad = padarray(input_img1,size(input_img1)./2,0,"both");
ft_img = fftshift(fft2(input_img1_pad));
log_ft_img = log(abs(ft_img)+1);
[rows cols] = size(input_img1_pad);

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

figure(2); imshow(log_ft_img,[min(log_ft_img(:)) max(log_ft_img(:))]); 
title('Log of Fourier Transform of Original Image'); colormap('jet'); colorbar;


%% Ideal Filter
%Ideal Filter with cutoff 40
lpf_40 = zeros(size(input_img1_pad));
for i=1:rows
    for j=1:cols
        if ((i-256)^2+(j-256)^2)<=1600
            lpf_40(i,j)=1;
        end
    end
end

log_lpf_40 = log(abs(lpf_40)+1);

output_img_ft_40 = ft_img.*lpf_40;
log_ft_oimg_40 = log(abs(output_img_ft_40)+1);

output_img_40 = real(ifft2(ifftshift(output_img_ft_40)));
output_img_40 = output_img_40(129:384, 129:384);

figure(3)
imagesc(single(output_img_40)); 
title('Output Image with cutoff 40 (Ideal)')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

figure(4); 
subplot(1,2,1), imshow(log_ft_oimg_40,[min(log_ft_oimg_40(:)) max(log_ft_oimg_40(:))]); 
title('Log of Fourier Transform of output image of ideal lpf with cutoff 40'); colormap('jet'); colorbar;
subplot(1,2,2), imshow(log_lpf_40,[min(log_lpf_40(:)) max(log_lpf_40(:))]); 
title('Log of Fourier Transform of the Filter'); colormap('jet'); colorbar;


%Ideal Filter with cutoff 80
lpf_80 = zeros(size(input_img1_pad));
for i=1:rows
    for j=1:cols
        if ((i-256)^2+(j-256)^2)<=6400
            lpf_80(i,j)=1;
        end
    end
end

log_lpf_80 = log(abs(lpf_80)+1);

output_img_ft_80 = ft_img.*lpf_80;
log_ft_oimg_80 = log(abs(output_img_ft_80)+1);

output_img_80 = real(ifft2(ifftshift(output_img_ft_80)));
output_img_80 = output_img_80(129:384, 129:384);

figure(5)
imagesc(single(output_img_80)); 
title('Output Image with cutoff 80 (Ideal)')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

figure(6); 
subplot(1,2,1), imshow(log_ft_oimg_80,[min(log_ft_oimg_80(:)) max(log_ft_oimg_80(:))]); 
title('Log of Fourier Transform output image of ideal lpf with cutoff 80'); colormap('jet'); colorbar;
subplot(1,2,2), imshow(log_lpf_80,[min(log_lpf_80(:)) max(log_lpf_80(:))]); 
title('Log of Fourier Transform of the Filter'); colormap('jet'); colorbar;

%% Gaussian Filter 
%Gaussian Filter with cutoff 40
glpf_40 = zeros(size(input_img1_pad));
for i=1:rows
    for j=1:cols
        glpf_40(i,j)=exp(-((i-256)^2+(j-256)^2)/3200);  %2*sigma^2=3200
    end
end

log_glpf_40 = log(abs(glpf_40)+1);

output_gimg_ft_40 = ft_img.*glpf_40;
log_ft_ogimg_40 = log(abs(output_gimg_ft_40)+1);

output_gimg_40 = real(ifft2(ifftshift(output_gimg_ft_40)));
output_gimg_40 = output_gimg_40(129:384, 129:384);

figure(7)
imagesc(single(output_gimg_40)); 
title('Output Image with cutoff 40 (Gaussian)')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

figure(8); 
subplot(1,2,1), imshow(log_ft_ogimg_40,[min(log_ft_ogimg_40(:)) max(log_ft_ogimg_40(:))]); 
title('Log of Fourier Transform output image of gaussian lpf with cutoff 40'); colormap('jet'); colorbar;
subplot(1,2,2), imshow(log_glpf_40,[min(log_glpf_40(:)) max(log_glpf_40(:))]); 
title('Log of Fourier Transform of the Filter'); colormap('jet'); colorbar;


%Gaussain Filter with cutoff 80
glpf_80 = zeros(size(input_img1_pad));
for i=1:rows
    for j=1:cols
        glpf_80(i,j)=exp(-((i-256)^2+(j-256)^2)/12800); %2*sigma^2=12800
    end
end

log_glpf_80 = log(abs(glpf_80)+1);

output_gimg_ft_80 = ft_img.*glpf_80;
log_ft_ogimg_80 = log(abs(output_gimg_ft_80)+1);

output_gimg_80 = real(ifft2(ifftshift(output_gimg_ft_80)));
output_gimg_80 = output_gimg_80(129:384, 129:384);

figure(9)
imagesc(single(output_gimg_80)); 
title('Output Image with cutoff 80 (Gaussian)')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

figure(10); 
subplot(1, 2, 1), imshow(log_ft_ogimg_80,[min(log_ft_ogimg_80(:)) max(log_ft_ogimg_80(:))]); 
title('Log of Fourier Transform output image of gaussian lpf with cutoff 80'); colormap('jet'); colorbar;
subplot(1, 2, 2), imshow(log_glpf_80,[min(log_glpf_80(:)) max(log_glpf_80(:))]); 
title('Log of Fourier Transform of the Filter'); colormap('jet'); colorbar;


toc;
