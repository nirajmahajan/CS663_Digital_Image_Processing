function myHE(img)
    A = imread(img);
    [rows,columns,colors] = size(A);
    out = zeros(size(A));
    for i = 1:colors
        layer = A(:,:,i);
        freq = zeros(256);
        for it = 1:rows
            for jt = 1:columns
                freq(layer(it,jt)+1)= freq(layer(it,jt)+1)+1; 
            end
        end
        hist = zeros(256);
        cdf=0;
        for j = 1:256
            cdf=cdf+freq(j);
            hist(j)=cdf;
        end
        out(:,:,i) = arrayfun(@(x) round((double(hist(x+1))/cdf)*255),layer);
    end
    subplot(1,2,1), imshow(A), title('original')
    subplot(1,2,2), imshow(mat2gray(out)), title('after HE')
%     save('../images/c/c7.mat','out');
end