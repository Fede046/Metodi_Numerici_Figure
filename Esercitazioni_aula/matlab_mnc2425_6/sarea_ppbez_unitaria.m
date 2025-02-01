%main di esempio per visualizzazione curva di Bezier a tratti
clear all
close all
col=['r','g','b','k','m','c','y','r','g','b','k','m','c','y'];
open_figure(2);
axis_plot(2.25,0.125);

%curva da file
ppP=curv2_ppbezier_load('ppbez_square_smooth.db');
%disegno della curva a tratti
np=20;
curv2_ppbezier_plot(ppP,np,'b-',2);

n=ppP.deg;
[ncp,~]=size(ppP.cp);
np=(ncp-1)/n;

%estrae le singole curve di Bézier

n=ppP.deg;

[ncp,mcp] =size(ppP.cp);
ppP
np = (ncp - 1)/n
aa = length(ppP.cp)
%disegna i tratti della curva e negli estremi dei tratti la tangente
bezP.deg = n;
val = 0;
for i = 1:np
    i1=(i - 1)*n+1;
    i2=i1+n;
    bezP.cp=ppP.cp(i1:i2,:);
    bezP.ab=ppP.ab(i:i+1);
    %disegna tratto
    %curv2_bezier_plot(bezP,40,col(i),2);
    %disegna poligono a tratti
    %point_plot(bezP.cp,[col(i),'-o'],1);
    %curv2_bezier_tan_plot(bezP,2,'r-',2,'r','r',4);
    val = val + integral(@(x)cxc1_val(bezP,x),bezP.ab(1),bezP.ab(2));
        val1 = curv2_ppbezier_area(bezP);

end
fprintf('Area della curva: %e\n',val); 
fprintf('area della curva con curvarea: %e\n',val1);


if (val < 0)

    %curv2_ppbezier_plot(ppP,60,'r');
    ppP=curv2_ppbezier_reverse(ppP);
    %curv2_ppbezier_plot(ppP,60,'b');

    val=-val;
end
%fprintf('area della curva: %e\n',val); 

%scaliamo ora la curva affinché abbia area unitaria
%la scala sia effettuata rispetto al baricentro
s=sqrt(1/val);

M=get_mat_scale([s,s]);
ppP.cp=point_trans(ppP.cp,M);

%calcolare nuovamente l'area della curva scalata
%estrae le singole curve di Bezier e calcola la loro lunghezza

bezP.deg = n;
val = 0;
for i = 1:np
    i1=(i - 1)*n+1;
    i2=i1+n;
    bezP.cp=ppP.cp(i1:i2,:);
    bezP.ab=ppP.ab(i:i+1);
    %disegna tratto
    %curv2_bezier_plot(bezP,40,col(i),2);
    %disegna poligono a tratti
    %point_plot(bezP.cp,[col(i),'-o'],1);
    %curv2_bezier_tan_plot(bezP,2,'r-',2,'r','r',4);
    val = val + integral(@(x)cxc1_val(bezP,x),bezP.ab(1),bezP.ab(2));
    val1 = curv2_ppbezier_area(bezP);
end

fprintf('area della curva: %e\n',val);
fprintf('area della curva con curvarea: %e\n',val1);

%per calcolare l'area con utilizzare la funzione curv2_ppbezier_area
%utilizzare il metodo del prof