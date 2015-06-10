function sumdvec = randomsearchkmeans(data, k, replicates)

% Preallocate for performance
sumdvec = zeros(1, replicates);
% Select k points uniformly at random from the range of data to initialize
% the k-means algorithm
for i = 1:replicates
    [~, ~, sumd] = kmeans(data, k, 'MaxIter', 1000, 'Start', 'uniform');
    % Get the WCSS
    sumdvec(i) = sum(sumd);
end

% Sort the distortion values in descending order
sumdvec = sort(sumdvec, 'descend');
end