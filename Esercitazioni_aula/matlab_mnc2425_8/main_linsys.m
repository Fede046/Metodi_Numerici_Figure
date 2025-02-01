%main_linsys da completare per risolvere un sistema lineare Ax=b

%si chiama una funzione che definisce una matrice test
A=mat_es_2;

%sia n x m la sua dimensione
[n,m]=size(A);

if (n==m)
    
    %si definisce un vettore xx soluzione
    xx=ones(n,1);

    %si determina il vettore dei termini noti
    b=A*xx;

    %stampa della matrice A e del vettore dei termini noti b
    disp(A)
    disp(b)

    %1.si risolve il sistema lineare utilizzando l'operatore left division
    xld=A\b;

    %si stampa la soluzione xld
   disp(xld)

    %2.si fattorizza la matrice A usando la function Matlab lu()
    [L,U,P]=lu(A);
    disp(L)
    disp(U)
    disp(P)
    %si risolvono i due sistemi piu' semplici usando le function 
    %lsolve() e usolve() presenti nella cartella
    y=lsolve(L,P*b);
    x=usolve(U,y);

    %si stampa la soluzione x del sistema lineare
    disp(x)

end