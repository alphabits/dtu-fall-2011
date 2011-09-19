function  [f, g, H] = branin(x)
%     [f, g, H] = branin(x)
% May be called x containing multiple arguments, columnwise

% Version 09.08.24.  hbn(a)imm.dtu.dk

sx = min(size(x));
if  sx == 1,  x = x(:); end
s2 = sin(2*pi*x(1,:));   c2 = cos(2*pi*x(1,:));
s4 = sin(4*pi*x(2,:));   c4 = cos(4*pi*x(2,:));
d1 = pi*c2;   d2 = 2 - pi*c4/5;
r1 = 1 - 2*x(2,:) + s4/20 - x(1,:);
r2 = x(2,:) - s2/2;
f = (r1.^2 + r2.^2)/2;
if  nargout > 1  % gradient
  g = [-r1 - d1.*r2; r2 - d2.*r1];
  if  nargout > 2 & sx == 1  % Hessian
    H = [1 + d1^2 + 2*pi^2*s2*r2   d2-d1
      d2-d1   1 + d2^2 - 4*pi^2/5*s4*r1];
  end
end