function allPaths = find_all_paths(graph, require_unrepeat_path)
% This function finds all paths in a graph.

% Initialize variables
cnt = size(graph, 1);
used_gain = false(cnt, cnt);
allPaths = {};

% Perform depth-first search for each node
for startNode = 1:cnt
    dfs(startNode, startNode, used_gain, []);
end
allPaths = allPaths';

    function dfs(currentNode, startNode, used_gain, path)
        % Add current node to the path
        path = [path, currentNode];
        
        % If the path returns to the start node, record the path
        if currentNode == startNode && numel(path) > 1
            if require_unrepeat_path
                repeat_flag = false;
                for idx = 1:length(allPaths)
                    repeat_flag = is_repeat_path(allPaths{idx}(1:end-1), path(1:end-1));
                end
                if ~repeat_flag
                    allPaths{end+1} = path;
                end
            else
                allPaths{end+1} = path;
            end
            return;
        end
        
        % Obtain neighbor nodes
        neighbors = graph(currentNode, :);
        
        % Search neighbors recursively
        for i = 1:numel(neighbors)
            if neighbors(i) == 1 && ~used_gain(currentNode, i)
                used_gain(currentNode, i) = true;
                dfs(i, startNode, used_gain, path);
                used_gain(currentNode, i) = false;
            end
        end
    end

end

function repeat = is_repeat_path(path1, path2)
% This function checks if two paths are the same.

repeat = false;
if numel(path1) ~= numel(path2)
    return;
end

pathLen = numel(path1);
for i = 1:pathLen
    if isequal(path1, circshift(path2, i-1))
        repeat = true;
        return;
    end
end

end
