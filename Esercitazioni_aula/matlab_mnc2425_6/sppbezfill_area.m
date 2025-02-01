%main di esempio per visualizzazione figura composta da più
%curve di Bezier a tratti
clear all
close all

open_figure(1);
axis_plot(1,0.125);

dis=load_geom('a57.dat');

ns=length(dis);
%disegna quanto caricato dalla load_geom
for k=1:ns
    ppP=dis{k,1};
    Px=curv2_ppbezier_plot(ppP,-40);
    point_fill(Px,dis{k,2});
end 

%divido la curva a singole bez e calcolo l'area


n=ppP.deg;
[ncp,~]=size(ppP.cp);
np=(ncp-1)/n;

%estrae le singole curve di Bézier
%trovato il vettore tangentenmi dice la direzione della curva
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
    curv2_bezier_plot(bezP,40,'bo-',2);
    %disegna poligono a tratti
    point_plot(bezP.cp,'ko-',1);
    %curv2_bezier_tan_plot(bezP,2,'r-',2,'r','r',4);
    val = val + integral(@(x)cxc1_val(bezP,x),bezP.ab(1),bezP.ab(2));
        val1 = curv2_ppbezier_area(bezP);

end
fprintf('Area della curva: %e\n',-val); 
%val rappresenta l'area di un petalo
%per calcolare l'area dei petali rossi, moltiplico per 3 val


%fprintf('Aree rosse: %e\n',-3*val); 


