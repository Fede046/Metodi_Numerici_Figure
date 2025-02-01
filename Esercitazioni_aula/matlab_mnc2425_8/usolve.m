function [x]=usolve(U,y)
%Input:
%U : matrice triangolare superiore
%y : termine noto
%Output:
%x : soluzione
n=length(y);
x=zeros(n,1);
for i=n:-1:2
  x(i)=y(i)/U(i,i);
  for j=1:i-1
    y(j)=y(j)-U(j,i)*x(i);
  end
end
x(1)=y(1)/U(1,1);
