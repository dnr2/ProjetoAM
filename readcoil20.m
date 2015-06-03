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