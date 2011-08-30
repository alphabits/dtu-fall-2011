fns = {@(x)(x-log(x)) @(x)(1-1./x) @(x)(1./x.^2)};
x = 0:0.1:2;

grid on;
for i=1:3
    subplot(3,1,i);
    plot(x, fns{i}(x));
    grid(gca, 'minor');
end
