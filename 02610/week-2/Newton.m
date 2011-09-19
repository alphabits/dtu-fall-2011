function [xmin,X,F,DF] = Newton(fun,x0,varargin)

kmax=1000;
tol=10^(-5);
%rho=0.9;
c=1.0e-4;
xmin=x0;

k=0;
x=x0;

[f,df,ddf]=feval(fun,x,varargin{:});

X=[x0];
F=[f];
DF=[df];

converged=(norm(df,'inf')<tol);

while ~converged && k<kmax
    s=-(ddf\df);
    x=x+s;
    
    [f,df,ddf]=feval(fun,x,varargin{:});
    
    X=[X,x];
    F=[F,f];
    DF=[DF,df];
    
    converged=(norm(df,'inf')<tol);
    
    if converged
        xmin=x;
    else
        xmin=[];
    end
    k=k+1;
   
end