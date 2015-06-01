% Description of the code
%
%
%
%

% Read the data set

% Adjust the data set

% Define the number of desired clusters
k = 3;

% Apply PCA on original data
% score contains the representation of the original data in the principal
% component space
[~, score] = pca(data, 'NumComponents', k);

% Apply KMeans on the subspace created by the PCA
% Standard KMeans selects K random points from score to use as centroids.
% idx contains the clusters indices. It is a column vector that contains as
% many rows as score.
idx = kmeans(score, k, 'Start', 'sample');

% Find the new K centroids in the original space
% Preallocate for performance
C = zeros(k, size(data, 2));
for i = 1:k
    C(i, :) = sum(data(idx == i, :)) / size(data(idx == i, :), 1);
end

% KMeans on the original data set initialized with given centroids
[idx, Cnew, sumd] = kmeans(data, k, 'Display', 'iter', 'MaxIter', 1000, 'Start', C);