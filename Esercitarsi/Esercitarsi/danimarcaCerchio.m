%clear all

function main()
close all

%grafic setting 
open_figure(1);
hold on;
grid("on");


%cerchio
p = linspace(0,2*pi,30);
[Crf(:,1),Crf(:,2)]=cp2_circle(p);
ppbezCrf = curv2_ppbezierCC1_interp(Crf,0,2*pi,2);


curv2_ppbezier_plot(ppbezCrf,40,'k',2);

%seconda circonferenza (interna)
ppbezCrfInt=ppbezCrf;
S=get_mat_scale([0.97,0.97]);
ppbezCrfInt.cp=point_trans(ppbezCrfInt.cp,S);

curv2_ppbezier_plot(ppbezCrfInt,60,'w',2);

%calcolo errore
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


%segmento
Seg = [ 1 0.15
    -1 0.15
    ];

ppbezS = curv2_bezier_interp(Seg,0,1,0);

ppbezST = ppbezS;
ppbezST.cp = ppbezS.cp.*[1 -1];

%curv2_ppbezier_plot(ppbezS,60,'m',2);

%curv2_ppbezier_plot(ppbezST,60,'y',2);

%altro segmento
SegV1 = [-0.2,1;-0.2,-1];

bezSegV1 = curv2_bezier_interp(SegV1,0,1,0);
%curv2_ppbezier_plot(bezSegV1,60,'b',2);


SegV2 = [-0.5,1;-0.5,-1];
bezSegV2 = curv2_bezier_interp(SegV2,0,1,0);
%curv2_ppbezier_plot(bezSegV2,60,'c',2);





%triangolo piccolo
%ppbezST
%bezSegV2
%ppbezCrfInt

[IP1P2,t1,t2]=curv2_intersect(bezSegV2,ppbezST);

[sx,dx]= ppbezier_subdiv(bezSegV2,t1);
%curv2_ppbezier_plot(dx,60,'r',2)

[sx1,dx1]= ppbezier_subdiv(ppbezST,t2);
%curv2_ppbezier_plot(dx1,60,'r',2)

%join
ppbezSegY = curv2_ppbezier_join(dx1,dx,1.0e-1);
%curv2_ppbezier_plot(ppbezSegY,60,'g',2)

%intersezione con la crf
[IP1P2,t1,t2]=curv2_intersect(ppbezCrfInt,ppbezSegY);


[sx11,dx11]= ppbezier_subdiv(ppbezCrfInt,t1(1));
%curv2_ppbezier_plot(dx11,60,'k',2)

[sx12,dx12]= ppbezier_subdiv(dx11,t1(2));
%curv2_ppbezier_plot(sx12,60,'m',2)

[sx21,dx21]= ppbezier_subdiv(ppbezSegY,t2(1));
%curv2_ppbezier_plot(sx21,60,'k',2);

[sx22,dx22]= ppbezier_subdiv(sx21,t2(2));
%curv2_ppbezier_plot(dx22,60,'m',2);

%join
dx22= curv2_ppbezier_de(dx22,2);

ppbezArcoPcc = curv2_ppbezier_join(dx22,sx12,1.0e-2);
xy =curv2_ppbezier_plot(ppbezArcoPcc,60,'r',2);
point_fill(xy,'r','r');

%specchiato
ppbezArcoPcc2= ppbezArcoPcc;
ppbezArcoPcc2.cp = ppbezArcoPcc.cp.*[1 -1];
xy =curv2_ppbezier_plot(ppbezArcoPcc2,60,'r',3);
point_fill(xy,'r','r');




%intersezioni
[IP1P2,t1,t2]=curv2_intersect(bezSegV1,ppbezST);



[sx1,dx1]=ppbezier_subdiv(bezSegV1,t1);
%curv2_ppbezier_plot(dx1,60,'b',2);

[sx2,dx2]=ppbezier_subdiv(ppbezST,t2);

%curv2_ppbezier_plot(sx2,60,'g',2);
%curv2_ppbezier_plot(dx,60,'b',2);

%join
ppbezSegX = curv2_ppbezier_join(sx2,dx1,1.0e-1);
%curv2_ppbezier_plot(ppbezSegX,60,'c',2);


%intersezione tra lo spigolo e la Circonferenza
[IP1P2,t1,t2]=curv2_intersect(ppbezCrfInt,ppbezSegX);




%punti di intersezione 

[sx11,dx11]=ppbezier_subdiv(ppbezCrfInt,t1(1));
 %curv2_ppbezier_plot(sx11,60,'g',2);
 %curv2_ppbezier_plot(dx11,60,'b',2);

[sx12,dx12]=ppbezier_subdiv(dx11,t1(2));
 %curv2_ppbezier_plot(sx12,60,'g',2);
 %curv2_ppbezier_plot(dx12,60,'b',2);




[sx21,dx21]=ppbezier_subdiv(ppbezSegX,t2(1));
% curv2_ppbezier_plot(sx,60,'g',2);
%curv2_ppbezier_plot(bezSeg,60,'b',2);



[sx22,dx22]=ppbezier_subdiv(sx21,t2(2));
%curv2_ppbezier_plot(sx22,60,'g',2);
%curv2_ppbezier_plot(dx22,60,'b',2);


%join

dx22 = curv2_ppbezier_de(dx22,2);
ppbezArcoGG =curv2_ppbezier_join(sx12,dx22,1.0e-2);
xy =curv2_ppbezier_plot(ppbezArcoGG,60,'r',3);
point_fill(xy,'r','r');

%specchiato
ppbezArcoGG2= ppbezArcoGG;
ppbezArcoGG2.cp = ppbezArcoGG.cp.*[1 -1];
xy =curv2_ppbezier_plot(ppbezArcoGG2,60,'r',3);
point_fill(xy,'r','r');









end













