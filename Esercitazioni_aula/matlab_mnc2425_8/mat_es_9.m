%matrice di esempio
%per h=1 OK, 
%per h=0 singolare, 
%per h circa uguale ad 2*eps problemi di stabilita' della fatt. LU
function A=mat_es_9(h)
A=[ 1,    1,  1;
    2,  2+h,  5;
    4,    6,  8];
end

