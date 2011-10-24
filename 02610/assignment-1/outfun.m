function stop = outfun(x, optimvalues, state)
    disp(norm(optimvalues.gradient));
    stop = false;
end
