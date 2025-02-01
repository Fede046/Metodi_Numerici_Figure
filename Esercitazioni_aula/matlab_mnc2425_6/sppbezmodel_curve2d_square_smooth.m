%script di esempio di modellazione procedurale di un quadrato
%con i corner smooth
function main()
close all

open_figure(1);

%definiamo un poligono regolare di 4 vertici e lati
nv=5;
[xp,yp]=circle2_plot([0,0],1,-nv);
Q=[xp',yp'];
%disegna i punti
%point_plot(Q,'ko',1,'k');ii

%ruotiamo il poligono di pi/4
R=get_mat2_rot(pi/4);
Q=point_trans(Q,R);
point_plot(Q,'ko',1,'k');

%definisce il quadrato smooth come curva di Bézier a tratti di grado 2
%smussiamo gli angoli
ppP.deg=2;
%quantita' di smooth
d=0.1;
ppP.cp=[Q(1,:)+[0,-d];Q(1,:);Q(1,:)+[-d,0];
        0.5.*(Q(1,:)+Q(2,:));Q(2,:)+[d,0];
        Q(2,:);Q(2,:)+[0,-d];
        0.5.*(Q(2,:)+Q(3,:));Q(3,:)+[0,+d];
        Q(3,:);Q(3,:)+[d,0];
        0.5.*(Q(3,:)+Q(4,:));Q(4,:)+[-d,0];
        Q(4,:);Q(4,:)+[0,d];
        0.5.*(Q(4,:)+Q(5,:));Q(5,:)+[0,-d]];
ppP.ab=0:8;
point_plot(ppP.cp,'b-o');ii

np=20;
%disegna curva di bezier a tratti
Pxy=curv2_ppbezier_plot(ppP,np,'k-',1.5);
axis equal
% point_fill(Pxy,'w')

%curv2_ppbezier_save('ppbez_square_smooth.db',ppP);

end
