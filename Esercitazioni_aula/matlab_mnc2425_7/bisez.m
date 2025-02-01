function [xstar,n,ab]=bisez(fun,a,b,tol,ftrace)
%***********************************************************
% [xstar]=sbisez(fun,a,b,tol)
% questa routine determina uno zero di una funzione con 
% il metodo di bisezione
% fun    --> handle della funzione
% a,b    --> intervallo di innesco della funzione
% tol    --> tolleranza richiesta
% xstar  <-- approssimazione dello zero
  if ((a<0) & (b>0) & (feval(fun,0)==0))
    xstar=0;
  else
   fa=fun(a);
   fb=fun(b);
   n=0;
    while (abs(b-a)>(tol+eps.*min([abs(a),abs(b)]))) 
        xm=a+(b-a)./2;
     fxm=fun(xm);
     if (sign(fa)==sign(fxm))
       a=xm;
       fa=fxm;
     else
       b=xm;
       fb=fxm;
     end
    if (ftrace==1)
    n=n+1;
    ab(n,1)=a;
    ab(n,2)=b;
    end
    end
    xstar=a+(b-a)./2;
    end

