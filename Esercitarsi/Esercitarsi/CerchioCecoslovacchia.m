clear all
close all

open_figure(1);
hold on;
grid("on");

%faccio il cerchio
t = chebyshev2(0,2*pi,16);
[Crf(:,1) Crf(:,2) Crfp(:,1) Crfp(:,2)]=cp2_circle(t);

%interpolazione con le derivate
ppbezCrfG = curv2_ppbezierCC1_interp_der(Crf,Crfp,t);

curv2_ppbezier_plot(ppbezCrfG,60,'r');

ppbezCrf= ppbezCrfG;
S = get_mat_scale([0.97,0.97]);
ppbezCrf.cp = point_trans(ppbezCrfG.cp,S);

xy =curv2_ppbezier_plot(ppbezCrf,60,'r');
point_fill(xy,'b','b');
%
Seg = [0 0
    2 0];

bezSeg = curv2_bezier_interp(Seg,0,1,0);
%curv2_ppbezier_plot(bezSeg,60,'r');

M = get_mat2_rot(5*pi/6);
bezSegT = bezSeg;
bezSegT.cp = point_trans(bezSeg.cp,M);
%curv2_ppbezier_plot(bezSegT,60,'r');


%join
bezSe = curv2_ppbezier_join(bezSegT,bezSeg,1.0e-2);

%interszione
[IP1P2,t1,t2]=curv2_intersect(ppbezCrf,bezSe);

[sx11,dx11]=ppbezier_subdiv(ppbezCrf,t1(1));
[sx12,dx12]=ppbezier_subdiv(sx11,t1(2));
 %curv2_ppbezier_plot(sx11,60,'g',2);
 %curv2_ppbezier_plot(dx11,60,'b',2);
[sx21,dx21]=ppbezier_subdiv(bezSe,t2(1));
[sx22,dx22]=ppbezier_subdiv(sx21,t2(2));
 %curv2_ppbezier_plot(sx21,60,'g',2);
 %curv2_ppbezier_plot(dx22,60,'b',2);



%join
dx22 = curv2_ppbezier_de(dx22,sx11.deg-dx22.deg);
ppbezArco = curv2_ppbezier_join(dx22,sx11,1.0e-2);
xy =curv2_ppbezier_plot(ppbezArco,60,'w',3);
point_fill(xy,'w','w');

%inversa
ppbezArcoInv = ppbezArco;
ppbezArcoInv.cp = ppbezArco.cp.*[ 1 -1];
xy =curv2_ppbezier_plot(ppbezArcoInv,60,'w',3);
point_fill(xy,'r','r');

