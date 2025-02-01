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