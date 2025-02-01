function y=newtval(a,x,xv)
% valutazione di un polinomio nella forma di Newton; metodo di Horner
% modificato
% a --> vettore dei coefficienti
% x --> vettore dei punti in base ai quali restano determinati
%       i polinomi elementari di Newton
% xv --> vettore di ascisse in corrispondenza delle quali 
%        si vuole valutare il polinomio
% y <-- vettore dei valori del polinomio
n=length(x);
y=a(n)*ones(size(xv));
for i=n-1:-1:1
  y=y.*(xv-x(i))+a(i);
end
