%script scircle_plot.m
%genera il disegno di una circonferenza di centro l'rigine e raggio 5 
%e di 12 circonferenze tra di loro adiacenti con centri sulla prima
clear all
close all
%apre figure
open_figure(1);

%disegna assi
axis_plot(8,1.2);

%disegna circonferenza di raggio 5 e centro l'origine
[x,y]=circle2_plot([0,0],5,-13,'g-')

%disegna 12 circonferenze
for i=1:12
[xx,yy]=circle2_plot([x(i),y(i)],1.4,20,'k-')
point_fill([xx',yy'],'r')
end


