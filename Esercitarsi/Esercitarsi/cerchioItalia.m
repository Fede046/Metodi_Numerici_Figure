clear all
close all


%
open_figure(1);
hold on;
grid("on");

%cerchio bianco sotto
p = linspace(0,2*pi,16);

for i=1:16 
    [Crf(i,1) Crf(i,2)] = c2_circle(p(i),0.95);
    [CrfA(i,1) CrfA(i,2)] = c2_circle(p(i),0.9);   
end 

%provo ad aumentare i punti magari utilizzando chevishev 
bezCrf = curv2_ppbezierCC1_interp(Crf,0,2*pi,2);
%curv2_ppbezier_plot(bezCrf,60,'r',2)

bezCrfA = curv2_ppbezierCC1_interp(CrfA,0,2*pi,2);
%bezCrfA.ab = [-1 1];
curv2_ppbezier_plot(bezCrf,60,'k',2);
% curv2_ppbezier_plot(bezCrfA,60,'k');



%fare le mezzeluna
a = linspace(-0.9,0.9,4)

Seg =[a(2),1;a(2),-1];


% bezSeg.cp =[a(2),1;a(2),-1];
% bezSeg.ab = [-1 1];
% bezSeg.deg = 1;

%point_plot(Seg)
%per due punti non vale 
bezSeg = curv2_bezier_interp(Seg,-1,1,0);
%curv2_ppbezier_plot(bezSeg,60,'r',2);


[Ip1P2,t1,t2]=curv2_intersect(bezCrfA,bezSeg);

%uso decast sub div
[bezCrfA,ppbezier_dx]=ppbezier_subdiv(bezCrfA,t1(1));


[ppbezier_sx,bezCrfA]=ppbezier_subdiv(bezCrfA,t1(2));
curv2_ppbezier_plot(bezCrfA,60,'c',2);

[ppbezier_sx,bezSeg]=ppbezier_subdiv(bezSeg,t2(1));
[bezSeg,ppbezier_dx]=ppbezier_subdiv(bezSeg,t2(2));

curv2_ppbezier_plot(bezSeg,60,'g',2);

% curv2_bezier_plot(bezCrfA,60,'g',2);
% curv2_bezier_plot(bezSeg,60,'b',2);
bezSeg= curv2_ppbezier_de(bezSeg,bezCrfA.deg-1);


ppbezSemiCrf = curv2_ppbezier_join(bezSeg,bezCrfA,1.0e-1);
%curv2_ppbezier_plot(ppbezSemiCrf,60,'b',2)
ppbezSemiCrf;


xy = curv2_ppbezier_plot(ppbezSemiCrf,30,'c',3);
fill(xy(:,1),xy(:,2),'g','EdgeColor','g','LineWidth',2);

 
%faccio l'altra mezza luna
ppbezSemiCrf.cp = -ppbezSemiCrf.cp;
xy = curv2_ppbezier_plot(ppbezSemiCrf,30,'c',3);
fill(xy(:,1),xy(:,2),'r','EdgeColor','r','LineWidth',2);


%olanda
B=[0 0];
%definisce matrice di traslazione
T=get_mat_trasl(-B);
Tinv=get_mat_trasl(B);
%definisce angolo alfa di rotazione
alfa=pi/2;
%definisce matrice di rotazione usando la get_mat2_rot
R=get_mat2_rot(alfa);
%definisce matrice composta di rotazione rispetto al baricentro
M=Tinv*R*T;


open_figure(2);
curv2_ppbezier_plot(bezCrf,60,'k');
%ppbezSemiCrf.cp = ppbezSemiCrf.cp*[];
ppbezSemiCrf.cp=point_trans(ppbezSemiCrf.cp,M);
xy = curv2_ppbezier_plot(ppbezSemiCrf,30,'c',3);
fill(xy(:,1),xy(:,2),'r','EdgeColor','r','LineWidth',2);


ppbezSemiCrf.cp = -ppbezSemiCrf.cp;
xy = curv2_ppbezier_plot(ppbezSemiCrf,30,'c',3);
fill(xy(:,1),xy(:,2),'b','EdgeColor','b','LineWidth',2);





