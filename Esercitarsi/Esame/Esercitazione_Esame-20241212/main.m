function main()

close all
clear all

%Esercizio d'esame di MNC2425
% Fare uno script per riprodurre il disegno in Figure 2 e le stampe richieste.
% Ricostruire la curva di Bézier di grado 11 a forma di cuore con Control Points:
% [0.0,0.0],[0.15,0.2],[0.4,0.2],[0.3,0.6],[0.0,0.6],[-0.5,0.0],[0.5,0.0]
% [0.0,0.6],[-0.3,0.6],[-0.4,0.2],[-0.15,0.2],[0.0,0.0]
% per interpolazione con due curve di Bézier di grado 6 e stampare il MaxErr,
% poi unirle in una curva di Bézier tratti.
% Ricostruire la curva a forma di freccia utilizzando la curva a forma di cuore
% appena ottenuta e il segmento rosso (campionare i punti estremi del segmento).
% Il cuore ed il segmento tratteggiati in verde (Figure 1), vengano prodotti per
% traslazione dei precedenti.
% 
% ---Stampe---
% MaxErr: 1.396707e-03


%grafci setting
open_figure(1);
hold on;
grid("on");

bezCuore.deg = 11;
bezCuore.cp = [[0.0,0.0];[0.15,0.2];[0.4,0.2];[0.3,0.6];[0.0,0.6];[-0.5,0.0];[0.5,0.0];
               [0.0,0.6];[-0.3,0.6];[-0.4,0.2];[-0.15,0.2];[0.0,0.0]];
bezCuore.ab = [0,1];
    

%metà Cuore 
npt = linspace(0,0.5,7);
Punti = ppbezier_val(bezCuore,npt);

%interpolazione 
bezCuoredx = curv2_bezier_interp(Punti,0,1,0);
%curv2_ppbezier_plot(bezCuoredx,60,'g');


%cuore sx 
bezCuoresx= bezCuoredx;
bezCuoresx.cp = bezCuoresx.cp.*[-1 1];
% curv2_ppbezier_plot(bezCuoresx,60,'m');

%join 
bezC  = curv2_ppbezier_join(bezCuoresx,bezCuoredx,1.0e-2);

%calcolo dell'errore

t  = linspace(0,0.5,150);
Pxy = ppbezier_val(bezCuore,t);

t1 = linspace(0,1,150);
Qxy = ppbezier_val(bezCuoredx,t1);

MaxErr = max(vecnorm((Qxy-Pxy)')); 
fprintf('MaxErr: %e\n',MaxErr);
    
tol = 1.0e-2;
%%%freccia

 bezsd.ab = [0,1];
 bezsd.deg = 1;
    x = 0.04;
 bezsd.cp = [x, 0.2; x,-1.75];
   
%curv2_ppbezier_plot(bezsd,60,'k');

%cuore in basso 
bezCuoreBasso = bezCuoredx;
T = get_mat_trasl([0 -2]);
bezCuoreBasso.cp = point_trans(bezCuoreBasso.cp,T);

%curv2_ppbezier_plot(bezCuoreBasso,60,'c');


%intersezione 
[IP1P2,t1,t2]=curv2_intersect(bezsd, bezCuoredx);

%punti di intersezioni
[p1_sx, p1_dx]=ppbezier_subdiv(bezsd, t1);
%curv2_ppbezier_plot(p1_dx, 60, 'p');

[p2_sx, p2_dx]=ppbezier_subdiv(bezCuoredx, t2);
%curv2_ppbezier_plot(p2_dx, 60, 'p');

% sistemo i gradi
p1_dx = curv2_ppbezier_de(p1_dx, 5);

%unisco i due segmenti
bezSeg11 =curv2_ppbezier_join(p2_dx, p1_dx, tol);
%bezSeg11_fill = curv2_ppbezier_plot(bezSeg11, 60, 'p');

%intersezione 
% curv2_ppbezier_plot(bezSeg11,60,'g',2);
% 
% curv2_ppbezier_plot(bezCuoreBasso,60,'r',2);

[IP1P2,t1,t2]=curv2_intersect(bezSeg11, bezCuoreBasso);

[p3_sx, p3_dx]=ppbezier_subdiv(bezSeg11, t1);
%curv2_ppbezier_plot(p3_dx, 60, 'p');

[p4_sx, p4_dx]=ppbezier_subdiv(bezCuoreBasso, t2);
%curv2_ppbezier_plot(p4_sx, 60, 'p');

%unisco i due segmenti
bezSeg12 =curv2_ppbezier_join(p4_sx, p3_dx, tol);
%bezSeg12_fill = curv2_ppbezier_plot(bezSeg12, 60, 'p');

% specchio la freccia
bezSeg2 = bezSeg12;
bezSeg2.cp = bezSeg12.cp.*[-1 1];
%bezSeg2 = curv2_ppbezier_plot(bezSeg2, 60 ,'p');

bezSeg3 = curv2_ppbezier_join(bezSeg2, bezSeg12, tol);
% bezSeg3_fill = curv2_ppbezier_plot(bezSeg3, -60 ,'r', 5);
% point_fill(bezSeg3_fill, 'b', 'b');


%%%%%%%

curv2_ppbezier_plot(bezC,60,'r');



%rimpicciolisco e traslo il cuore
d= mean(bezC.cp);
bezFreccia=bezSeg3;
C =  [d(1),d(2)];
S = get_mat_scale([0.27,0.27]);
R = get_mat2_rot(2*pi/3);
T = get_mat_trasl(-C);
T1 = get_mat_trasl([-0.20,0.1]);

M = T1*R*S*T;
bezFreccia.cp = point_trans(bezSeg3.cp,M);

bezSeg3_fill = curv2_ppbezier_plot(bezFreccia, 60 ,'r', 5);
point_fill(bezSeg3_fill, 'b', 'b');



%%%%%%
%segmento data media e origine

d(2) = max(bezC.cp(:,2));

bezSegmento.cp = [bezC.cp(1,1),d(2);bezC.cp(1,1),bezC.cp(1,2)];
bezSegmento.ab = [0 1];
bezSegmento.deg = 1;

curv2_ppbezier_plot(bezSegmento,60,'g',2);


%%%%%

[IP1P2,t1,t2]=curv2_intersect(bezFreccia,bezSegmento);
[sx11,dx11]=ppbezier_subdiv(bezFreccia,t1(1));
[bezFrecciasx,dx12]=ppbezier_subdiv(dx11,t1(2));
%curv2_ppbezier_plot(bezFrecciasx,60,'g',2);
%curv2_ppbezier_plot(dx11,60,'c',2);

[IP1P2,t1,t2]=curv2_intersect(bezFreccia,bezC);
[sx11,dx11]=ppbezier_subdiv(bezFreccia,t1(3));
[sx12,dx12]=ppbezier_subdiv(bezFreccia,t1(4));
% curv2_ppbezier_plot(sx12,60,'g',2);
% curv2_ppbezier_plot(dx11,60,'c',2);

%%join
bezFrecciadx = curv2_ppbezier_join(sx12,dx11,1.0-1);
curv2_ppbezier_plot(bezFrecciadx,60,'r');


%%%faccio la figura in figure 2

open_figure(2);
hold on

xy =curv2_ppbezier_plot(bezFrecciadx,-60,'r');
point_fill(xy,'b','r',2);

xy = curv2_ppbezier_plot(bezC,-60,'b');
point_fill(xy,'r','b');

xy =curv2_ppbezier_plot(bezFrecciasx,-60,'r');
point_fill(xy,'b','r',2);



end
