%zeri di polinomi nella base di Bernstein
clear all
close all

%definizione funzione polinomiale zfun05 nella base di Bernstein
%struttura fBezier
a=-2.5; b=2;
fb.deg=3;
fb.ab=[a,b];
%fb.cp = [linspace(a,b,4)',zfunf05(linspace(a,b,4))']
fb.cp=[-6.125; 17.5; -9.5; 4];
fb.cp
% numero di punti di valutazione in [a,b]
np = 100;
x = linspace(a,b,np);
yB=decast_val(fb,x);
figure('Name','Funzione polinomiale test')
hold on;
plot(x,yB,'-','Color','g','LineWidth',1.5)
plot([a,b],[0,0],'k-')
title('Polinomio test','FontWeight','bold')

%definisce la funzione come curva e disegna 
%i punti di controllo

%TO DO

fprintf('Lista delle radici trovate nell''intervallo:\n');
%determina, stampa e disegna gli zeri della funzione
%utilizzando la function bezier_clipping o lane_riesenfeld 
%della libreria anmglib_4.1
TOL=1.0e-7;
rootsx = lane_riesenfeld(fb,TOL);
fprintf('zero della funz:%e\n',rootsx);
%TO DO

plot(rootsx,zeros(1,length(rootsx)),'r+');
