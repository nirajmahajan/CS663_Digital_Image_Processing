function output = histogram_equalization(input)
    [r, c, channels] = size(input);
    output = zeros(r,c,channels);
    
    % Collect the histogram, which is the pdf in this case
    % Assuming input as uint8
    pdf = zeros(256,channels);
    for k = 1:channels
        for i = 1:r
            for j = 1:c
                index = ceil(input(i,j,k)) + 1;
                pdf(index,k) = pdf(index,k) + 1;
            end
        end
    end
    
    pdf = pdf / sum(pdf);
    
    % Calculate cdf function
    cdf = cumsum(pdf);
    
    for k = 1:channels
        for i = 1:r
            for j = 1:c
                index = ceil(input(i,j,k)) + 1;
                output(i,j,k) = 255*cdf(index,k);
            end
        end
    end
    output = uint8(output);
    
end

