%script sload_plot.m per caricare file di punti e disegnarli
clear all
close all

figure('Position', [10 10 700 600])
open_figure(1);
axis_plot(0.4,0.05)

%legge i punti di un disegno da file
P=load('paperino.txt');


%determina il bounding-box e lo disegna
[xmin,xmax]=mm_vect((P(:,1)));
[ymin,ymax]=mm_vect((P(:,2)));

%disegna i punti
%...
rectangle_plot(xmin,xmax,ymin,ymax,'b-',2)

point_plot(P,'r-')

