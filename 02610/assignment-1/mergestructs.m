function s = mergestructs(org, update)
    names = fieldnames(update);
    for i=1:length(names)
        name = names{i};
        org = setfield(org, name, getfield(update, name));
    end
    s = org;
end
