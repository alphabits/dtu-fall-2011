function contourbranin(X, Y, logfs, v)

    contour(X, Y, logfs, v, 'linewidth', 1);
    colorbar;
    set(gca, 'fontsize', 14);

end
