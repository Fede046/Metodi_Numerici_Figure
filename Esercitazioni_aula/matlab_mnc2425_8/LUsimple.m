%*******************************************************************
%* Fattorizza una matrice in LU con L triangolare inferiore e U    *
%* triangolare superiore usando il metodo di eliminazione di Gauss.*
%* input : A matrice da fattorizzare                               *
%* output: A matrice contenente le informazioni sulla L e la U     *
%*         sing (0) la matrice non e' singolare, (1) e' singolare  *
%*******************************************************************
function [A,sing]=LUsimple(A)

  [m,n]=size(A);
  sing = 0;
  k = 1;
  while ((~sing) & (k<n)) 
    if(A(k,k) ~= 0.0)
      A(k+1:n,k)=-A(k+1:n,k)./A(k,k);
      for j=k+1:n
        if(A(k,j) ~= 0.0)
          for i=k+1:n
            A(i,j) = A(i,j) + A(i,k) .* A(k,j);
          end
        end
      end
    else
      sing = 1;
      return
    end
    k=k+1;
  end
  if(abs(A(n,n)) <= 1.0e-15)
    sing = 1;
  end
