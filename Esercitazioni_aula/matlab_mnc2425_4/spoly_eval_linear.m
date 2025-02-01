%script spoly_eval_linear.m
% Errore inerente nella valutazione polinomiale
% d : vettore dei coefficienti (da quello di potenza massima a quella
%     minima)
% a,b : estremi intervallo di definizione
% viene prodotto il grafico della funzione polinomiale nell'intervallo
clc
clear all
close all

%settare gc per selezionare i diversi casi
gc=1;
switch gc
    case 1 % coefficienti numeri finiti, la discretizzazione no
       d=[100,-1];
       d=fliplr(d);  a=100;  b=101;
    case 2 % a_0 non finito, a_1 e discretizzazione si
       d=[99.9,-1];
       d=fliplr(d);  a=100;  b=101;
    case 3 % a_1 non finito, a_0 e discretizzazione si 
       d=[100,-1.001];
       d=fliplr(d);  a=100;  b=101;
    case 4 % a_0, a_1 e discretizzazione sono numeri finiti
       d=[100,-1];
       d=fliplr(d);  a=100;  b=101;
end

%punti equispaziati
if gc==1
    m=51;
    x=linspace(a,b,m);
else
%altri set di punti
    %x=[7.3022, 9.8638, 12.3316, 13.5024];

    % h=0.000244140625;
    % x=a:h:b;

    % h=2^-5;
    % x=a:h:b;

    h=2^-7;
    x=a:h:b;

    m=length(x);
end

c=d;
sc=single(c);
sx=single(x);

%Matlab function polyval
% y=polyval(c,x);
% sy=polyval(double(sc),double(sx));

%nostra function poly_eval
y=poly_eval(c,x);
sy=poly_eval(double(sc),double(sx));

figure(1);
hold on;
plot(x,y,'r.-','LineWidth',1.5);
plot(x,zeros(1,m),'k-','LineWidth',1.5);
title('Grafico funzione polinomiale');

figure(2);
relerr=abs((sy-y)./y);
plot(x,relerr,'b.-');
title('Grafico Errore Inerente');

figure(3)
relx=abs((sx-x)./x);
plot(x,relx,'r.-');
title('Grafico Errore sui Dati x');

relc=abs(c-sc)./c;
fprintf('RelErr sui coeff. c: %e %e \n',relc);