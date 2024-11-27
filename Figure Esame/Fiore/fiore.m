clear all
close all

open_figure(1);
grid("on");
hold on

%cerchio----------------------------------------------
p = linspace(0,2*pi,9);

for i=1:9
    [A0(i,1), A0(i,2)] = c2_circle(p(i),0.2);
end
%riduzione misura
A0=A0/8;

%faccio le curve di bez dei punti
Cf0 = curv2_bezier_interp(A0,0,1,1); 

%stampo
xy=curv2_ppbezier_plot(Cf0,100,'b');
fill(xy(:,1),xy(:,2),'b');

%petalo-------------------------------------------------
p = linspace(0,pi/2,8);

for i=1:8
    [AC(i,1), AC(i,2)] = c2_circle(p(i),0.2);
end
q=3/4*pi;
cc = AC*[cos(q),sin(q);-sin(q),cos(q)];
%faccio le curve di bez dei punti
Cf0 = curv2_bezier_interp(cc,0,1,1); 

%lato sx
C0.cp=-Cf0.cp;
C0.ab=Cf0.ab;
C0.deg=Cf0.deg;

%riflessione petalo
[C0,T,R]=align_curve(Cf0);
C0.cp(: ,2)=-C0.cp(: ,2) ;
Minv=inv(R*T) ;
C0.cp=point_trans(C0.cp ,Minv) ;


%join delle curve
C0S = curv2_ppbezier_join(Cf0,C0,1.0e-4);

C0S.cp=C0S.cp/3+[0.047,0.08];

%xy=curv2_ppbezier_plot(C0S,100,'r');
%fill(xy(:,1),xy(:,2),'r');


%1 rotazione--------------------------------------------
ppbFoR.cp=C0S.cp;
ppbFoR.ab=C0S.ab;
ppbFoR.deg = C0S.deg;
%baricentro del cerchio
B=[0 0];
%definisce matrice di traslazione
T=get_mat_trasl(-B);
Tinv=get_mat_trasl(B);
%rotazione attorno a un punto tipo mandala applicato alle curve di bez
for i=-0.1:pi/3.5:2*pi
    R=get_mat2_rot(i);
    M=Tinv*R*T;
    ppbFoR.cp=point_trans(C0S.cp,M);
    xy = curv2_ppbezier_plot(ppbFoR,60,'k');
    %coloro i petali
    fill(xy(: ,1) ,xy(: ,2) ,'g') ;
end

%2 rot------------------------------------------------

C0S.cp=C0S.cp*1.9;
ppbFoR2.cp=C0S.cp;
ppbFoR2.ab=C0S.ab;
ppbFoR2.deg=C0S.deg;

for i=((pi/3.5)-0.2)/2:pi/3.5:2*pi
    R=get_mat2_rot(i);
    M=Tinv*R*T;
    ppbFoR2.cp=point_trans(C0S.cp,M);
    xy = curv2_ppbezier_plot(ppbFoR2,60,'k');
    %coloro i petali
    fill(xy(: ,1) ,xy(: ,2) ,'r') ;
end



%------------------------------------------------------------
function [ppbezQ,T,R]=align_curve (ppbezP)
 ncp=length(ppbezP.cp(: ,1) ) ;
 ppbezQ=ppbezP;
 T=get_mat_trasl(-ppbezP.cp(1 ,:) ) ;
 alfa = -atan2(ppbezP.cp(ncp ,2) - ppbezP.cp(1 ,2) , ppbezP.cp(ncp ,1) - ppbezP.cp(1 ,1)) ;
 R=get_mat2_rot(alfa ) ;
 M=R*T;
 ppbezQ.cp=point_trans(ppbezP.cp ,M) ;
end