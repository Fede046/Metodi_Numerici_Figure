

function main()
clear all

close all;
%grafic setting
open_figure(1);
hold on;
grid("on");


%circonferenza
p = linspace(0,2*pi,8);
p = chebyshev2(0,2*pi,8);
[Crf(:,1),Crf(:,2),Crfp(:,1),Crfp(:,2)]= cp2_circle(p);


%
ppbezCrf = curv2_ppbezierCC1_interp_der(Crf,Crfp,p);
%ppbezCrf = 


%seconda circonferenza (interna)
ppbezCrfInt=ppbezCrf;
S=get_mat_scale([0.97,0.97]);
ppbezCrfInt.cp=point_trans(ppbezCrfInt.cp,S);




%valutazione in punti equispaziati per test sull'errore
npt=150;
t=linspace(0,2*pi,npt);
Pxy=ppbezier_val(ppbezCrf,t);
%si fa solo per crf, per casi normali utilizzare quella non der
[x,y]=cp2_circle(t);
Qxy=[x',y'];

%calcola la distanza euclidea fra i punti della curva test
%e della curva di Bézier a tratti interpolante e considera
%la distanza massima
MaxErr=max(vecnorm((Pxy-Qxy)'));
fprintf('MaxErr3: %e\n',MaxErr);

xy =curv2_ppbezier_plot(ppbezCrf,60,'w',2);
point_fill(xy,'w','w');
%curv2_ppbezier_plot(ppbezCrfInt,60,'k',2);

%faccio il segmento

slin = linspace(-1,1,4);
Seg = [1,slin(3);-1,slin(3)];
%curva di bez del segmento
bezSeg = curv2_bezier_interp(Seg,-1,1,0);
%curv2_ppbezier_plot(bezSeg,60,'k',2);

[IP1P2,t1,t2]=curv2_intersect(ppbezCrfInt,bezSeg);

%punti di intersezione 

[sx,dx]=ppbezier_subdiv(ppbezCrfInt,t1(1));
[sx,ppbezCrfInt]=ppbezier_subdiv(sx,t1(2));
% curv2_ppbezier_plot(sx,60,'g',2);
% curv2_ppbezier_plot(ppbezCrfInt,60,'b',2);

[sx,dx]=ppbezier_subdiv(bezSeg,t2(1));
[sx,bezSeg]=ppbezier_subdiv(sx,t2(2));

% curv2_ppbezier_plot(sx,60,'g',2);
% curv2_ppbezier_plot(bezSeg,60,'b',2);

%join
tol = 1.0e-2;
bezSeg =curv2_ppbezier_de(bezSeg,2);
ppbezArco =curv2_ppbezier_join(bezSeg,ppbezCrfInt,tol);

xy =curv2_ppbezier_plot(ppbezArco,60,'m');
point_fill(xy,'r','r');


%parte sotto
B=[0 0];
%definisce matrice di traslazione
T=get_mat_trasl(-B);
Tinv =get_mat_trasl(B);
%definisce angolo alfa di rotazione
alfa=pi;
%definisce matrice di rotazione usando la get_mat2_rot
R=get_mat2_rot(alfa);
%definisce matrice composta di rotazione rispetto al baricentro
M=Tinv*R*T;

ppbezArcoSotto=ppbezArco;
ppbezArcoSotto.cp=point_trans(ppbezArco.cp,M);

xy =curv2_ppbezier_plot(ppbezArcoSotto,60,'m');
point_fill(xy,'r','r');


end






