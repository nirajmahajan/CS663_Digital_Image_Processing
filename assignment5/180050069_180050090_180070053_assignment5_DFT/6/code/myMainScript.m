N = 201;
F1 = zeros(N,N);
F2 = zeros(N,N);
for u = 1:201
    for v = 1:201
        for x = 99:101
            for y = 99:101
                if x==y && x==100
                    F1(u,v) = F1(u,v)-4*exp(-1i*2*pi*((u-1-100)*x/N+(v-1-100)*y/N));
                    F2(u,v) = F2(u,v)+8*exp(-1i*2*pi*((u-1-100)*x/N+(v-1-100)*y/N));
                else
                    if x~=y && (x+y)~=(N-1)
                        F1(u,v) = F1(u,v)+exp(-1i*2*pi*((u-1-100)*x/N+(v-1-100)*y/N));
                    end
                    F2(u,v) = F2(u,v)-exp(-1i*2*pi*((u-1-100)*x/N+(v-1-100)*y/N));
                end
            end
        end
    end
end
[U,V]=meshgrid(-100:100,-100:100);
lF1 = log(abs(F1)+1); 
figure('Name','k1-2d'); imshow(lF1,[min(lF1(:)) max(lF1(:))]); colormap('jet'); colorbar;
figure('Name','k1-3d'); surf(U,V,lF1); colormap('jet'); colorbar;
lF2 = log(abs(F2)+1); 
figure('Name','k2-2d'); imshow(lF2,[min(lF2(:)) max(lF2(:))]); colormap('jet'); colorbar;
figure('Name','k2-3d'); surf(U,V,lF2); colormap('jet'); colorbar;