clear all
close all

% Apertura della figura e impostazione della griglia
open_figure(1);
grid("on");

% Il fiore è formato da pistillo e petali (foglie) attorno al pistillo

% Pistillo P

% Ciclo for per generare un cerchio usando curve di Bézier
ik = 1;
for i=0:pi/4:2*pi
   [P(ik,1),P(ik,2)] = c2_circle(i,0.5); % Calcola i punti del cerchio
   ik = ik + 1;
end
P = P + [1 0]; % Traslazione del pistillo lungo l'asse x

% Interpolazione dei punti del pistillo con una curva di Bézier
bPP = curv2_bezier_interp(P,0,1,1);
xy = curv2_ppbezier_plot(bPP,60,'k-'); % Tracciamento del pistillo
fill(xy(:,1),xy(:,2),'b'); % Colorazione del pistillo in blu

% Petali F

% Definizione dei punti base per un petalo
F = [
    0 0
    1 0.4
    2 0
];
bPF = curv2_bezier_interp(F,0,1,1); % Interpolazione del petalo con una curva di Bézier

% Creazione della simmetria del petalo
[ppbF, T, R] = align_curve(bPF); % Allinea la curva al punto iniziale
ppbF.cp(:,2) = -ppbF.cp(:,2); % Riflette la curva rispetto all'asse x
Minv = inv(R*T); % Matrice inversa per il ritorno alla posizione originale
ppbF.cp = point_trans(ppbF.cp, Minv); % Trasformazione inversa

% Unione delle due metà del petalo in una curva unica
ppbFo = curv2_ppbezier_join(ppbF, bPF, 1.0e-4);

% Rimpicciolimento del petalo e traslazione
ppbFo.cp = (ppbFo.cp * 0.7) + [1.5 0];

% Rotazione del petalo

ppbFoR.ab = ppbFo.ab; % Copia dei parametri della curva originale
ppbFoR.deg = ppbFo.deg;

% Trova il centro della curva del pistillo
B = [1 0]; % Centro del pistillo (assunto noto)

% Definizione delle matrici di traslazione e rotazione
T = get_mat_trasl(-B); % Traslazione al centro
Tinv = get_mat_trasl(B); % Traslazione inversa
alfa = pi/4; % Angolo di rotazione
R = get_mat2_rot(alfa); % Matrice di rotazione
M = Tinv * R * T; % Matrice composta per rotazione rispetto al baricentro

% Rotazione dei petali attorno al pistillo
for i=-0.1:pi/3.5:2*pi
    R = get_mat2_rot(i); % Aggiornamento angolo di rotazione
    M = Tinv * R * T; % Matrice di trasformazione
    ppbFoR.cp = point_trans(ppbFo.cp, M); % Trasformazione dei punti del petalo
    xy = curv2_ppbezier_plot(ppbFoR,60,'k-'); % Tracciamento del petalo
    fill(xy(:,1),xy(:,2),'g'); % Colorazione dei petali in verde
end

% Disegno di un secondo livello di petali più grandi
for i=((pi/3.5)-0.2)/2:pi/3.5:2*pi
    R = get_mat2_rot(i);
    M = Tinv * R * T;
    ppbFoR.cp = point_trans(ppbFo.cp.*[2.5,2.5]+[-1.85 0], M); % Scala e traslazione del petalo
    xy = curv2_ppbezier_plot(ppbFoR,60,'k-');
    fill(xy(:,1),xy(:,2),'r'); % Colorazione dei petali in rosso
end

% Funzione per l'allineamento delle curve
function [ppbezQ, T, R] = align_curve(ppbezP)
    ncp = length(ppbezP.cp(:,1));
    ppbezQ = ppbezP; % Copia della curva originale
    T = get_mat_trasl(-ppbezP.cp(1,:)); % Traslazione al punto iniziale
    alfa = -atan2(ppbezP.cp(ncp,2) - ppbezP.cp(1,2), ppbezP.cp(ncp,1) - ppbezP.cp(1,1)); % Calcolo dell'angolo
    R = get_mat2_rot(alfa); % Matrice di rotazione
    M = R * T; % Matrice composita
    ppbezQ.cp = point_trans(ppbezP.cp, M); % Trasformazione dei punti
end
