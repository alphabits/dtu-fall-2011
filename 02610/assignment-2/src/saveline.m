function [] = saveline(filename, linetemplate, variables)
    f = fopen(['../tables/', filename], 'w');
    fprintf(f, linetemplate, variables);
    fclose(f);
end
