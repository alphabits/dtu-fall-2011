r1 = -0.6222
r2 = 0.2222

f = function(x) {
    r2^3*x^4 + (2*r2^3-r2^2)*x^3 + (2*r2^3+r2*r1^2-2*r2^2)*x^2 + (2*r2^3-r2^2)*x + r2^3
}

theta1 = function(theta2) {
    r1*theta2/(r2*(1+theta2))
}


x = seq(0,3,length.out=200)

# Root between 0 and 1, and between 2 and 3
plot(x, f(x))

# Find roots 
theta21 = uniroot(f, lower=0, upper=1)$root
theta11 = theta1(theta21)
theta22 = uniroot(f, lower=2, upper=3)$root
theta12 = theta1(theta22)
