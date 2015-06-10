function distortionvec = kkz(data, k, replicates)

    % Initialize the centroids according to the KKZ algorithm
    centroids = initializecentroids(data, k);
    % kmeans algorithm initialized with the centroids calculated by the KKZ
    % algorithm
    [~, ~, sumdvec] = kmeans(data, k, 'MaxIter', 1000, 'Start', centroids);
    % Get the WCSS
    sumd = sum(sumdvec);
    distortionvec = repmat(sumd, 1, replicates);
end

function centroids = initializecentroids(data, k)

    % Preallocate for performance
    centroids = zeros(k, size(data, 2));

    % The first time, we calculate the distance from each point to the origin.
    diffnorm = sqrt(sum(data .* data, 2));
    % Then we select the point which is furthest from the origin (highest
    % norm).
    % This point will be the first on our centroids list.
    [~, index] = max(diffnorm);
    centroids(1, :) = data(index, :);
    % Remove it from the data set and from the distances list.
    data(index, :) = [];
    diffnorm(index) = [];

    % For each point left in the data set, we calculate its distance to each
    % point in the centroids list and set its distance to the current
    % centroids list as the minimum distance. Since we already calculated the
    % distance from each point to the previous ones in the centroids list, we
    % just need to calculate the distance to the last introduced one.
    % Then we choose the one which is furthest from the centroids list.
    for i = 2:k
        diff = data - repmat(centroids(i - 1, :), size(data, 1), 1);
        if i == 2
            diffnorm = sqrt(sum(diff .* diff, 2));
            [~, index] = max(diffnorm);
            centroids(i, :) = data(index, :);
            data(index, :) = [];
            diffnorm(index) = [];
        else
            temp = sqrt(sum(diff .* diff, 2));
            indexes = temp < diffnorm;
            diffnorm(indexes) = temp(indexes);
            [~, index] = max(diffnorm);
            centroids(i, :) = data(index, :);
            data(index, :) = [];
            diffnorm(index) = [];
        end
    end
end