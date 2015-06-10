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
algorithmchoice = input('Please, select an algorithm: ');
while (algorithmchoice < 1 || algorithmchoice > 5)
    algorithmchoice = input('Please, select an algorithm: ');
end

% Get the number of trials of the algorithm
if (algorithmchoice <= 5)
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
        distortionvec1 = randomsearchkmeans(data, k, replicates);        
        distortionvec2 = kmeansplusplus(data, k, replicates);        
        distortionvec3 = pcaguidedkmeans(data, k, replicates);
        distortionvec4 = kkz(data, k, replicates);
        hold all;
        plot(distortionvec1, 'k','LineWidth',2);
        plot(distortionvec2, 'r','LineWidth',2);
        plot(distortionvec3, 'b','LineWidth',2);        
        plot(distortionvec4, 'c','LineWidth',2);
        ylabel('Distortion');
        title(plottitle);
        legend('Random Search','K-means++','PCA-guided Search','KKZ');    
        hold off;
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