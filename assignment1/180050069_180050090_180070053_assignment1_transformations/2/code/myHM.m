function myHM(img,imgMask,ref,refMask)
    A = imread(img);
    A_mask = imread(imgMask);
    A_masked = A;
    B = imread(ref);
    B_mask = imread(refMask);
    B_masked = B;
    [rows,columns,colors] = size(A);
    out_eq = zeros(size(A));
    out_hm = zeros(size(A));
    for i = 1:colors
        for it = 1:rows
            for jt = 1:columns
                if A_mask(it,jt)==0
                    A_masked(it,jt,i)=0;
                end
                if B_mask(it,jt)==0
                    B_masked(it,jt,i)=0;
                end
            end
        end
        layer_a = A_masked(:,:,i);
        layer_b = B_masked(:,:,i);
        freq_a = zeros(256);
        freq_b = zeros(256);
        for it = 1:rows
            for jt = 1:columns
                freq_a(layer_a(it,jt)+1)= freq_a(layer_a(it,jt)+1)+1;
                freq_b(layer_b(it,jt)+1)= freq_b(layer_b(it,jt)+1)+1;
            end
        end
        hist_a = zeros(256);
        hist_b = zeros(256);
        cdf_a=0;
        cdf_b=0;
        for j = 1:256
            cdf_a = cdf_a+freq_a(j);
            hist_a(j) = cdf_a;
            cdf_b = cdf_b+freq_b(j);
            hist_b(j) = cdf_b;
        end
        map_ab=zeros(256);
        for it = 1:256
            if freq_a(it)>0
                map_ab(it)=255;
                for jt = 1:256
                    if hist_b(jt)>=hist_a(it)
                        map_ab(it)=jt-1;
                        break;
                    end
                end
            end
        end
        out_eq(:,:,i) = arrayfun(@(x) round((double(hist_a(x+1))/cdf_a)*255),A(:,:,i));
        out_hm(:,:,i) = arrayfun(@(x) map_ab(x+1),A(:,:,i));
    end
    subplot(1,3,1), imshow(A), title('original')
    subplot(1,3,2), imshow(mat2gray(out_eq)), title('after HE')
    subplot(1,3,3), imshow(mat2gray(out_hm)), title('after HM')
%     save('../images/d/d4.mat','out_hm');
end