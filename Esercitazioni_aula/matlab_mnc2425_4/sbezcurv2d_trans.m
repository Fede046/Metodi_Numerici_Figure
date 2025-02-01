%script di esempio per curva 2d di Bezier
clear all
close all

open_figure(1);
axis_plot(1,0.125);

bezP=curv2_bezier_load('c2_bezier_heart.db');
np=61;
curv2_bezier_plot(bezP,np,'b',2);
point_plot(bezP.cp,'r-o',1.5,'r');

open_figure(2);
vcol=['r','g','b','c','m','y','k'];

%TO DO

n = 7;
for i=1:n

    col= vcol(mod(i,7)+1)
    M = get_mat2_rot(((2*pi)/n)*i);
    %P_trans = point_trans(bezP.cp,M);
    v=curv2_bezier_plot(bezP,np,'b',2);
    P_cuore=point_trans(v,M)

    point_plot(P_cuore,col,1.5);
    %point_plot(P_trans,vcol(i),1.5);
end

a=0;
b=2*pi;
np=150;

%[x,y]=curv2_plot('c2_cardioide',a,b,np,'b-');


%P=[x',y'];
%n = 7;
%for i = 1:n
    %M = get_mat2_rot(((2*pi)/n)*i);
    %P_trans = point_trans(P,M);
    %point_plot(P_trans)
%end



