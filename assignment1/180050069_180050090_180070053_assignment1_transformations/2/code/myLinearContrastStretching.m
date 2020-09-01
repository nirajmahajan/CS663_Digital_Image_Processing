function myLinearContrastStretching(img)
    A = imread(img);
    [rows,columns,colors] = size(A);
    out = zeros(size(A));
    mn = [];
    mx = [];
    for i = 1:colors
        layer = A(:,:,i);
        freq = zeros(256);
        total = rows*columns;
        for it = 1:rows
            for jt = 1:columns
                freq(layer(it,jt)+1)=freq(layer(it,jt)+1)+1;
            end
        end
        pre = 0;
        a = min(layer);
        b = max(layer);
        mn = [mn a];
        mx = [mx b];
        for it = 1:256
            pre = pre+freq(it);
            if double(pre)/total >= 0.05
                a = it-1;
                break;
            end
        end
        for it = 256:-1:1
            if double(pre)/total <= 0.95
                b = it-1;
                break;
            end
            pre = pre-freq(it);
        end
        out(:,:,i) = arrayfun(@(x) a+(double(x-a)/(b-a))*255,layer);
    end
    subplot(1,2,1), imshow(A), title('original'), colorbar , caxis([min(mn) max(mx)])
    if colors==1
        subplot(1,2,2), imshow(out), title('after LCS'), colorbar, caxis([0 255])
    else
         subplot(1,2,2), imshow(mat2gray(out)), title('after LCS'), colorbar, caxis([0 255])
    end
%     save('../images/b/b7','out');
end