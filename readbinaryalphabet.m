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
% We will read only from dat{11, :} until dat{36, :}
numimages = classcounts{1}; % All the classes have the same number of examples

% Read the images into the data matrix
for i = 11:numclass
    for j = 1:numimages
        imagematrix = dat{i, j};
        data((i - 11)*numimages + j, :) = reshape(imagematrix', 1, numel(imagematrix));
    end
end
end