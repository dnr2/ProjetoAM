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