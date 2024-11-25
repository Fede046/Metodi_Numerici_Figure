clear all
close all

open_figure(1);
grid("on");

%il foiore è frmato da pistillo e petali(foglie) attorno al pistillo

%pistillo P

%ciclo for per cerchio con curve di bez
ik = 1;
for i=0:pi/4:2*pi
   [P(ik,1),P(ik,2)]= c2_circle(i,0.5);
   ik=ik+1;
end
P = P+[1 0];

bPP = curv2_bezier_interp(P,0,1,1);
xy = curv2_ppbezier_plot(bPP,60,'k-');
fill(xy(: ,1) ,xy(: ,2) ,'b') ;
%petali F

F = [
    0 0
    1 0.4
    2 0
    ];
bPF = curv2_bezier_interp(F,0,1,1);
%curv2_ppbezier_plot(bPF,60,'b-');

%curv di bez a tratti
%simmetria
[ppbF,T,R]=align_curve (bPF) ;
 ppbF.cp(: ,2)=-ppbF.cp(: ,2) ;
 Minv=inv(R*T) ;
ppbF.cp=point_trans(ppbF.cp ,Minv) ;
%curv2_ppbezier_plot(ppbF,60,'g-');
 
%join
ppbFo = curv2_ppbezier_join(ppbF,bPF,1.0e-4);
%curv2_ppbezier_plot(ppbFo,60,'g-');

%rimpicciolisco la matrice e la traslo
ppbFo.cp = (ppbFo.cp*0.7)+[1.5 0];
%curv2_ppbezier_plot(ppbFo,60,'g-');

%rotazione del petalo


ppbFoR.ab=ppbFo.ab;
ppbFoR.deg = ppbFo.deg;

%trovo il centro della crf
%potevo trovare il baricentro della crf ma essendo che ci sono pochi punti
%il baricentro viene con inpreciso sia nei casi in cui considero i punti
%.cp che qulli della crf
%B=mean(bPP.cp(1:4,:));
B=[1 0];

%definisce matrice di traslazione
T=get_mat_trasl(-B);
Tinv=get_mat_trasl(B);

%definisce angolo alfa di rotazione
alfa=pi/4

%definisce matrice di rotazione usando la get_mat2_rot
R=get_mat2_rot(alfa)
%definisce matrice composta di rotazione rispetto al baricentro
M=Tinv*R*T

%rotazione attorno a un punto tipo mandala applicato alle curve di bez
for i=-0.1:pi/3.5:2*pi
    R=get_mat2_rot(i);
    M=Tinv*R*T;
    ppbFoR.cp=point_trans(ppbFo.cp,M);
    xy =curv2_ppbezier_plot(ppbFoR,60,'k-');
    %coloro i pentali
    fill(xy(: ,1) ,xy(: ,2) ,'g') ;
end

for i=((pi/3.5)-0.2)/2:pi/3.5:2*pi
    R=get_mat2_rot(i);
    M=Tinv*R*T;
    ppbFoR.cp=point_trans(ppbFo.cp.*[2.5,2.5]+[-1.85 0],M);
    % ppbFoR.cp = ppbFoR.cp.*[3,3];
    xy =curv2_ppbezier_plot(ppbFoR,60,'k-');
    %coloro i pentali
    fill(xy(: ,1) ,xy(: ,2) ,'r') ;
end

% for i=0:pi/4:2*pi
% ppbFoR.cp = ppbFo.cp*[cos(i),sin(i);-sin(i),cos(i)];
% ppbFoR.cp = (ppbFoR.cp)+[1 0];
% curv2_ppbezier_plot(ppbFoR,60,'k-');
% end




%funzione per le simmetrie
function [ppbezQ,T,R] = align_curve(ppbezP)
ncp = length(ppbezP.cp(:,1));
ppbezQ = ppbezP;
T=get_mat_trasl(-ppbezP.cp(1 ,:) ) ;
 alfa = -atan2(ppbezP.cp(ncp ,2) - ppbezP.cp(1 ,2) , ppbezP.cp(ncp ,1) - ppbezP.cp(1 ,1)) ;
 R=get_mat2_rot(alfa ) ;
M=R*T;
 ppbezQ.cp=point_trans(ppbezP.cp ,M) ;
end
