%script di esempio per curva 2d di Bezier
clear all
close all

open_figure(1);
axis_plot(12,1);

%carica file .db con definizione curva di bezier

bezP =curv2_bezier_load('c2_bezier.db');

disp(bezP.deg)%grado 
disp(bezP.cp)%punti di controllo
disp(bezP.ab)%intervallo
bezP.cp(1,:)=[10,10] %sposto il primo intervallo della curva 
%disegna curva di bezier
Px=curv2_bezier_plot(bezP,150,'b')

%disegna poligonale di controllo
point_plot(bezP.cp,'r-o',2,'k','r',8)
