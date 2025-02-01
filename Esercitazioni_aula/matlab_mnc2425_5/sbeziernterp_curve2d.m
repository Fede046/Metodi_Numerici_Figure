%main di esempio di interpolazione di curve 2D con curve di Bezier
clear all
close all

col=['r','g','b','k'];
open_figure(1);
axis_plot(10,1.0);

%definire curva 2D analitica da ricostruire per interpolazione
%si utilizza la curva definita nella function c2_curv3_pol.m
%intervallo parametrico di definizione
a = 0;  
b = 10;

%plotting della curva analitica
np=150;
[x,y]=curv2_plot('c2_curv3_pol',a,b,np,'b',1.5);

%setting numero punti di valutazione/grado+1 del polinomio
n=8;
%distribuzione parametri di interpolazione
%trova un parametro
tpar=chebyshev2(a,b,n);

%campionamento curva nei parametri di interpolazione 
[xp,yp]=c2_curv3_pol(tpar);
Q=[xp',yp'];

%disegno punti di interpolazione
point_plot(Q,'ko',1,'k');

%definizione curva di Bézier
Pbez.deg = n-1;
Pbez.ab(1) = 1;
Pbez.ab(2) = 0;

%cambio di variabile
tpar=(tpar-a)/(b-a);

%calcolo matrice del sistema lineare
B=bernst_val(Pbez.deg,tpar);

%soluzione dei sistemi lineari
Pbez.cp=B\Q;

%disegno curva interpolante
xy=curv2_bezier_plot(Pbez,np,'r--',1.5);

%calcola la distanza euclidea fra i punti della curva test e
%della curva di Bézier interpolante e considera la distanza massima
MaxErr=max(sqrt((xy(:,1)'-x).^2+(xy(:,2)'-y).^2));
fprintf('MaxErr: %e\n',MaxErr);

% %disegno poligonale di controllo
% point_plot(Pbez.cp,[col(3),'-o'],1,'k');

%come calcolare un errore tra la curva e la sua i nterpolazione?