clear all
close all
%main di esempio per il calcolo della lunghezza di
%una curva 2D di Bezier
open_figure(1);
axis_plot(2.5,0.25);

%definizione curva 2D di Bezier
a=0; b=1;
bezP.cp=[0,1;1,2;2,1;1,0];
bezP.deg=length(bezP.cp(:,1))-1;
bezP.ab = [a b];

%disegno della curva e relativi cp
curv2_bezier_plot(bezP,40,'b',2);
point_plot(bezP.cp,'k-o',1);

%calcolo lunghezza della curva e stampa 
%ottima per calcolare il perimetro della fi
val=integral(@(x)norm_c1_val(bezP,x),a,b);
fprintf('Lunghezza della curva: %e\n',val); 