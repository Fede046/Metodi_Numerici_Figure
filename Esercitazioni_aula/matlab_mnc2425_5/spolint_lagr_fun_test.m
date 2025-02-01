% script spolint_lagr_fun.m
% Interpolante polinomiale di grado n di una funzione test:
% si utilizza la forma di Lagrange;
% definire la funzione test e settare
% n      : grado del polinomio interpolante
% tipo   : tipo di distribuzione dei punti 1=equispaziati 2=chebyshev
% Viene prodotto il grafico della funzione test, del polinomio 
% interpolante e dei punti di interpolazione
clear all
close all

%definire la funzione test: vedere le funzioni test presenti nella cartella
%funzione test ed estremi intervallo di definizione
fun = @(x) runge(x);
a = -5;
b = 5;
%la convergenza la vedremo all'aumentare di n, per avere una ricostruzione 
%di punti opportuna
%definisce grado del polinomio e punti di interpolazione
n=40;
tipo=2;
switch (tipo)
    case 1
%n+1 punti equispaziati
       x=linspace(a,b,n);
    case 2
        %la nostra funzione all'aumente di n nel tipo 2 fino ad arrivare
        % a una convergenza (le cose coincidono) 
        %aumentando n riduciamo gli arroni di interpolazione, non c'è
        %errore analitico, neppure inernete(numerici),
        % quindi sono solo err num ma molti piccoli e un err alg che ripicciolisce 
        % n= indica ail grado quindi aumentando n io ho un grado sempre più
        % alto
%n+1 punti secondo la distribuzione di Chebyshev
      x=chebyshev2(a,b,n-1);
end

%osservazioni campionate dalla funzione test
%y=fun3(x);
y=fun2(x);
%y=fun1(x);
%punti su cui valutare l'interpolante polinomiale modo 1
m=51;
xv=linspace(a,b,m*n+1);

% %punti su cui valutare l'interpolante polinomiale modo 2
% in=0;
% for i=1:n
%    xv(in+1:in+m)=linspace(x(i),x(i+1),m);
%    in=in+m-1;
% end

% Lin=lagrange(n,x,xv);
% CI=sum(abs(Lin'));
% % size(CI)
% %grafici
% figure(10)
% plot(xv,CI,'k-','LineWidth',2);

%Metodo di interpolazione: forma di Lagrange
%i coeff. sono i dati valutazione nella II forma di Lagrange

%valutazione mediante II forma baricentrica
%lagrange
yv=lagrval2(y,x,xv)

%apertura finestra per grafico funzione analitica e interpolante
figure(1);
hold on;

%valori funzione test nei punti di valutazione
yf=fun(xv);

%disegno punti di interpolazione
plot(x,y,'ro');

%grafico funzione test
plot(xv,yf,'r-','LineWidth',2);

%grafico polinomio interpolante
plot(xv,yv,'g-','LineWidth',2);

%errore di interpolazione in valore assoluto
yerr=abs(yf-yv);

%grafico errore analitico e stampa errore max in [a,b]
figure(2);
hold on
plot(xv,yerr,'g-','LineWidth',2);

%grafico errore analitico in scala logaritmica e stampa errore max in [a,b]
figure(3);
semilogy(xv,yerr,'g-','LineWidth',2);

%stampa max errore di interpolazione in valore assoluto
fprintf('Errore interpolazione: %22.15e\n',max(yerr));
