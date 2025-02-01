clear all % Cancella tutte le variabili dalla memoria
close all % Chiude tutte le finestre grafiche aperte

% Configurazione del grafico
open_figure(1); % Apre una nuova figura
hold on % Permette di sovrapporre più elementi sul grafico
grid("on"); % Attiva la griglia nel grafico

% Creazione del volante
p = linspace(0, 2*pi, 16); % Suddivisione in 16 punti uniformi tra 0 e 2*pi

% Calcolo dei punti per i cerchi che compongono il volante
for i = 1:16
    [CrfA(i, 1), CrfA(i, 2)] = c2_circle(p(i), 1); % Cerchio esterno
    [CrfB(i, 1), CrfB(i, 2)] = c2_circle(p(i), 0.9); % Cerchio intermedio
    [CrfC(i, 1), CrfC(i, 2)] = c2_circle(p(i), 0.3); % Cerchio interno
    [Crf(i, 1), Crf(i, 2)] = c2_circle(p(i), 1); % Copia del cerchio esterno
end

% Traslazione dei cerchi lungo l'asse x
CrfB = CrfB + [2 0];
CrfC = CrfC + [2 0];
CrfA = CrfA + [2 0];

% Interpolazione dei cerchi con curve di Bézier
bezCrfA = curv2_bezier_interp(CrfA, 0, 1, 0);
bezCrfB = curv2_bezier_interp(CrfB, 0, 1, 0);
bezCrfC = curv2_bezier_interp(CrfC, 0, 1, 0);
bezCrf = curv2_bezier_interp(Crf, 0, 1, 0);

% Collegamento tra i cerchi B e A
Seg(1, 1:2) = CrfA(1, 1:2); % Punto iniziale
Seg(2, 1:2) = CrfB(1, 1:2); % Punto finale

bezSeg = curv2_bezier_interp(Seg, 0, 1, 0); % Interpolazione del segmento
bezSeg = curv2_ppbezier_de(bezSeg, 14); % Aumento del grado della curva di Bézier

% Unione delle curve B, segmento e A
bezCrfE = curv2_ppbezier_join(bezCrfB, bezSeg, 1.0e-4);
bezCrfF = curv2_ppbezier_join(bezCrfE, bezCrfA, 1.0e-4);

% Creazione del trapezio
valore = 0.2; % Fattore di scala
h = [0 0.45]; % Traslazione

% Definizione delle coordinate dei lati del trapezio
% Lato superiore
TAlto = [
    -1 2
    0 2.1
    1 2
];
TAlto = TAlto * valore + h; % Scala e trasla
bezTAlto = curv2_bezier_interp(TAlto, 0, 1, 0); % Interpolazione
curv2_ppbezier_plot(bezTAlto, 60, 'r'); % Disegna il lato superiore

% Lato destro
TDx = [
    1 2
    1.5 -1
];
TDx = TDx * valore + h; % Scala e trasla
bezTDx = curv2_bezier_interp(TDx, 0, 1, 0); % Interpolazione
bezTDx = curv2_ppbezier_de(bezTDx, 1); % Aumento grado
bezATdx = curv2_ppbezier_join(bezTDx, bezTAlto, 1.0e-4); % Unione con lato superiore
curv2_ppbezier_plot(bezTDx, 60, 'r'); % Disegna lato destro

% Lato sinistro
TSx = [
    -1 2
    -1.5 -1
];
TSx = TSx * valore + h; % Scala e trasla
bezTSx = curv2_bezier_interp(TSx, 0, 1, 0); % Interpolazione
bezTSx = curv2_ppbezier_de(bezTSx, 1); % Aumento grado
bezTAdxsx = curv2_ppbezier_join(bezTSx, bezATdx, 1.0e-4); % Unione con lato destro
curv2_ppbezier_plot(bezTAdxsx, 60, 'r'); % Disegna lato sinistro

% Lato inferiore
TBasso = [
    -1.5 -1
    0 -0.5
    1.5 -1
];
TBasso = TBasso * valore + h; % Scala e trasla
bezTBasso = curv2_bezier_interp(TBasso, 0, 1, 0); % Interpolazione
bezTT = curv2_ppbezier_join(bezTBasso, bezTAdxsx, 1.0e-4); % Unione con lati precedenti
curv2_ppbezier_plot(bezTT, 60, 'r'); % Disegna lato inferiore

% Traslazione e rotazione del trapezio
% Restante codice simile per rotazioni e animazioni



%traslo e ruoto
%bezTTC
bezTTC = bezTT;
bezTTC.cp = bezTT.cp +[2 0];
%bezttA
bezTTB = bezTT;
q=2*pi/3;
bezTTB.cp = bezTT.cp*[cos(q) -sin(q); sin(q) cos(q)]+[2 0];

curv2_ppbezier_plot(bezTTB,60,'m');
%bezttA
bezTTA = bezTT;
q=-2*pi/3;
bezTTA.cp = bezTT.cp*[cos(q) -sin(q); sin(q) cos(q)]+[2 0];

curv2_ppbezier_plot(bezTTA,60,'g');

%inizio a traslare il manubrio sulla crf
p1 = linspace(0,2*pi,300);

for i=1:25
    cla;
    axis([-3, 3, -3, 3]);
   xy= curv2_ppbezier_plot(bezCrf,60,'g');
fill(xy(:,1),xy(:,2),'r')

    %rotazione cerchio
    B=[0 0];
%definisce matrice di traslazione
    T=get_mat_trasl(-B);
    Tinv=get_mat_trasl(B);
    R=get_mat2_rot(p1(i));
    M=Tinv*R*T;

    %rotazione cp F
   bezCrfF.cp=point_trans(bezCrfF.cp,M);
   xy =curv2_ppbezier_plot(bezCrfF,60,'k-');
fill(xy(:,1),xy(:,2),'b');
    
%copro il segmento
bezSeg.cp=point_trans(bezSeg.cp,M);
curv2_ppbezier_plot(bezSeg,60,'b-');

   

%rotazione cp C
   bezCrfC.cp=point_trans(bezCrfC.cp,M);
  xy= curv2_ppbezier_plot(bezCrfC,60,'k-');
fill(xy(:,1),xy(:,2),'r')
%rotazione cp TTC
   bezTTC.cp=point_trans(bezTTC.cp,M);
  % curv2_ppbezier_plot(bezTTC,60,'k-');

%rotazione cp TTB
   bezTTB.cp=point_trans(bezTTB.cp,M);
   %curv2_ppbezier_plot(bezTTB,60,'k-');

   %rotazione cp TTA
   bezTTA.cp=point_trans(bezTTA.cp,M);
   %curv2_ppbezier_plot(bezTTA,60,'k-');

%rotazione trapezi
B=mean(bezCrfC.cp(1:16,:));

%definisce matrice di traslazione
T=get_mat_trasl(-B);
Tinv=get_mat_trasl(B);

   R=get_mat2_rot(p1(i));
   M=Tinv*R*T;
   %TTA
   bezTTA.cp=point_trans(bezTTA.cp,M);
   xy=curv2_ppbezier_plot(bezTTA,60,'k-');
fill(xy(:,1),xy(:,2),'r')
%TTB
   bezTTB.cp=point_trans(bezTTB.cp,M);
   xy=curv2_ppbezier_plot(bezTTB,60,'k-');
    fill(xy(:,1),xy(:,2),'r')
%TTC
   bezTTC.cp=point_trans(bezTTC.cp,M);
 xy=  curv2_ppbezier_plot(bezTTC,60,'k-');
    fill(xy(:,1),xy(:,2),'r')



    % Salvataggio fotogramma
    m(i) = getframe;
    % Aggiungi un piccolo ritardo (es. 0.1 secondi)
    pause(0.1);
    
end

% Creazione del filmato (6 fotogrammi al secondo)
movie(m, 1,6);






