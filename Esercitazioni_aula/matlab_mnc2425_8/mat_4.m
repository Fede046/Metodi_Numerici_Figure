%Matrice di mat_4
function a=mat_4(n)

 for i=1:n
     for j=1:n
           if (i>=j)
	     a(i,j)=i;
           else
             a(i,j)=j;
           end
     end
 end
