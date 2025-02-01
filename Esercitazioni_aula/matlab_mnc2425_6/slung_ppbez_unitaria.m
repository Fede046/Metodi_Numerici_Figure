%main di esempio per visualizzazione curva di Bezier a tratti
clear all
close all
col=['r','g','b','k','m','c','y','r','g','b','k','m','c','y'];
open_figure(2);
axis_plot(2.25,0.125);

%curva da file
ppP=curv2_ppbezier_load('ppbez_corona.db');
%disegno curva a tratti
curv2_ppbezier_plot(ppP,60,'r');
n=ppP.deg;
[ncp,~]=size(ppP.cp);
np=(ncp-1)/n;
val =0;
%estrae le singole curve di Bezier e calcola la loro lunghezza
bez.deg=ppP.deg;
for i=1:np
   vcol=col(mod(i,7)+1);
   i1=(i-1)*ppP.deg+1;
   i2=i1+ppP.deg;
   bez.cp=ppP.cp(i1:i2,:);
   bez.ab=[ppP.ab(i),ppP.ab(i+1)];
   curv2_ppbezier_plot(bez,50,'r',2);
   val =val+integral(@(x)norm_c1_val(bez,x),bez.ab(1),bez.ab(2));
end

% TO DO

fprintf('Lunghezza della curva: %e\n',val);

%scaliamo ora la curva affinché abbia lunghezza unitaria
%la scala sia effettuata rispetto al baricentro
s=1/val;


% TO DO
M=get_mat_scale([s,s]);
ppP.cp=point_trans(ppP.cp,M);



%calcolare nuovamente la lunghezza della curva scalata
%estrae le singole curve di Bezier e calcola la loro lunghezza
val = 0;
bez.deg=ppP.deg;
for i=1:np
   vcol=col(mod(i,7)+1);
   i1=(i-1)*ppP.deg+1;
   i2=i1+ppP.deg;
   bez.cp=ppP.cp(i1:i2,:);
   bez.ab=[ppP.ab(i),ppP.ab(i+1)];
   curv2_ppbezier_plot(bez,50,'r',2);
   val =val+integral(@(x)norm_c1_val(bez,x),bez.ab(1),bez.ab(2));
end

% TO DO

fprintf('Lunghezza della curva: %e\n',val)