function [yale_xtrain, yale_xtest, yale_ytrain, yale_ytest] = loadYale(path, list_people, train_size)
    % load train data
    yale_xtrain = zeros(1520,32256);
    yale_xtest = zeros(895,32256);
    yale_ytrain = zeros(1,1520);
    yale_ytest= zeros(1,895);
    n_train = 1;
    n_test = 1;
    for person = list_people
        mydir = dir(sprintf('%syaleB%02d/*.pgm',path, person));
        count = 0;
        for a = 1:numel(mydir)
            im = double(imread(sprintf('%syaleB%02d/%s',path, person, mydir(a).name)));
            if (count < train_size)
                yale_xtrain(n_train,:) = reshape(im, 1,[]);
                yale_ytrain(n_train) = person;
                n_train = n_train + 1;
            else
                yale_xtest(n_test,:) = reshape(im, 1,[]);
                yale_ytest(n_test) = person;
                n_test = n_test + 1;
            end
            count = count + 1;
        end
    end 
end

