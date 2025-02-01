%main di esempio per visualizzazione curva di Bezier a tratti
clear all
close all

col=['r','g','b','k','m','c','y','k','r','g','b','k','m','c','y'];
open_figure(1);
axis_plot(1,0.125);

% ppP=curv2_ppbezier_load('ppbez_esse.db');
ppP=curv2_ppbezier_load('ppbez_square_smooth.db');
% disegna la curva a tratti e la poligonale
curv2_ppbezier_plot(ppP,40,'b',2);
% point_plot(ppP.cp,'r-o',1.5);

%recupera il primo tratto di Bézier della curva
n=ppP.deg;
[ncp,~]=size(ppP.cp);
np=(ncp-1)/n;
%estrae e disegna il primo tratto di Bézier
bezP.deg=n;
bezP.cp=ppP.cp(1:n+1,:);
bezP.ab=[ppP.ab(1) , ppP.ab(2)];
% disegna tangente nel primo e ultimo punto del primo tratto
point_plot(ppP.cp(1,:),'m-o',1.5);
%uso la funzione della libreria curv2_bezier_tan_plot
Px = curv2_bezier_tan_plot(bezP,2,'r-',9)
% Px=decast_valder(bezP,1,0)
vect2_plot([Px(1,1,1),Px(1,1,2)],[Px(2,1,1),Px(2,1,2)],col(1),1,col(1),col(1),1,0.025);
val = curv2_ppbezier_area(ppP) %se è positiv a curva orientata in senso antiorario
vect2_plot([Px(1,2,1),Px(1,2,2)],[Px(2,2,1),Px(2,2,2)],col(1),1,col(1),col(1),1,0.025);


%ciclo for
bezP.deg=n;

for i = 1 :np

    i1=(i - 1)*n+1;
    i2=i1+n;
    bezP.cp=ppP.cp(i1:i2,:);
    bezP.ab=[0 1];%ppP.ab(i:i+1);

    point_plot(ppP.cp(i,:),'m-o',1.5);
    point_plot(ppP.cp(ncp-i,:),'m-o',1.5);

    Px=decast_valder(bezP,1,0);
    vect2_plot([Px(1,1,1),Px(1,1,2)],[Px(2,1,1),Px(2,1,2)],col(i),1,col(i),col(i),1,0.025);


end


