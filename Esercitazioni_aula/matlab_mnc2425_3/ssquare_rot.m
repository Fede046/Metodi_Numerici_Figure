%script ssquare_rot.m
clear all
close all
%definisce vettore colori
col=['r','g','b','m','y','c','k'];
%apre figure
open_figure(1);
%disegna gli assi
axis_plot(3,0.25);
%definisce QUADRATO
P=[0,0; 2,0; 2,2; 0,2; 0,0];
% P=[0,0; 4,0; 4,2; 0,2; 0,0];
point_plot(P,'k-o',2,'k');
%
% TO DO
%calcola il baricentro
B=mean(P(1:4,:));

%definisce matrice di traslazione
T=get_mat_trasl(-B);
Tinv=get_mat_trasl(B);

%definisce angolo alfa di rotazione
alfa=pi/3

%definisce matrice di rotazione usando la get_mat2_rot
R=get_mat2_rot(alfa)
R=get_mat2_rot(alfa)
%definisce matrice composta di rotazione rispetto al baricentro
M=Tinv*R*T

for i=1:4
    P=point_trans(P,M);
    point_plot(P,[col(i),'-o'],2,col(i));
end