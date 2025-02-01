
clear all
close all


%grafic setting
open_figure(1);
hold on;
grid("on");



%faccio il cerchio
t = chebyshev2(0,2*pi,16);
[Crf(:,1) Crf(:,2) Crfp(:,1) Crfp(:,2)]=cp2_circle(t);

%interpolazione con le derivate
ppbezCrfG = curv2_ppbezierCC1_interp_der(Crf,Crfp,t);
curv2_ppbezier_plot(ppbezCrfG,60,'k');

%calcolo dell'errore
npt=150;
a=0;
b= 2*pi; 
t=linspace(a,b,npt);


Pxy=ppbezier_val(ppbezCrfG,t);
[xi,yi]=cp2_circle(t);
Qxy=[xi',yi'];

%calcola la distanza euclidea fra i punti della curva test
%e della curva di Bézier a tratti interpolante e considera
%la distanza massima
MaxErr=max(vecnorm((Pxy-Qxy)'));
fprintf('MaxErr3: %e\n',MaxErr);


%rimpicciolisco 
ppbezCrf=ppbezCrfG;
M = get_mat_scale([0.97,0.97]);
ppbezCrf.cp = point_trans(ppbezCrf.cp,M);

xy = curv2_ppbezier_plot(ppbezCrf,-60,'k',2);
point_fill(xy,'b','b');
%divido il cerchio in 10

%trovo il punto y di massimo del cerchio
a=0;
b=2*pi;
npt=150;
t=linspace(a,b,npt);
Pxy=ppbezier_val(ppbezCrf,t);
Massimay = max(Pxy(:,2));
Minimay = min(Pxy(:,2));

%divido il cerchio in 10 segmenti
l = linspace(Minimay,Massimay,10);

%segmento in basso 2
Seg2 = [1 l(2)
        -1 l(2)];
bezSeg2 = curv2_bezier_interp(Seg2,-1,1,0);
%curv2_ppbezier_plot(bezSeg2,60,'g',2);

%segmento in basso 3
Seg3 = [1 l(3)
        -1 l(3)];
bezSeg3 = curv2_bezier_interp(Seg3,-1,1,0);
%curv2_ppbezier_plot(bezSeg3,60,'g',2);

%segmento in basso 3
Seg4 = [1 l(4)
        -1 l(4)];
bezSeg4 = curv2_bezier_interp(Seg4,-1,1,0);
%curv2_ppbezier_plot(bezSeg4,60,'g',2);

%segmento in basso 5
Seg5 = [1 l(5)
        -1 l(5)];
bezSeg5 = curv2_bezier_interp(Seg5,-1,1,0);
%curv2_ppbezier_plot(bezSeg5,60,'g',2);

%segmento in basso 6
Seg6 = [1 l(6)
        -1 l(6)];
bezSeg6 = curv2_bezier_interp(Seg6,-1,1,0);
%curv2_ppbezier_plot(bezSeg6,60,'g',2);

%segmento in basso 7
Seg7 = [1 l(7)
        -1 l(7)];
bezSeg7 = curv2_bezier_interp(Seg7,-1,1,0);
%curv2_ppbezier_plot(bezSeg7,60,'g',2);


%segmento in basso 8
Seg8 = [1 l(8)
        -1 l(8)];
bezSeg8 = curv2_bezier_interp(Seg8,-1,1,0);
%curv2_ppbezier_plot(bezSeg5,60,'g',2);

%segmento in basso 9
Seg9 = [1 l(9)
        -1 l(9)];
bezSeg9 = curv2_bezier_interp(Seg9,-1,1,0);
%curv2_ppbezier_plot(bezSeg5,60,'g',2);

%Segmento verticale centrale
SegCentra = [0 0
    0 Massimay];
bezSegC = curv2_bezier_interp(SegCentra,-1,1,0);
%curv2_ppbezier_plot(bezSegC,60,'g',2);

%%%%%%%parte verticale

%segemento verticale
Massimax = max(Pxy(:,1));
Minimax = min(Pxy(:,1));

%divido il cerchio in 10 segmenti
v = linspace(Minimax,Massimax,10);

%segmento in verticale 2
SegV2 = [v(2) 1
        v(2) -1];
bezSegV2 = curv2_bezier_interp(SegV2,-1,1,0);
%curv2_ppbezier_plot(bezSegV2,60,'g',2);


%segmento in verticale 3
SegV3 = [v(3) 1
         v(3) -1];
bezSegV3 = curv2_bezier_interp(SegV3,-1,1,0);
%curv2_ppbezier_plot(bezSegV3,60,'g',2);

%%%%%% verticale

% %%%%%%%%%%parte alta

for i = 1:4
    if i==4
        bezSeg6= bezSegV3;
        bezSeg7= bezSegV2;
        bezSegC= bezSeg5;

    elseif i==3
       bezSeg6= bezSeg8;
        bezSeg7= bezSeg9;
    elseif i==2
        bezSeg6= bezSeg7;
        bezSeg7= bezSeg8;
    end

[IP1P2,t1,t2]=curv2_intersect(bezSegC,bezSeg6);
[sx11,dx11]=ppbezier_subdiv(bezSegC,t1);
%curv2_ppbezier_plot(sx11,60,'m',2);
%curv2_ppbezier_plot(dx11,60,'b',2);
[sx21,dx21]=ppbezier_subdiv(bezSeg6,t2);
%curv2_ppbezier_plot(sx21,60,'m',2);
%curv2_ppbezier_plot(dx21,60,'b',2);


%%join
bezParte6 = curv2_ppbezier_join(sx21,dx11,1.0e-1);
%curv2_ppbezier_plot(bezParte6,60,'y',2);

%%%
[IP1P2,t1,t2]=curv2_intersect(bezParte6,bezSeg7);
[sx11,dx11]=ppbezier_subdiv(bezParte6,t1);
%curv2_ppbezier_plot(sx11,60,'m',2);
%curv2_ppbezier_plot(dx11,60,'b',2);
[sx21,dx21]=ppbezier_subdiv(bezSeg7,t2);
%curv2_ppbezier_plot(sx21,60,'m',2);
%curv2_ppbezier_plot(dx21,60,'b',2);

%%join
bezParte7 = curv2_ppbezier_join(sx11,sx21,1.0e-2);
%curv2_ppbezier_plot(bezParte7,60,'y',2);

%con crf

[IP1P2,t1,t2]=curv2_intersect(ppbezCrf,bezParte7);
[sx11,dx11]=ppbezier_subdiv(ppbezCrf,t1(1));
[sx12,dx12]=ppbezier_subdiv(sx11,t1(2));
 %curv2_ppbezier_plot(sx11,60,'g',2);
 %curv2_ppbezier_plot(dx12,60,'b',2);
[sx21,dx21]=ppbezier_subdiv(bezParte7,t2(1));
[sx22,dx22]=ppbezier_subdiv(sx21,t2(2));
% curv2_ppbezier_plot(sx21,60,'g',2);
% curv2_ppbezier_plot(dx22,60,'b',2);

%%%join
dx22 = curv2_ppbezier_de(dx22,dx12.deg-dx22.deg);

bezParte76 = curv2_ppbezier_join(dx22,dx12,1.0e-2);

if i==2
        bezParte76.cp= bezParte76.cp.*[-1 1];
end 

xy =curv2_ppbezier_plot(bezParte76,60,'w',2);
point_fill(xy,'w','w');
end
%%%%%%%%%%%%%

%%%%%%%%parte bassa

for i=1:2
    if i==2
bezSeg2=bezSeg4;
bezSeg3=bezSeg5;
    end

[IP1P2,t1,t2]=curv2_intersect(ppbezCrf,bezSeg2);

[sx11,dx11]=ppbezier_subdiv(ppbezCrf,t1(1));
[sx12,dx12]=ppbezier_subdiv(ppbezCrf,t1(2));
%curv2_ppbezier_plot(sx11,60,'g',2);
%curv2_ppbezier_plot(dx12,60,'b',2);

%join
ppbezCrf2 = curv2_ppbezier_join(sx11,dx12,1.0e-2);
%curv2_ppbezier_plot(ppbezCrf2,60,'c',2);

[sx21,dx21]=ppbezier_subdiv(bezSeg2,t2(1));
[sx22,dx22]=ppbezier_subdiv(sx21,t2(2));

% curv2_ppbezier_plot(sx21,60,'g',2);
 %curv2_ppbezier_plot(dx22,60,'b',2);

%join
dx22 = curv2_ppbezier_de(dx22,ppbezCrf2.deg-dx22.deg);
ppbezCrf21 = curv2_ppbezier_join(dx22,ppbezCrf2,1.0e-2);
%curv2_ppbezier_plot(ppbezCrf21,60,'c',2);

%intersezione con segmento 3

[IP1P2,t1,t2]=curv2_intersect(ppbezCrf21,bezSeg3);

[sx11,dx11]=ppbezier_subdiv(ppbezCrf21,t1(1));
[sx12,dx12]=ppbezier_subdiv(ppbezCrf21,t1(2));
 %curv2_ppbezier_plot(sx11,60,'g',2);
 %curv2_ppbezier_plot(dx12,60,'b',2);
[sx21,dx21]=ppbezier_subdiv(bezSeg3,t2(1));
[sx22,dx22]=ppbezier_subdiv(sx21,t2(2));
 %curv2_ppbezier_plot(sx21,60,'g',2);
 %curv2_ppbezier_plot(dx22,60,'b',2);

 %join
 dx22 = curv2_ppbezier_de(dx22,sx11.deg-dx22.deg);
ppbezCrf22 = curv2_ppbezier_join(dx22,sx11,1.0e-2);
%curv2_ppbezier_plot(ppbezCrf22,60,'m',2);

ppbezCrf23 = curv2_ppbezier_join(dx12,ppbezCrf22,1.0e-2);
xy =curv2_ppbezier_plot(ppbezCrf23,60,'w',2);
point_fill(xy,'w','w');
end







