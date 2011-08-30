fns = {
    @(x)(x.^2 + x + 1) @(x)(2*x + 1) @(x)(2) ;
    @(x)(-x.^2 + x + 1) @(x)(-2*x + 1) @(x)(-2) ;
    @(x)(x.^3 - 5*x.^2 + x + 1) @(x)(3*x.^2 - 10*x + 1) @(x)(6*x - 10) ;
    @(x)(x.^4 + x.^3 - 10*x.^2 - x + 1) @(x)(4*x.^3 + 3*x.^2 - 20*x - 1) @(x)(12*x.^2 + 6*x - 20)
};

grid on;
for i=1:4
    if i < 3
        x = -2:0.01:2;
    else
        x = -4:0.01:4;
    end
    for j=1:3
        num = 3*(i-1)+j;
        subplot(4,3,num);
        plot(x, fns{i, j}(x));
        grid(gca, 'minor');
    end
end
