function [subsystem, graph] = get_subsystems_from_keys(keys)
% This function extracts subsystems and builds a graph based on the provided keys.

% Initialize variables
count = 0;
subsystem = cell(0);
graph = false(length(keys));

% Loop through keys
for i = 1:length(keys)
    % Find '->' separator in the key
    idx = strfind(keys{i}, '->');
    
    % Error handling for invalid keys
    if(isempty(idx))
        error('There is an error in the key of %d-th gain: %s. \n', i, keys{i});
    elseif(size(idx,2)>1)
        error('There are multiple gains in the key of %d-th gain: %s. \n', i, keys{i});
    elseif(idx == 1 || idx == size(keys{i}, 2)-1)
        error('There is no matched subsystem in the key of %d-th gain: %s. \n', i, keys{i});
    end
    
    % Extract begin and end subsystems
    begin_idx = find(strcmp(subsystem, keys{i}(1:(idx-1))));
    end_idx   = find(strcmp(subsystem, keys{i}((idx+2):end)));
    
    % Add new subsystems if not found
    if(isempty(begin_idx))
        count = count + 1;
        begin_idx = count;
        subsystem{count} = keys{i}(1:(idx-1));
    end

    if(isempty(end_idx))
        count = count + 1;
        end_idx = count;
        subsystem{count} = keys{i}((idx+2):end);
    end
    
    % Build graph
    graph(begin_idx, end_idx) = true;
end
end
