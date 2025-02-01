%main_stab_lufact script da completare

%si chiama funzione che definisce una matrice test
A=mat_es_7();

%si determina la sua dimensione n
[n,m]=size(A);

%stampa della matrice A
fprintf('%e %e\n',A);

%si definisce il vettore dei termini noti
b=[1 ; 2];

%si fattorizza la matrice A con scambio delle righe e perno massimo
% TO DO
[L,U,P]=lu(A);

%si risolvono i sistemi tiangolare inferiore e superiore
y=lsolve(L,P*b);
x1 = usolve(U,y);

%si stampa la soluzione x1
fprintf('fattorizzazione con scambio delle righe e perno massimo\n');
fprintf('%e \n',x1);

%si fattorizzi la matrice A usando la function LUsimple
% TO DO
[LU,sing]=LUsimple(A);

%si risolva il sistema lineare usando la function LUsimple_solve

% TO DO
[x2]=LUsimple_solve(LU,b);

fprintf('fattorizzazione senza scambio di righe\n');
fprintf('\n');
%si stampa la soluzione x2
fprintf('%e \n',x2);
