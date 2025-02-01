%Matrice di mat_2
function a=mat_2(n)

 for j=1:n
    a(1,j)=1.0;
 end
 for i=1:n
     for j=1:n
           a(i,j)=1.0/(i+j+1.0);
     end
 end

