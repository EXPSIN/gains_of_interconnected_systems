function gains_c = composite_gains(subsystem, allPaths, gains)
% This function calculates composite gains for given subsystems and paths.

% Initialize variables
cnt = length(allPaths);
gains_c = cell(cnt, 2); % Initialize cell array to store composite gains

% Loop through all paths
for i = 1:cnt
    % Initialize variables for current path
    node_cnt = length(allPaths{i});
    path = subsystem{allPaths{i}(end)};
    gain_c = sym('s'); % Initialize composite gain symbolically
    
    % Loop through nodes in reverse order
    for j = node_cnt-1:-1:1
        % Construct current path and extract gain
        path = [subsystem{allPaths{i}(j)}, '->', path];
        gain = gains([subsystem{allPaths{i}(j)}, '->', subsystem{allPaths{i}(j+1)}]);
        
        % Substitute symbolically calculated gain into composite gain
        gain_c = subs(gain, sym('s'), gain_c);
    end
    
    % Store composite gain and simplified version in cell array
    gains_c{i, 1} = path;
    gains_c{i, 2} = simplify(gain_c);
end
end
