function x=chebyshev( a,b,n )
%input:
%  a,b --> estremi intervalo in cui mappare i punti
%  n+1 --> numero di zeri del polinomio di Chebyshev di grado n+1 
%punti di Chebishev prima specie
for i=0:n
  x(i+1)=0.5.*(a+b)+0.5.*(a-b).*cos((2.*i+1).*pi./(2.*n+2));
end
end

