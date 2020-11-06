function [xtrain, xval, yval, xtest, ytest] = loadORL(path)
    % load train data
    xtrain = zeros(192,10304);
    xtest = zeros(144,10304);
    ytest = zeros(1,144);
    ytest(1:96) = 1;
    xval = zeros(64,10304);
    yval = zeros(1,64);
    yval(1:32) = 1;
    n_train = 1;
    n_test = 1;
    n_val = 1;
    for person = 1:32
        mydir = dir(sprintf('%ss%d/*.pgm',path, person));
        count = 0;
        for a = 1:numel(mydir)
            im = double(imread(sprintf('%ss%d/%s',path, person, mydir(a).name)));
            if (count < 6)
                xtrain(n_train,:) = reshape(im, 1,[]);
                n_train = n_train + 1;
            elseif (count < 7)
                xval(n_val,:) = reshape(im, 1,[]);
                n_val = n_val + 1;
            else
                xtest(n_test,:) = reshape(im, 1,[]);
                n_test = n_test + 1;
            end
            count = count + 1;
        end
    end
    for person = 33:40
        mydir = dir(sprintf('%ss%d/*.pgm',path, person));
        count = 0;
        for a = 1:numel(mydir)
            im = double(imread(sprintf('%ss%d/%s',path, person, mydir(a).name)));
            if (count < 4)
                xval(n_val,:) = reshape(im, 1,[]);
                n_val = n_val + 1;
            else
                xtest(n_test,:) = reshape(im, 1,[]);
                n_test = n_test + 1;
            end
            count = count + 1;
        end
    end
end

