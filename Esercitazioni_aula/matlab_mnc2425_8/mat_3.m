%Matrice di mat_3
function a=mat_3(n)
 for i=1:n
     for j=1:i
           a(i,j)=n-1-i;
           a(j,i)=a(i,j);
     end
 end
