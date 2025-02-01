%main di esempio di interpolazione di punti 2D con curve di Bezier
clear all
close all

col=['r','g','b','k'];
open_figure(1);
axis_plot(3,0.25);

%set di punti di interpolazione
Q=[0,2; 1,1; 2,1; 3,2];
Q1=[0,0; 1,1; 2,2; 3,3];
Q2=[0,2; 1,1; 2,2; 3,1];
Q3=[1,2; 1.8,2; 2,2; 1.8,1.8; 1.2,1.2; 1,1; 1.2,1; 2,1];

%grado della curva interpolante
deg=length(Q(1,:))-1;
%intervallo parametrico di definizione
a = 1; 
b = 0;

%numero punti di plotting
np = 40;
%disegno punti di interpolazione
point_plot(Q,'ko',1,'k');
point_plot(Q1,'ko',1,'k');
point_plot(Q2,'ko',1,'k');
point_plot(Q3,'ko',1,'k');
%scelta dei parametri per i punti di interpolazione (param = 0, 1 o 2)
param = 2;

%chiamata funzione di interpolazione della libreria anmglib_4.0
%utilizzare l'help per info sui parametri di input
Pbez = curv2_bezier_interp(Q,a,b,param);
Pbez1 = curv2_bezier_interp(Q1,a,b,param);
Pbez2 = curv2_bezier_interp(Q2,a,b,param);
Pbez3 = curv2_bezier_interp(Q3,a,b,0);
%disegno curva interpolante
curv2_bezier_plot(Pbez,np,'b-.');
curv2_bezier_plot(Pbez1,np,'y-.');
curv2_bezier_plot(Pbez2,np,'g-.');
curv2_bezier_plot(Pbez3,np,'r-.');