function [y]=lsolve(L,b)
%Input:
%L : matrice triangolare inferiore
%b : termine noto
%Output:
%y : soluzione
n=length(b);
y=zeros(n,1);
y(1)=b(1)/L(1,1);
for i=2:n
  y(i)=b(i);
  for j=1:i-1
    y(i)=y(i)-L(i,j)*y(j);
  end
  y(i)=y(i)/L(i,i);
end
