function [fp, fn] = predict(predictor, xtest, ytest, thresh)
    xtrr = predictor.n;
    [~,xter] = size(ytest);
    a1 = reshape(predictor.transformed, 1, xtrr, []);
    a2 = predictor.transform(xtest);
    a2 = reshape(a2, xter, 1, []);
    % m, n, k
    filter0 = ytest == 0;
    filter1 = ytest == 1;
    % m_test, m_train
    scores = min(power(sum(power(a1-a2, 2), 3), 0.5), [], 2);
    predictions = ones(size(ytest));
    predictions(scores > thresh) = 0;
    
    fp = sum(predictions(filter0) == 1);
    fn = sum(predictions(filter1) == 0);
end