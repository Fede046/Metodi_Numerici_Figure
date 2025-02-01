clear all
close all

%grafic settings
open_figure(1);
%grid("on");

%codice
np = 10;

%curva di bez random (faccio una semi crf)
p = linspace(0,pi,8);
for i=1:8
    [A(i,1),A(i,2)]=c2_circle(p(i),1);
end

bezA = curv2_bezier_interp(A,0,1,0);

%continuo il codice
for i=1:np
    cla
    axis([-3, 3, -3, 3]);
    axis_plot(1);
    curv2_bezier_plot(bezA,60,'r',3);
    point_plot(bezA.cp,'ko-',2);
    % Disegna il vettore tangente di una curva 2D di Bezier
    curv2_bezier_tan_plot(bezA ,i ,'r-',1,'k','r',5);
    %cattura il frame in una struttura di np matrici
    m(:,i)=getframe;
end

%visulaizza l'animazione 3 volte
movie(m,3);





