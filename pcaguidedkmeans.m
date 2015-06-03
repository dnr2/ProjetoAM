function sumdvec = pcaguidedkmeans(data, k, replicates)

% Apply PCA on original data
% score contains the representation of the original data in the principal
% component space
[~, score] = pca(data, 'NumComponents', k);

% Preallocate for performance
sumdvec = zeros(1, replicates);
for i = 1:replicates
    % Apply KMeans on the subspace created by the PCA
    % Standard KMeans selects K random points from score to use as centroids.
    % idx contains the clusters indices. It is a column vector that contains as
    % many rows as score.
    idx = kmeans(score, k, 'MaxIter', 1000, 'Start', 'sample');
    
    % Find the new K centroids in the original space
    % Preallocate for performance
    C = zeros(k, size(data, 2));
    for j = 1:k
        C(j, :) = sum(data(idx == j, :)) / size(data(idx == j, :), 1);
    end
    
    % KMeans on the original data set initialized with given centroids
    [~, ~, sumd] = kmeans(data, k, 'Display', 'final', 'MaxIter', 1000, 'Start', C);
    
    % Get the WCSS
    sumdvec(i) = sum(sumd);
end

% Sort the distortion values in descending order
sumdvec = sort(sumdvec, 'descend');
end