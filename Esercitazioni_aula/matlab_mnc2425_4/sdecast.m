%script che richiama def_pol e valuta i polinomi nella base
%di Bersntein con Alg.2
clear all
close all

ex=3;
[g,cP,cB]=def_pol(ex);

%definizione polinomio nella base di Bernstein
p.deg=g;
p.ab=[0,1];
p.cp=cB';

% numero dei punti di valutazione in [0,1]
np = 100;
t = linspace(0,1,np)';

% valutazione polinomio nella base monomiale (polyval di MATLAB)
 yP = polyval(fliplr(cP),t);
   

% valutazione polinomio nella base di Bernstein
% funzione decast_val del toolbox anmglib_4.1
% Alg.2

%TO DO

yB=decast_val(p,t)

figure('Name','Polinomio test')
plot(t,yB,'-','Color','b','LineWidth',1.5)
title('Polinomio test','FontWeight','bold')
 hold on
plot(t,yP,'--','Color','r','LineWidth',1.5)
 legend('p_P(x)','p_B(x)')


