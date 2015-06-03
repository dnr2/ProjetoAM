%calculates the centroids according to the kkz algorithm
%returns N vectors from the dataset, N must be greater or equal to 1
function centroids = kkz_algorithm(dataset,N)

    INF = 1/0;
    [n,m] = size(dataset);
    centroids = zeros(N,m);
    
    %get the instance with biggest norm to add in the centroids
    best_norm = -1;
    best_ins = 0;
    for ins_idx = 1:n
        if best_norm < norm(dataset(ins_idx,:))
            best_norm = norm(dataset(ins_idx,:));
            best_ins = dataset(ins_idx,:);
        end
    end
    centroids(1,:) = best_ins;
    
    for iteration = 2:N
        best_dist = -1;
        best_ins = 0;
        
        %For each non selected datapoint (candidatepoint)
        %TODO MUST MAKE SURE THAT THE SELECTED POINTS ARE NOT SELECTED AGAIN!
        for ins_idx = 1:n
            cur_ins = dataset(ins_idx,:);
            cur_dist = INF;
            
            %set the minimal distance between it and the centroids as the distance between them
            for cent_idx = 1:(iteration-1)
                cur_dist = min(cur_dist, norm(cur_ins-centroids(cent_idx,:)));
            end
            
            %try to set instance as the best instance so far
            if best_dist < cur_dist
                best_dist = cur_dist;
                best_ins = cur_ins;
            end            
        end
        
        %add instance in the centroids
        centroids(iteration,:) = best_ins;        
    end
end