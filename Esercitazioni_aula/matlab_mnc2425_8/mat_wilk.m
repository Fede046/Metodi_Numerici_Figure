%matrice test di Wilkinson
function a=mat_wilk(n)
 for i=1:n-1
     a(i,i+1)=1.0;
     a(i+1,i)=1.0;
 end

 c=n/2.0;
 for i=1:n/2
    a(i,i)=c;
    a(n-i,n-i)=c;
    c=c-1;
 end
