%main di esempio di interpolazione polinomiale
%con curve di Bezier a tratti
clear all
close all
grid("on")

col=['r','g','b','k'];
open_figure(1);

%legge i punti da interpolare da file .txt
Q=load('paperino.txt');
% Q=load('twitter.txt');

%disegna i punti di interpolazione
point_plot(Q,'k.',1,'k','k',12);

%chiama funzione per interpolazione a tratti della libreria anmglib_4.0
%utilizzare l'help per info sui parametri di input
param = 1;
ppP = curv2_ppbezierCC1_interp(Q,0,1,param);

%disegna curva 2D di Bezier a tratti di interpolazione
curv2_ppbezier_plot(ppP,40,'b-',2);

%disegna poligonale di controllo della curva di Bezier a tratti
%point_plot(ppP.cp,'r-o',1,'k','r');




