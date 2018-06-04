


A=cos(-2*pi:0.01:2*pi);
var(A)
A=canal(10,A,sqrt(0.5),1);
A=real(A);
figure()
x=-2*pi:0.01:2*pi;

plot(x,A)


