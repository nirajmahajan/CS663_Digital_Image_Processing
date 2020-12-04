function [orl_xtrain, orl_xtest, orl_ytrain, orl_ytest] = loadORL(path, list_people, train_size)
    % load train data
    orl_xtrain = zeros(192,10304);
    orl_xtest = zeros(128,10304);
    orl_ytrain = zeros(1,192);
    orl_ytest= zeros(1,128);
    n_train = 1;
    n_test = 1;
    for person = list_people
        mydir = dir(sprintf('%ss%d/*.pgm',path, person));
        count = 0;
        for a = 1:numel(mydir)
            im = double(imread(sprintf('%ss%d/%s',path, person, mydir(a).name)));
            if (count < train_size)
                orl_xtrain(n_train,:) = reshape(im, 1,[]);
                orl_ytrain(n_train) = person;
                n_train = n_train + 1;
            else
                orl_xtest(n_test,:) = reshape(im, 1,[]);
                orl_ytest(n_test) = person;
                n_test = n_test + 1;
            end
            count = count + 1;
        end
    end 
end

