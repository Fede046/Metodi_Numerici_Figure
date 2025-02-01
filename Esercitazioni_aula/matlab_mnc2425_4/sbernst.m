%script che richiama def_pol e valuta i polinomi nella base di 
%Bernstein con Alg.1
addpath ../anmglib_4.1
clear all
close all

ex=2;
[g,cP,cB]=def_pol(ex);

% numero dei punti di valutazione in [0,1]
np = 100;
%t = linspace(0,1,np)';

% valutazione polinomio nella base monomiale (polyval di MATLAB)
% yP = polyval(fliplr(cP),t);

% valutazione polinomio nella base di Bernstein
% funzione bernst_val del toolbox anmglib_4.1
% Alg.1

a=0;b=16;
x=linspace(a,b,np)';
t=(x-a)./(b-a);

B = bernst_val(g,t)
size(B)

yB=cB*B';

figure('Name','Polinomio test')
plot(x,yB,'-','Color','g','LineWidth',1.5)
title('Polinomio test','FontWeight','bold')
%hold on
% plot(t,yP,'--','Color','r','LineWidth',1.5)
% legend('p_P(x)','p_B(x)')
