%programma conv_bin2dec.m
%************************************************
%Programma per la conversione da base 2 a base 10
%di un numero in virgola
%************************************************
clear all
disp('Converte un reale (parte intera e frazionaria) da base 2 a base 10');
z=input('dai il numero binario in virgola: ','s');
%k=input('dai il numero max. di cifre per la parte frazionaria: ');
n=strfind(z,'.');
z1=z(1:n-1);
z2=z(n+1:length(z));
x=bin2dec(z1);

b=0.5;
y=0;
for i=1:length(z2)
 y=y+(z2(i)-48)*b;
 b=0.5*b;
end

fprintf('Il numero in base 10 e'':\n');
%Stampa parte intera e frazionaria
   fprintf('%21.16e \n',x+y);
fprintf('\n');
