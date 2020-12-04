function myMeanShiftSegmentation(img,scale,hr,hs,iter,lr,K,seed)
    rng(seed);
    A = imread(img);
    B = imgaussfilt(A,1);
    B = B(1:scale:end,1:scale:end,:);
    [rows,columns] = size(B,[1 2]);
    F = zeros(rows,columns,5);
    F(:,:,1:3) = B;
    for i = 1:rows
        for j = 1:columns
           F(i,j,4)=i;
           F(i,j,5)=j;
        end
    end
    X = zeros(rows,columns,5);
    for it = 1:iter
%         it
        for i = 1:rows
            for j = 1:columns
                X(:,:,1:3) = ((F(i,j,1:3)-F(:,:,1:3)).^2)./(2*hr*hr);
                X(:,:,4:5) = ((F(i,j,4:5)-F(:,:,4:5)).^2)./(2*hs*hs);    
                Z = exp(-1*sum(X,3));
                Y = F(:,:,1:3).*Z;  
                F(i,j,1:3) = F(i,j,1:3)+lr*((sum(Y,[1,2])./sum(Z,'all'))-F(i,j,1:3))./(hr*hr);
                Y = F(:,:,4:5).*Z;
                F(i,j,4:5) = F(i,j,4:5)+lr*(sum(Y,[1,2])./sum(Z,'all')-F(i,j,4:5))./(hs*hs);
            end
        end
    end
    
    [idx,C] = kmeans(reshape(F,rows*columns,5),K);
    idx = reshape(idx,rows,columns);

    for i = 1:rows
        for j = 1:columns
            for k = 1:K
                if idx(round(C(k,4)),round(C(k,5)))==idx(i,j)
                    F(i,j,:) = F(round(C(k,4)),round(C(k,5)),:);
                    break;
                end
            end
        end
    end
    
    B=F(:,:,1:3);
    subplot(1,2,1), imshow(A), title('original')
    subplot(1,2,2), imshow(mat2gray(B)), title('after mean shift segmentation')
%       save('../images/baboonColor.mat','B');
end
