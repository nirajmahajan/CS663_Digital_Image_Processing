function myUnsharpMasking(img)
    W=4;
    Sig=2;
    s=10;
    imageOrig = load(img);
    imageOrig = imageOrig.imageOrig;
    h = fspecial('Gaussian',W,Sig);
    imageRes = imageOrig+s*(imageOrig-imfilter(imageOrig,h));
    subplot(1,2,1), imshow(imageOrig), title('original'), colorbar , caxis([0 1])
    subplot(1,2,2), imshow(imageRes), title('result'), colorbar , caxis([0 1])
%     save('../images/superMoon','imageRes');