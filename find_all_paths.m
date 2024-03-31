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
[~, idx] = sort(cellfun(@length, allPaths), 'descend');
allPaths = allPaths(idx);

    function dfs(currentNode, startNode, used_gain, path)
        % Add current node to the path
        path = [path, currentNode];
        
        % If the path returns to the start node, record the path
        if currentNode == startNode && numel(path) > 1
            if require_unrepeat_path
                repeat_flag = false;
                for idx = 1:length(allPaths)
                    repeat_flag = is_repeat_path(allPaths{idx}(1:end-1), path(1:end-1));
                    if(repeat_flag == true)
                        break;
                    end
                end
                if repeat_flag == false
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

function repeat = is_repeat_path(path1, new_path)
% There is a repeat node in this path
if length(new_path) ~= length(unique(new_path))
    repeat = true;
    return;
end

% This function checks if two paths are the same.
repeat = false;
if numel(path1) ~= numel(new_path)
    return;
end

% pathLen = numel(path1);
% for i = 1:pathLen
%     if isequal(path1, circshift(new_path, i-1))
%         repeat = true;
%         return;
%     end
% end

end
