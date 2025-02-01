%Script scompute_u.m
%**************************************************
%gestisce sia il caso BASIC single che BASIC double
%flag=0 per BASIC single
%flag=1 per BASIC double
%**************************************************
clear all
clc

%cambiare il flag
flag=0;

if (flag==0)
%****************************************************
%calcolo dell'unita' di arrotondamento via
%caratterizzazione o def. operativa.
%Ricordiamo la definizione esplicita:
%BASIC single   F(2,24,-127,128)    U = 0.5* 2^(1-24)
%****************************************************
    %stampa di u
    u =2^(-24);
    fprintf('Explicit definition: u = 2^(-24)\n');
    fprintf('%20.15e \n',u);

    %Implementazione definizione operativa
    u=single(1);
    t=0;
    while(1+u > 1)
        u=u/2;
        t=t+1;
    end
   
    fprintf('Largest Finite and Positive Number u such that u+1==1\n');
    fprintf('%13.8e\n',u);
    fprintf('Exponent -%d\n',t);

end

if (flag==1)
%******************************************************
%calcolo dell'unita' di arrotondamento via
%caratterizzazione o def. operativa.
%Ricordiamo la definizione esplicita:
%BASIC double   F(2,53,-1023,1024)    U = 0.5* 2^(1-53)
%******************************************************
    %stampa di u
    u = 2^(-53);
    fprintf('Explicit definition: u = 2^(-53)\n');
    fprintf('%20.15e \n',u); 	

    %Implementazione definizione operativa
    u=1;
    t=0;
    while(1+u > 1)
        u=u/2;
        t=t+1;
    end
 
    fprintf('Largest Finite and Positive Number u such that u+1==1\n');
    fprintf('%20.15e\n',u);
    fprintf('Exponent -%d\n',t);

end