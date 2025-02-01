%main di esempio per il calcolo dell'area di
%una curva 2D di Bezier
clear all
close all

open_figure(1);
axis_plot(3);

a=0; b=1;
bezP.cp=[1,1;1,2;2,2;3,-1;0,0;0,1;1,1];
bezP.deg=length(bezP.cp(:,1))-1;
bezP.ab = [a b];

%disegno della curva e relativi cp
curv2_bezier_plot(bezP,40,'b',2);
point_plot(bezP.cp,'k-o',1);

%calcolo area della curva e stampa
val=integral(@(x)cxc1_val(bezP,x),a,b);
if (val < 0)
    bezP.cp=flip(bezP.cp);
    val=-val;
end
%val = curv2_ppbezier_area(bezP)
fprintf('Area della curva: %e\n',val); 