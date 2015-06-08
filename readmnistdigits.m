function data = readmnistdigits

% Change to the directory containing the data sets
cd datasets;

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

% Back to the original directory
cd ..;
end