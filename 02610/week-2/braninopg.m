clc; clear all;

r1= @(x1,x2) 1-2*x2+1/20*sin(4*pi*x2)-x1;
r2= @(x1,x2) x2-1/2*sin(2*pi*x1);
f= @(x1,x2) log10(1/2*(r1(x1,x2).^2+r2(x1,x2).^2));

x1=linspace(-5,15,100);
x2=linspace(-5,5,100);
[X1,X2]=meshgrid(x1,x2);
F=f(X1,X2);

fs=14;
hold on
contour(X1,X2,F,[-5:0.2:5],'linewidth',2)
set(gca,'fontsize',fs)
%axis equal
colorbar

x0=[4.1;-1];
[xmin,X,F,DF]=newton(@branin,x0);

plot(X(1,:),X(2,:),'black')%,xmin(1),xmin(2),'m.','markersize',25,'linewidth',3)