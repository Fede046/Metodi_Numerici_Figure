function main()

close all
clear all

open_figure(1);
hold on

p = linspace(0, 2*pi, 25);
[Crf(:,1), Crf(:,2)]= cp2_circle(p);

% interpolazione di Hermite
ppbezCrf = curv2_ppbezierCC1_interp(Crf, 0, 2*pi, 2);

% disegno la prima circonferenza
bianco = curv2_ppbezier_plot(ppbezCrf, 60, 'b', 5);
point_fill(bianco, 'w', 'w');

% seconda circonferenza
%scalo la circonferenza per avere raggio 0.97
ppbezCrf_Med = ppbezCrf;
S = get_mat_scale([0.97,0.97]);
ppbezCrf_Med.cp = point_trans(ppbezCrf_Med.cp, S);

% disegno la seconda circonferenza
rosso = curv2_ppbezier_plot(ppbezCrf_Med, 60, 'b', 5);
point_fill(rosso, 'r', 'r');

% terza circonferenza
%scalo la circonferenza per avere raggio 0.77
ppbezCrf_Int = ppbezCrf;
S = get_mat_scale([0.77,0.77]);
ppbezCrf_Int.cp = point_trans(ppbezCrf_Int.cp, S);

%calcolo l'errore
npt=150;
t=linspace(0,2*pi,npt);
Pxy=ppbezier_val(ppbezCrf,t);
[x,y]=cp2_circle(t);
Qxy=[x',y'];
MaxErr=max(vecnorm((Pxy-Qxy)'));
fprintf('MaxErr3: %e\n',MaxErr);

%disegno il segmento
Seg = [-0.95 0.1
      0.00 0.05
      0.95 0.1
    ];
bezSeg = curv2_bezier_interp(Seg,0,1,0);
%point_plot(bezSeg.cp,'r-o',1.5,'r');
%curv2_ppbezier_plot(bezSeg, 60, 'g');

% specchiato
bezSeg1 = bezSeg;
bezSeg1.cp = bezSeg.cp.*[1 -1];
bezSeg1.ab = bezSeg.ab;

% la ruoto in modo verticale
B=[0 0];
T=get_mat_trasl(-B);
Tinv=get_mat_trasl(B);
alfa=pi/2;
R=get_mat2_rot(alfa);
M=Tinv*R*T;
bezSeg3 = bezSeg;
bezSeg3.cp = point_trans(bezSeg.cp, M);

% lo specchio
bezSeg4 = bezSeg3;
bezSeg4.cp = bezSeg3.cp.*[-1 -1];

%intersezioni di bezSeg e ppbezCrf_Int
[IP1P2,t1,t2]=curv2_intersect(bezSeg, ppbezCrf_Int);
[sx,dx]=ppbezier_subdiv(bezSeg,t1(1));
[sx2,dx2]=ppbezier_subdiv(dx,t1(2));
[sx3,dx3]=ppbezier_subdiv(ppbezCrf_Int,t2(1));
[sx4,dx4]=ppbezier_subdiv(sx3,t2(2));

tol = 1.0e-2;

% sistemo i gradi
sx2 = curv2_ppbezier_de(sx2, 1);
%unisco i due segmenti
bezSeg5 =curv2_ppbezier_join(dx4, sx2, tol);

%intersezione di bezSeg5 e bezSeg3
[IP1P2,t1,t2]=curv2_intersect(bezSeg5, bezSeg3);
[p5_sx, p5_dx]=ppbezier_subdiv(bezSeg5, t1(1));
[p6_sx, p6_dx]=ppbezier_subdiv(p5_dx, t1(2));
[p7_sx, p7_dx]=ppbezier_subdiv(bezSeg3, t2(1));
[p8_sx, p8_dx]=ppbezier_subdiv(p7_sx, t2(2));

% sistemo i gradi
p8_dx = curv2_ppbezier_de(p8_dx, 1);

%unisco i due segmenti
bezSeg6 =curv2_ppbezier_join(p8_dx, p6_sx, tol);

% per la rotazione delle parti blu
R = get_mat2_rot(3*pi/4);

% lo specchio in basso a sx
bezSeg61 = bezSeg6;
bezSeg61.cp = bezSeg6.cp.*[1 -1];
bezSeg61.cp = point_trans(bezSeg61.cp,R);
bezSeg61_fill = curv2_ppbezier_plot(bezSeg61, 60 ,'w', 5);
point_fill(bezSeg61_fill, 'b', 'b');

% lo specchio in basso a dx
bezSeg62 = bezSeg6;
bezSeg62.cp = bezSeg6.cp.*[-1 -1];
bezSeg62.cp = point_trans(bezSeg62.cp,R);
bezSeg62_fill = curv2_ppbezier_plot(bezSeg62, 60 ,'w', 5);
point_fill(bezSeg62_fill, 'b', 'b');

% lo specchio in alto a dx
bezSeg63 = bezSeg6;
bezSeg63.cp = bezSeg6.cp.*[-1 1];
bezSeg63.cp = point_trans(bezSeg63.cp,R);
bezSeg63_fill = curv2_ppbezier_plot(bezSeg63, 60 ,'w', 5);
point_fill(bezSeg63_fill, 'b', 'b');

%%ultimo ruotato
bezSeg6.cp = point_trans(bezSeg6.cp,R);
bezSeg6_fill = curv2_ppbezier_plot(bezSeg6, 60, 'w', 5);
point_fill(bezSeg6_fill, 'b', 'b');

%calcolo l'area della regione rossa
area = curv2_ppbezier_area(ppbezCrf_Med);
areablu = curv2_ppbezier_area(bezSeg62);
areaF = area-4*areablu;
fprintf('Area della curva: %e\n', areaF);

% sfondo
set(gca,'color',[0.80, 0.85 ,0.98]);

end