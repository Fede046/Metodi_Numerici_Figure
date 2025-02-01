function bs=newton(g,qx,x)
% calcola le funzioni base definite a partire dai punti qx su un punto x;
% se x e' un vettore torna una matrice; in ogni riga ci sono
% i valori delle funzioni base in un punto.
% g  --> grado del polinomio
% x  --> vettore punti di valutazione
% qx --> vettore punti su cui costruire la base
% bs <-- matrice delle funzioni di Newton nei punti

m=length(x);
n=g+1;
bs=zeros(m,n);
for k=1:m
 bs(k,1)=1;
 for i=1:g
     bs(k,i+1)=prod(x(k)-qx(1:i));
  end
end