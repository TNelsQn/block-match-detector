function A = blockMatch(I, t)

    I = im2double(I);
    [M, N] = size(I);


    options = struct;
    options.BlockSize = 16; % block-square window for comparison
    options.BlockStep = 1;
    options.visualize = true;
    options.threshold = t; %0.005; % measures how similar are two patches

    disp(options)
    if options.visualize
     subplot(2,1,1)
     imshow(I)
     title('Forged')
     pause(eps)
    end

    %%%%%%%%%%%%
    %%%    Your code here

    % Create the binary masks
    A = zeros(size(I));

    % Generate scanning grid
    SGrid = ScanningGrid(I,options.BlockSize,options.BlockStep,1);

    % Number of blocks
    blockCount = size(SGrid,2);

    % Initialize table and position array
    T = zeros(blockCount,options.BlockSize^2);
    P = zeros(blockCount,2);

    % Fill table and position array
    for i = 1:blockCount
        % Set the Table for index i to be equal to one vectorised block
        % from the image.
        T(i,:) = I(SGrid(:,i));

        [y,x] = ind2sub(size(I) - options.BlockSize,i);
        P(i,:) = [y,x];
    end

    % Sort table lexicographically
    [T, F] = sortrows(T);
    
    % Sort positions based on sorted indices from T so they are in the same
    % order
    P = P(F, :); 

    % Search each adjascent block
    for i = 2:blockCount-1
        j = i - 1;
        % Calculate average absolute difference between rows
        meanDifference = mean(abs(T(i,:)-T(j,:)));
        % If difference is below threshold, apply the binary mask to both
        % blocks
        if meanDifference < t
            position1 = P(i,:);
            position2 = P(j,:);
            A(position1(1):position1(1)+options.BlockSize-1,position1(2):position1(2)+options.BlockSize-1) = 1;
            A(position2(1):position2(1)+options.BlockSize-1,position2(2):position2(2)+options.BlockSize-1) = 1;
        end
    end

    %%%%%%%%%%%%%

    if options.visualize
     subplot(2,1,2);
     imshow(imfuse(A,I,'blend','Scaling','joint'))
     title('Binary mask')
    end

end