function myHM(img,imgMask,ref,refMask)
    A = imread(img);
    A_mask = imread(imgMask);
    B = imread(ref);
    B_mask = imread(refMask);
    [rows,columns,colors] = size(A);
    out_eq = zeros(size(A));
    out_hm = zeros(size(A));
    for i = 1:colors
        layer_a = A(:,:,i);
        layer_b = B(:,:,i);
        freq_a = zeros(256);
        freq_b = zeros(256);
        for it = 1:rows
            for jt = 1:columns
                if A_mask(it,jt)>0
                    freq_a(layer_a(it,jt)+1)= freq_a(layer_a(it,jt)+1)+1;
                end
                if B_mask(it,jt)>0
                    freq_b(layer_b(it,jt)+1)= freq_b(layer_b(it,jt)+1)+1;
                end
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
        for it=1:rows
            for jt=1:columns
                if A_mask(it,jt)>0
                    out_eq(it,jt,i)=round((double(hist_a(A(it,jt,i)+1))/cdf_a)*255);
                    out_hm(it,jt,i)=map_ab(A(it,jt,i)+1);
                else 
                    out_eq(it,jt,i)=A(it,jt,i);
                    out_hm(it,jt,i)=A(it,jt,i);
                end
            end
        end
    end
    subplot(1,3,1), imshow(A), title('original')
    subplot(1,3,2), imshow(mat2gray(out_eq)), title('after HE')
    subplot(1,3,3), imshow(mat2gray(out_hm)), title('after HM')
%      save('../images/d/d4.mat','out_hm');
end