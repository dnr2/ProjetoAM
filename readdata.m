function data = readdata(filename)

% Change to the data sets directory
cd datasets;

switch filename
    case 'att_faces'
        data = readattfaces;
    case 'mnistdigits'
        data = readmnistdigits;
    case 'binaryalphabet'
        data = readbinaryalphabet;
    case 'coil20'
        data = readcoil20;
    otherwise
        data = [];
        display('Invalid file name!')
end

% Change back to the original directory
cd ..;

end

% READING FUNCTIONS %

function data = readattfaces

% Preallocate for performance
% Since each image is a 23x28 image (28x23 matrix)
% data is a 400x644 matrix (400 images, 644 = 23*28 features)
data = zeros(400, 644);

% Change directory
cd att_faces;
numfolders = 40;
numimages = 10;

% For each folder
for i = 1:numfolders
    foldername = sprintf('s%d', i);
    cd (foldername);
    for j = 1:numimages
        imagename = sprintf('%d.pgm', j);
        imagematrix = imread(imagename);
        data((i - 1)*numimages + j, :) = reshape(imagematrix', 1, numel(imagematrix));
    end
    cd ..;
end

% Back to the original directory
cd ..;
end

function data = readmnistdigits

% Load the data set
% test{0-9} test sets
% train{0-9} train sets
load mnist_all.mat
numimages = 50;

% Since each image is a 28x28 image
% data is a 500x784 matrix (500 = 10*50 images, 784 = 28*28 features)
% Read the images into the data matrix
data = [train0(1:numimages, :); train1(1:numimages, :); 
    train2(1:numimages, :); train3(1:numimages, :); 
    train4(1:numimages, :); train5(1:numimages, :); 
    train6(1:numimages, :); train7(1:numimages, :);
    train8(1:numimages, :); train9(1:numimages, :)];

% Convert it to a matrix of doubles
data = double(data);

end

function data = readbinaryalphabet

% Preallocate for performance
% Since each image is a 16x20 binary image (20x16 matrix)
% data is a 1014x320 matrix (1014 = 26*39 images, 320 = 16*20 features)
data = zeros(1014, 320);

% Load the data set
% classcounts 1x36 cell
% classlabels 1x36 cell
% dat 36x39 cell
% numclass = 36
% 
load binaryalphadigs.mat

% Since we want only the alphabet digits
% We read only from dat{11, :} until dat{36, :}
numimages = classcounts{1}; % All the classes have the same number of examples

% Read the images into the data matrix
for i = 11:numclass
    for j = 1:numimages
        imagematrix = dat{i, j};
        data((i - 11)*numimages + j, :) = reshape(imagematrix', 1, numel(imagematrix));
    end
end

end

function data = readcoil20

% Preallocate for performance
% Since each image is a 32x32 image
% data is a 1000x1024 matrix (1000 images, 1024 = 32*32 features)
data = zeros(1000, 1024);

% Change directory
cd coil20;

% Number of objects and images for each object
numobjects = 20;
numimages = 50;

% Read the images into the data matrix
for i = 1:numobjects
    for j = 0:(numimages - 1)
        imagename = sprintf('obj%d__%d.png', i, j);
        imagematrix = imread(imagename);
        data((i - 1)*numimages + (j + 1), :) = reshape(imagematrix', 1, numel(imagematrix));
    end
end

% Back to the original directory
cd ..;
end