function myCLAHE(img,W,T)
    A = imread(img);
    [rows,columns,colors] = size(A);
    out = zeros(size(A));
    for i = 1:colors
        layer = A(:,:,i);
        for it = 1:rows
            for jt = 1:columns
                freq = zeros(256);
                total = 0;
                for it1 = max(1,it-W/2):min(it+W/2,rows)
                    for jt1 = max(1,jt-W/2):min(jt+W/2,columns)
                        freq(layer(it1,jt1)+1) = freq(layer(it1,jt1)+1)+1;
                        total = total+1;
                    end
                end
                extra = 0;
                for it1 = 1:256
                    freq(it1)=double(freq(it1))/total;
                    if freq(it1) > T
                        extra = extra+freq(it1)-T;
                        freq(it1) = T;
                    end
                end
                extra = extra/256;
                for it1 = 1:256
                    freq(it1) = freq(it1)+extra;
                end
                hist = zeros(256);
                sum = 0;
                for it1 = 1:256
                    sum = sum+freq(it1);
                    hist(it1) = sum;
                end
                out(it,jt,i) = hist(layer(it,jt)+1)*255;
            end
        end
    end
    str = sprintf('after CLAHE [W=%d, T=%.2f]', W,T);
    subplot(1,2,1), imshow(A), title('original')
    subplot(1,2,2), imshow(mat2gray(out)), title(str)
    save('../images/e/e6.mat','out');
end