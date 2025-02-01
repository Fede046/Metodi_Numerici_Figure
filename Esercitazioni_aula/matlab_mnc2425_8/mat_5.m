%Matrice di mat_5
function A=mat_5(n)

A=eye(n);
A(1,n)=1;
for i=2:n
     A(i,n)=1;
     for j=1:i-1
       A(i,j)=-1;
     end
 end
