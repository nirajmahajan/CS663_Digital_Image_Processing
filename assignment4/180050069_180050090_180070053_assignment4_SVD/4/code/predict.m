function [accuracy] = predict(predictor, xtest, ytest, ytrain)
    [~,xtrr] = size(ytrain);
    [~,xter] = size(ytest);
    a1 = reshape(predictor.transformed, 1, xtrr, []);
    a2 = predictor.transform(xtest);
    a2 = reshape(a2, xter, 1, []);
    % m, n, k
    [~, predictions] = min(sum(power(a1-a2, 2), 3), [], 2);
    accuracy = 100 * sum(ytrain(predictions) == ytest) / xter;
end

