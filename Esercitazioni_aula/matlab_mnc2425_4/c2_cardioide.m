function [x,y]=c2_cardioide(t)
%espressione parametrica della curva cardiode con t in [0,2*pi]

x=2.*cos(t)-cos(2*t)
y=2.*sin(t)-sin(2*t)

%primo
%x=t+3;
%y=t;
%secondo
%x=6*t-9t^2+4*t^3
%y=-3*t^2+4*t^3
%terzo
%x=t+sin(2*t)
%y=t+cos(5*t)
%quarto
x=t*cos(t)
y=t*sin(t)

return