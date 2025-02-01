%script che richiama def_pol e valuta i polinomi con Alg.1
%e sua derivata prima
clear all
close all

ex=3;
[g,~,cB]=def_pol(ex);

% numero dei punti di valutazione in [0,1]
np = 100;
t = linspace(0,1,np)';

% valutazione polinomio nella base di Bernstein
% funzione bernst_valder del toolbox anmglib_4.0

[bs,bsp] = bernst_valder(g,t);

yB = bs*cB';
yBp = bsp*cB';

figure('Name','Polinomio test e derivata')
hold on
plot(t,yB,'-','Color','r','LineWidth',1.5)
plot(t,yBp,'-','Color','g','LineWidth',1.5)
title('Polinomio test','FontWeight','bold')
legend('p_P(x)','p_P''(x)')
