function sumdvec = kmeansplusplus(data, k, replicates)

% Preallocate for performance
sumdvec = zeros(1, replicates);
% k-means++ algorithm is the default algorithm in the matlab implementaion
% of k-means
for i = 1:replicates
    [~, ~, sumd] = kmeans(data, k, 'MaxIter', 1000);
    % Get the WCSS
    sumdvec(i) = sum(sumd);
end

% Sort the distortion values in descending order
sumdvec = sort(sumdvec, 'descend');
end