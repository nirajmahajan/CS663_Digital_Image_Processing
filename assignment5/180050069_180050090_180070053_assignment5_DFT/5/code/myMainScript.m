%% MyMainScript
clear;clc;close all;
rng(1);
tic;
%% Your code here
I = zeros(300,300);
I(50:120,50:100) = 255;
translated = zeros(300,300);
translated(120:190,20:70) = 255;
[x,y, impulse, visibility] = getTranslation(translated, I);
figure(1)
tiledlayout(2,2,'TileSpacing','none','Padding','none');
set(gcf, 'Position', [100, 100, 600, 600])
nexttile;
imshow(I)
title('Original');
nexttile;
imshow(translated);
title('Translated');
nexttile;
imshow(impulse/max(impulse(:)))
title('Cross-Power Spectrum')
nexttile;
imshow(visibility)
title('Marked Impulse')
fprintf('Tranlsation for Noise-less Case:\ntx = %d\nty = %d\n\n',x,y);
saveas(1,'../images/noiseless.png')
pause(0.02);
savefig(1,'../images/noiseless.fig')


I = I + randn(300,300)*20;
translated = translated + randn(300,300)*20;
[x,y, impulse, visibility] = getTranslation(translated, I);
figure(2)
tiledlayout(2,2,'TileSpacing','none','Padding','none');
set(gcf, 'Position', [720, 100, 600, 600])
nexttile;
imshow(I/max(I(:)))
title('Original');
nexttile;
imshow(translated/max(translated(:)));
title('Translated');
nexttile;
imshow(impulse)
title('Cross-Power Spectrum')
nexttile;
imshow(visibility)
title('Marked Impulse')
fprintf('Tranlsation for Noisy Case:\ntx = %d\nty = %d\n\n',x,y);
saveas(2,'../images/noisy.png')
pause(0.02);
savefig(2,'../images/noisy.fig')
toc;
