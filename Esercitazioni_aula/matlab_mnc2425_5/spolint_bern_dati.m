% script spolint_bern_dati.m
% Interpolante polinomiale di un set di dati: forma di Newton;
% viene prodotto il grafico del data set e del polinomio interpolante
clear all
close all

A=load('dataset2.dat');
[n m]=size(A);
x=A(1:n,1)';
y=A(1:n,2)';

%definire il grado del polinomio interpolante
g=n-1;

%definire gli estremi dell'intervallo di interpolazione
a=min(x);
b=max(x);
%Metodo di interpolazione: forma di Bernstein
%cambio di variabile e calcolo della matrice B del sistema lineare
t=(x-a)/(b-a);
B=bernst_val(g,t);
disp(B);


%i coeff. del polinomio sono la soluzione del sistema lineare
%utilizziamo l'operatore left division di Matlab
c=B\y';
disp(c)

%definiamo un polinomio nella base di Bernstein secondo la anmglib_4.1
bern.deg=g;
bern.cp=c;
bern.ab=[a,b];

%punti su cui valutare l'interpolante polinomiale per il grafico
xv=linspace(a,b,50)


%valutazione polinomio interpolante mediante Horner (vedi function decast_val.m)
yv=decast_val(bern,xv)

%grafico dati (x,y) e valori polinomio interpolante (xv,yv)
figure(1)
plot(x,y,'ko','LineWidth',1.5);
hold on;
plot(xv,yv,'r-','LineWidth',2);
