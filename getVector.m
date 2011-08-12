%
% Written by:
% 
% Edo Frederix
% The Johns Hopkins University / Eindhoven University of Technology
% Department of Mechanical Engineering
% edofrederix@jhu.edu, edofrederix@gmail.com
%

function vector = getVector(s)

    if ~isstruct(s)
        error('Did not receive a structure');
    end

    keys = fieldnames(s);
    vector = zeros(numel(keys), numel(s.(keys{1})));
    for i = 1:numel(keys)
        key = keys{i};
        vector(i,:) = transpose(s.(key)(:));
    end
end