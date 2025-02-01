%main di esempio di interpolazione polinomiale
%con curve di Bezier a tratti
clear all
close all

col=['r','g','b','k'];
open_figure(1);
axis_plot(1.5,0.125);
axis equal

%Punti della curva da interpolare campionati da una circonferenza
%a parametri equispaziati
m=5;
a=0;  
b=2*pi;
tpar=linspace(a,b,m);
[xp,yp,xp1,yp1]=cp2_circle(tpar);
Q=[xp',yp'];
Q1=[xp1',yp1'];

%disegna i punti di interpolazione
point_plot(Q,'ko',1,'k');

%chiama la funzione per interpolare valori e derivate
ppP = curv2_ppbezierCC1_interp_der(Q,Q1,tpar);

%disegna curva di bezier a tratti di interpolazione
np=41;
Pxy=curv2_ppbezier_plot(ppP,np,[col(1),'-'],2);

%Calcolo dell'errore tratto per tratto
%calcola la distanza euclidea fra i punti della curva test
%e la curva di Bézier cubica a tratti interpolante e considera
%la distanza massima
MaxErr=0;
for i=1:m-1
    [x,y]=curv2_plot('cp2_circle',tpar(i),tpar(i+1),np,[col(2),'--'],2);
    i1=(i-1)*np+1;
    i2=i*np;
    err=max(sqrt((Pxy(i1:i2,1)'-x).^2+(Pxy(i1:i2,2)'-y).^2));
    if (err > MaxErr)
        MaxErr=err;
    end
end
fprintf('MaxErr: %e\n',MaxErr);

%disegna poligonale di controllo della curva di Bezier a tratti
point_plot(ppP.cp,[col(3),'-o'],1,'k');

