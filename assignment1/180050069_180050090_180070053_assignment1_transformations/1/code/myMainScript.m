%% MyMainScript
close all;
clearvars;
clc;

tic;
%% Image shrinking
input_img1 = imread("../data/circles_concentric.png");
output1 = myShrinkImageByFactorD(input_img1,2);
output2 = myShrinkImageByFactorD(input_img1,3);
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

figure(1), imagesc (single (output1)); 
title('Moire Pattern for concentric circles with d=2')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

figure(2), imagesc (single (output2)); 
title('Moire Pattern for concentric circles with d=3')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

figure(3), imagesc (single (input_img1));
title('Original image of concentric circles')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar
%% Image enlargement : Bi-Linear Interpolation
input_img2 = imread("../data/barbaraSmall.png");
input_img2=double(input_img2);
[rows cols]=size(input_img2);
new_rows=3*rows-2;
new_cols=2*cols-1;
output_li=zeros(new_rows, new_cols);
Area=6;

for i=1:rows-1
    for j=1:cols-1
        for x=1:4
            for y=1:3
               output_li(3*(i-1)+x,2*(j-1)+y)=myBilinearInterpolation(input_img2(i:i+1,j:j+1), x, y, Area);
            end
        end
    end
end
 
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

figure(4)
subplot(1,2,1), imagesc (single (input_img2)); 
title('Original image of barbaraSmall')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

subplot(1,2,2), imagesc (single (output_li)); 
title('Image Enlarged Using Bilinear Interpolation')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar
%% Image enlargement : Nearest Neighbor
output_nn=zeros(new_rows, new_cols);

for i=1:rows-1
    for j=1:cols-1
        for x=1:4
            for y=1:3
               output_nn(3*(i-1)+x,2*(j-1)+y)=myNearestNeighborInterpolation(input_img2(i:i+1,j:j+1), x, y);
            end
        end
    end
end

myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

figure(5)
subplot(1,2,1), imagesc (single (input_img2)); 
title('Original image of barbaraSmall')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

subplot(1,2,2), imagesc (single (output_nn)); 
title('Image Enlarged Using Nearest Neighbhor Interpolation')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar
%% Image enlargement : Bi-Cubic Interpolation
% A^(-1)*X=coeffs
A_inv=[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;... 
0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0;...
-3,3,0,0,-2,-1,0,0,0,0,0,0,0,0,0,0;...
2,-2,0,0,1,1,0,0,0,0,0,0,0,0,0,0;...
0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0;...
0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0;...
0,0,0,0,0,0,0,0,-3,3,0,0,-2,-1,0,0;...
0,0,0,0,0,0,0,0,2,-2,0,0,1,1,0,0;...
-3,0,3,0,0,0,0,0,-2,0,-1,0,0,0,0,0;...
0,0,0,0,-3,0,3,0,0,0,0,0,-2,0,-1,0;...
9,-9,-9,9,6,3,-6,-3,6,-6,3,-3,4,2,2,1;...
-6,6,6,-6,-3,-3,3,3,-4,4,-2,2,-2,-2,-1,-1;...
2,0,-2,0,0,0,0,0,1,0,1,0,0,0,0,0;...
0,0,0,0,2,0,-2,0,0,0,0,0,1,0,1,0;...
-6,6,6,-6,-4,-2,4,2,-3,3,-3,3,-2,-1,-2,-1;...
4,-4,-4,4,2,2,-2,-2,2,-2,2,-2,1,1,1,1];

output_bic=output_li; % The border of the image is interpolated using bilinear interpolation

der_x=zeros(rows,cols);
der_y=zeros(rows,cols);
der_xy=zeros(rows,cols);

% We have chosen the rows downward direction as postive x and y direction as
% moving towards right
for i=2:rows-1
    for j=2:cols-1
        der_x(i,j)=(input_img2(i+1,j)-input_img2(i-1,j))/2;
        der_y(i,j)=(input_img2(i,j+1)-input_img2(i,j-1))/2;
        der_xy(i,j)=(input_img2(i+1,j+1)+input_img2(i-1,j-1)-input_img2(i+1,j-1)-input_img2(i-1,j+1))/4;
    end
end

for i=2:rows-2
    for j=2:cols-2
        for x=0:1/3:1
            for y=0:1/2:1
               output_bic(3*(i-1)+3*x+1,2*(j-1)+2*y+1)=myBicubicInterpolation(input_img2(i:i+1,j:j+1),... 
               x, y, A_inv, der_x(i:i+1,j:j+1), der_y(i:i+1,j:j+1), der_xy(i:i+1,j:j+1));
            end
        end
    end
end

myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

figure(6)
subplot(1,2,1), imagesc (single (input_img2)); 
title('Original image of barbaraSmall')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

subplot(1,2,2), imagesc (single (output_bic)); 
title('Image Enlarged Using Bicubic Interpolation')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar
%% Comparision
figure(7)
subplot(1,3,1), imagesc (single (output_li(95:115,40:60))); 
title('Image Enlarged Using Bilinear Interpolation')
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

subplot(1,3,2), imagesc (single (output_nn(95:115,40:60))); 
title('Image Enlarged Using Nearest Neighbhor Interpolation')
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

subplot(1,3,3), imagesc (single (output_bic(95:115,40:60))); 
title('Image Enlarged Using Bicubic Interpolation')
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar
%% Image Rotation 
output_rotated=zeros(rows, cols);
shifted_origin=[(cols-1)/2; (rows-1)/2];
rotation_matrix=[cos(pi/6), sin(pi/6); -sin(pi/6), cos(pi/6)];

for i=1:rows
    for j=1:cols
        new_coords=rotation_matrix*([j; i]-shifted_origin)+shifted_origin;
        if(new_coords(1)>1 && new_coords(2)>1 && new_coords(1)<cols && new_coords(2)<rows)
            output_rotated(i,j)=myImageRotation(input_img2(floor(new_coords(2)):floor(new_coords(2))+1,floor(new_coords(1)):floor(new_coords(1))+1),...
            new_coords(1), new_coords(2));
        end
    end
end

myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

figure(8)
subplot(1,2,1), imagesc (single (input_img2)); 
title('Original image of barbaraSmall')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar

subplot(1,2,2), imagesc (single (output_rotated)); 
title('Image Rotated')
colormap (myColorScale);
%colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar
%% end
toc;
