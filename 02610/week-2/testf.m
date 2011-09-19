function [f,g,H]=testf(x)
b=[-1.5;0];

H=[2,1;1,2];

g=H*x+b;

f=1/2*x'*H*x+b'*x;