clear all
close all


%grafic setting
open_figure(1);
hold on;
grid("on");


%faccio la curva di bez de
a = 0;
b = 3*pi;

%curv bez
t1 = linspace(a,b,80);
[x1 y1] = c2_otto(t1);
ppbezOtto = curv2_ppbezierCC1_interp([x1' y1'],a,b,0);

curv2_ppbezier_plot(ppbezOtto,100,'g',2);

%%%calcolo dell'errore


%%pinti
npt = 150;
t = linspace(b/3,2*b/3,npt);
[x y] = c2_otto(t);
Pxy =[x' y']; 
Qxy = ppbezier_val(ppbezOtto,t);


MaxErr=max(vecnorm((Pxy-Qxy)'));
fprintf('MaxErr3: %e\n',MaxErr);








function [x,y] = c2_otto(t)
%in t [0,3*pi]
x = (4*(cos(t/3).^3)).*cos(t);
 y = (-4*cos(t/3).^2).*sin(t/3).*sin(t);
end