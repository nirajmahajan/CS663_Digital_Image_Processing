function output = half_histogram_equalization(input)
    [r, c, channels] = size(input);
    output = zeros(r,c,channels);
    
    % Find a. Note that 'a' is the median intensity
%     a = ceil(mean(input(:))) + 1
    a = ceil(double(median(input(:)))) + 1;
    
    % Collect the histogram, which is the pdf in this case
    % Assuming input as uint8
    pdf1 = zeros(a,channels);
    pdf2 = zeros(256-a,channels);
    for k = 1:channels
        for i = 1:r
            for j = 1:c
                index = ceil(input(i,j,k)) + 1;
                if index <= a
                    pdf1(index,k) = pdf1(index,k) + 1;
                else
                    pdf2(index-a,k) = pdf2(index-a,k) + 1;
                end                
            end
        end
    end
    
    pdf1 = pdf1 / (sum(pdf1));
    pdf2 = pdf2 / (sum(pdf2));
    % Calculate cdf function
    cdf1 = cumsum(pdf1);
    cdf2 = cumsum(pdf2);
    
    % Calculate the new output
    for k = 1:channels
        for i = 1:r
            for j = 1:c
                index = ceil(input(i,j,k)) + 1;
                if index <= a
                    output(i,j,k) = a*cdf1(index,k);
                else
                    output(i,j,k) = a+((255-a)*cdf2(index-a,k));
                end
            end
        end
    end
    output = uint8(output);
end