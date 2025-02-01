%script di prova per disegno di curve in forma parametrica
close all
open_figure(1);
axis_plot(4)
a=-0.5;  b=1.5;  np=50;
[x,y]=curv2_plot('cs2_curv_pol',a,b,np,'b');
% disp([x,y]')
t=[-0.5, -0.25, 0, 1.0, 1.25, 1.5];
nt=length(t);
for i=1:nt
[P0(1),P0(2),xp,yp,xs,ys]=cs2_curv_pol(t(i));
point_plot(P0,'ro',3)
vT=[xp,yp];
%vect2_plot(P0,vT,'g-')
N=[-yp,xp];
Nnorm=N./norm(N,2);
vect2_plot(P0,Nnorm,'k')
end