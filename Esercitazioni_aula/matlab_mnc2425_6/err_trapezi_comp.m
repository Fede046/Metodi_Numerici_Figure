function err_trapezi_comp(funz,a,b,n)
% Funzione che approssima l'integrale definito di una
% funzione mediante la formula dei trapezi composta e
% calcola l'errore.
% funz --> stringa contenente della funzione integranda
% a,b --> estremi di integrazione
% n    --> numero di sottointervalli
% Viene prodotta una stampa
   
  if ischar(funz)
    fun=str2func(funz);
  else
    fun=funz;
  end
  I=integral(fun,a,b);
  fprintf('valore I= %22.15e\n',I);
  
  fprintf('n     h             IA               AbsErr\n');
   m=11;
   for i=1:m
    n=2^(i-1);
  h=(b-a)/n;
  IA=trapezi_comp(fun,a,b,n,1);

  AbsErr=abs(IA-I);
  fprintf('%d %9.3e %22.15e %9.3e \n',n,h,IA,AbsErr);
if(i<1)

    fprintf('%9.3e \n',AbsErr(i-1)/Abs(i));
else
    fprintf('\n');
end



   end


  
