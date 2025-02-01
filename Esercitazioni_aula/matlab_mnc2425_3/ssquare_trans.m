%script ssquare_trans.m
clear all
close all
%definisce vettore colori
col=['r','g','b','m','y','c','k'];
%apre figure
open_figure(1);
%disegna assi
axis_plot(3,0.3);
%definisce QUADRATO e lo disegna
P=[0,0; 2,0; 2,2; 0,2; 0,0];
point_plot(P,'k-o',1,'k');

%definisce l'angolo alpha
alfa=pi/3;
%definisce la matrice di rotazione usando la get_mat2_rot
R=get_mat2_rot(alfa);


for i=1:5
    P=point_trans(P,R);
    str=[col(i),'o--']
    point_plot(P,[col(i)])
end