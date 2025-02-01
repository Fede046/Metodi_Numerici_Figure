% Prove per grafico di funzioni polinomiali e derivata
close all
%c=[1,0,-4,0]; a=-3; b=3;
c=[0.2,1,-0.4,-3,1]; a=-6; b=6;
% c=[4 -9 6 0]; a=-0.5; b=1.5;
% c=[4 -3 0 0]; a=-0.5; b=1.5;
% c = [3 -2 0 0]; a=-1; b=1;
% c = []

figure(1)
hold on;
np=200;
x = linspace(a,b,np);
y = polyval(c,x);

plot(x,y,'g','LineWidth',1.5)
xlabel('x')
ylabel('y')
grid on

c1=polyder(c);
y1=polyval(c1,x);
plot(x,y1,'k','LineWidth',1.5)

c2=polyder(c1);
y2=polyval(c2,x);
plot(x,y2,'r','LineWidth',1.5)
