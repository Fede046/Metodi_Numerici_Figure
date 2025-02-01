%script di prova per disegno della cardioide
clear all
close all

%figure('Position', [10 10 500 400])
open_figure(1);
%hold on
axis_plot(2)

%base
a=0;
b=2*pi;

%3 primo
a=-3;
b=3;
%3 secondo
a=-0.5;
b=1.5;
%3 terzo
a=-3*pi;
b=3*pi;
%3 quarto
a=0;
b=16;


np=150;

[x,y]=curv2_plot('c2_cardioide',a,b,np,'y-');

point_plot([x(1),y(1)],'ro',1,'r','r');
point_plot([x(10),y(10)],'ro',1,'r','r');



%scardio_trans (fatto)
P=[x',y'];
n = 7;
for i = 1:n
    M = get_mat2_rot(((2*pi)/n)*i);
    P_trans = point_trans(P,M);
    point_plot(P_trans,'b-')
end