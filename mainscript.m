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
algorithmchoice = input('Please, select an algorithm: ');
while (algorithmchoice < 1 || algorithmchoice > 3)
    algorithmchoice = input('Please, select an algorithm: ');
end

% Get the number of trials of the algorithm
if (algorithmchoice <= 3)
    replicates = input('Please, enter a number of runs for the algorithm: ');
    while (replicates < 1 || (int32(replicates) ~= replicates))
        disp('You must enter a positive integer!')
        replicates = input('Please, enter a number of runs for the algorithm: ');
    end
end

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
    otherwise
        disp('Something went wrong...')
end

% Plot the results
plot(distortionvec)
ylabel('Distortion')
title(plottitle)
legend(plotlegend)