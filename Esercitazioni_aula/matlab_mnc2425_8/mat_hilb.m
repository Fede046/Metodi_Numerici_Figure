%Matrice test di Hilbert
function a=mat_hilb(n)

 for i=1:n
     for j=1:n
           a(i,j)=1.0/(i+j-1.0);
     end
end
