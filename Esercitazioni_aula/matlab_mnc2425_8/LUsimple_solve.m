function [x]=LUsimple_solve(LU,b)
%Input:
%LU : contiene la matrice triangolare inferiore L
%     e la matrice triangolare superiore U
%b : termine noto
%Output:
%x : soluzione

n=length(b);
%sostituzioni in avanti
for j=1:n-1
    for i=j+1:n
        b(i)=b(i)+LU(i,j)*b(j);
    end
end

%sostituzioni all'indietro
x=zeros(n,1);
for i=n:-1:2
  x(i)=b(i)/LU(i,i);
  for j=1:i-1
    b(j)=b(j)-LU(j,i)*x(i);
  end
end
x(1)=b(1)/LU(1,1);
  
