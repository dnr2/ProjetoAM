% Description of the code
%
%
%
%
disp('(1) AT&T Faces Data Set')
disp('(2) MNIST Handwritten Digits Data Set')
disp('(3) Binary Alphabet Data Set')
disp('(4) Coil20 Data Set')
datachoice = input('Choose a data set among the options: ');
while (datachoice < 1 || datachoice > 4)
    datachoice = input('Choose a data set among the options: ');
end

% Set the file name and the number of clusters
% Also, set some parameters for the results plot
switch datachoice
    case 1
        filename = 'att_faces';
        k = 40;
        plottitle = 'K-means on AT&T Dataset';
    case 2
        filename = 'mnistdigits';
        k = 10;
        plottitle = 'K-means on MNIST Dataset';
    case 3
        filename = 'binaryalphabet';
        k = 26;
        plottitle = 'K-means on BinAlpha Dataset';
    case 4
        filename = 'coil20';
        k = 20;
        plottitle = 'K-means on Coil20 Dataset';
    otherwise
        disp('Something went wrong...')
end

% Read the data set
data = readdata(filename);

% Shuffle the data
shrows = randperm(size(data, 1));
data = data(shrows, :);

% Select an algorithm
disp('(1) Random search')
disp('(2) K-means++')
disp('(3) PCA-guided search')
disp('(4) KKZ')
disp('(5) RUN ALL ALGORITHMS')
disp('(6) Random search + PCA-guided search (10d, 26d, 40d) + KKZ')
algorithmchoice = input('Please, select an algorithm: ');
while (algorithmchoice < 1 || algorithmchoice > 6)
    algorithmchoice = input('Please, select an algorithm: ');
end

% Get the number of trials of the algorithm
if (algorithmchoice <= 6)
    replicates = input('Please, enter a number of runs for the algorithm: ');
    while (replicates < 1 || (int32(replicates) ~= replicates))
        disp('You must enter a positive integer!')
        replicates = input('Please, enter a number of runs for the algorithm: ');
    end
end
should_plot = true;

% Select the desired algorithm and run it
% Also, set some parameters for the results plot
switch algorithmchoice
    case 1
        distortionvec = randomsearchkmeans(data, k, replicates);
        plotlegend = 'Random Search';
    case 2
        distortionvec = kmeansplusplus(data, k, replicates);
        plotlegend = 'K-means++';
    case 3
        distortionvec = pcaguidedkmeans(data, k, replicates);
        plotlegend = 'PCA-guided Search';
    case 4
        distortionvec = kkz(data, k, replicates);
        plotlegend = 'KKZ';
    case 5
        % Random search
        disp('Running the Random Search...')
        tic
        distortionvec1 = randomsearchkmeans(data, k, replicates);
        toc
        % K-means++
        disp('Running the K-means++...')
        tic
        distortionvec2 = kmeansplusplus(data, k, replicates);
        toc
        % PCA-guided search
        disp('Running the PCA-guided Search...')
        tic
        distortionvec3 = pcaguidedkmeans(data, k, replicates);
        toc
        % KKZ
        disp('Running the KKZ...')
        tic
        distortionvec4 = kkz(data, k, replicates);
        toc
        % Plot the results in a single graph
        hold all
        plot(distortionvec1, 'r', 'LineWidth', 2)
        plot(distortionvec2, 'b', 'LineWidth', 2)
        plot(distortionvec3, 'c', 'LineWidth', 2)     
        plot(distortionvec4, 'g', 'LineWidth', 2)
        ylabel('Distortion')
        title(plottitle)
        legend('Random Search', 'K-means++', 'PCA-guided Search', 'KKZ')  
        hold off
        % Get the minimum values of each algorithm
        % Since the values are sorted in descending order, just get the
        % last element
        mindistortionvec = [distortionvec1(end), distortionvec2(end), distortionvec3(end), distortionvec4(end)];
        fprintf('Minimum distortion values for each algorithm:\nRandom Search: %.6g\nK-means++: %.6g\nPCA-guided Search: %.6g\nKKZ: %.6g\n', ...
            mindistortionvec(1), mindistortionvec(2), mindistortionvec(3), mindistortionvec(4))
        % No individual plots
        should_plot = false;
    case 6
        % Update the k value
        k = [40, 26, 10];
        % Random search
        fprintf('Running the Random Search with k = %d...\n', k(2))
        tic
        distortionvec1 = randomsearchkmeans(data, k(2), replicates);
        toc
        % PCA-guided search k = k(1)
        fprintf('Running the PCA-guided Search with k = %d...\n', k(1))
        tic
        distortionvec2 = pcaguidedkmeans(data, k(1), replicates);
        toc
        % PCA-guided search k = k(2)
        fprintf('Running the PCA-guided Search with k = %d...\n', k(2))
        tic
        distortionvec3 = pcaguidedkmeans(data, k(2), replicates);
        toc
        % PCA-guided search k = k(3)
        fprintf('Running the PCA-guided Search with k = %d...\n', k(3))
        tic
        distortionvec4 = pcaguidedkmeans(data, k(3), replicates);
        toc
        % KKZ
        fprintf('Running the KKZ with k = %d...\n', k(2))
        tic
        distortionvec5 = kkz(data, k(2), replicates);
        toc
        % Plot the results in a single graph
        hold all
        plot(distortionvec1, 'm', 'LineWidth', 2)
        plot(distortionvec2, 'g', 'LineWidth', 2)
        plot(distortionvec3, 'k', 'LineWidth', 2)     
        plot(distortionvec4, 'r', 'LineWidth', 2)
        plot(distortionvec5, 'b', 'LineWidth', 2)
        ylabel('Distortion')
        title(plottitle)
        legend('Random Search', 'PCA-guided Search(40d)', 'PCA-guided Search(26d)', 'PCA-guided Search(10d)', 'KKZ')  
        hold off
        % Get the minimum values of each algorithm
        % Since the values are sorted in descending order, just get the
        % last element
        mindistortionvec = [distortionvec1(end), distortionvec2(end), distortionvec3(end), distortionvec4(end), distortionvec5(end)];
        fprintf('Minimum distortion values for each algorithm:\nRandom Search: %.6g\nPCA-guided Search(40d): %.6g\nPCA-guided Search(26d): %.6g\nPCA-guided Search(10d): %.6g\nKKZ: %.6g\n', ...
            mindistortionvec(1), mindistortionvec(2), mindistortionvec(3), mindistortionvec(4), mindistortionvec(5))
        % No individual plots
        should_plot = false;
    otherwise
        disp('Something went wrong...')
end

if ( should_plot )
    % Plot the results
    plot(distortionvec)
    ylabel('Distortion')
    title(plottitle)
    legend(plotlegend)
end