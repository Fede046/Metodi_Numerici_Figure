%main script iniziale da completare
fprintf('mat_k  nxn         max|l_ij|     max|r_ij|    2^(n-1)max|a_ij|\n');
fprintf('mat_k  nxn         max|l_ij|     max|r_ij|    2^(n-1)max|a_ij|\n');
nn=[5,10,50];
for n=nn
    for k=2:5

        switch k
            case 2
               A=mat_2(n);
            case 3
               A=mat_3(n);
            case 4
               A=mat_4(n);
            case 5
               A=mat_5(n);
        end
              
        %si fattorizza la matrice A
        [L,U,P]=lu(A);
        [L,U,P]=qr(A);

        %massimo degli elementi di L in valore assoluto
        maxl=max(max(abs(L)));
                %maxl=max(max(abs(L)));

        %massimo degli elementi di U in valore assolut
        maxu=max(max(abs(U)));
               %maxr=max(max(abs(R)));

        bound=2^(n-1)*max(max(abs(A)));
        bound=sqrt(n)*maxa;

        fprintf('%5d %2dx%2d  %14.5f  %14.5e  %14.5e\n',k,n,n,maxl,maxu,bound);
    end
end                
