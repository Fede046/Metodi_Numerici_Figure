% script spolint_lagr_dati.m
% Interpolante polinomiale di un set di dati: forma di Lagrange;
% viene prodotto il grafico del data set e del polinomio interpolante
clear all
close all

A=load('dataset1.dat');
[n m]=size(A);
x=A(1:n,1)';
y=A(1:n,2)';

%definire il grado del polinomio interpolante
g=n-1;

%definire gli estremi dell'intervallo di interpolazione
a=min(x);
b=max(x);

%Metodo di interpolazione: forma di Lagrange

%calcolo del polinomio interpolante nella forma di Lagrange
%i coefficienti sono le y_i
%punti di interpolazione

%punti su cui valutare l'interpolante polinomiale per il grafico
xv=linspace(a,b,50)

%valutazione polinomio interpolante mediante II forma baricentrica
%(vedi function lagrval2.m)
yv=lagrval2(y,x,xv)

%grafico dati (x,y) e valori polinomio interpolante (xv,yv)
figure(1)
plot(x,y,'ko','LineWidth',2);
hold on;
plot(xv,yv,'r-','LineWidth',2);
