clear all
close all

% Impostazioni grafiche
open_figure(1); % Crea una nuova figura
hold on; % Mantiene i grafici precedenti nella stessa finestra
grid("on"); % Attiva la griglia

% Creazione di un anello formato da due circonferenze

% Prima semicerchia superiore
p = linspace(-pi/4, (3*pi)/4, 8); % Divide l'intervallo in 8 punti

for i = 1:8
    % Coordinate della circonferenza esterna e interna
    [A0(i,1), A0(i,2)] = c2_circle(p(i), 1); 
    [A1(i,1), A1(i,2)] = c2_circle(p(i), 0.7); 
end

% Generazione delle curve di Bézier dai punti delle circonferenze
Cf0 = curv2_bezier_interp(A0, 0, 1, 1); 
Cf1 = curv2_bezier_interp(A1, 0, 1, 1); 

% Stampa delle curve
curv2_ppbezier_plot(Cf0, 60, 'g'); % Curva esterna (verde)
curv2_ppbezier_plot(Cf1, 60, 'b'); % Curva interna (blu)

% Creazione di segmenti tra le circonferenze
s = linspace(0.7, 1, 8); % Divisione dei segmenti
for i = 1:8
    Aseg(i,1) = s(i);
    Aseg(i,2) = 0; % Segmento lungo l'asse x
end

% Rotazione dei segmenti
q = -pi/4; % Angolo di rotazione per la parte iniziale
AsegB = Aseg * [cos(q), sin(q); -sin(q), cos(q)];
q = (3*pi)/4; % Angolo di rotazione per la parte finale
AsegA = Aseg * [cos(q), sin(q); -sin(q), cos(q)];

% Creazione di una curva di Bézier per i segmenti
Sg0 = curv2_bezier_interp(AsegB, 0, 1, 1);

% Stampa della curva
curv2_ppbezier_plot(Sg0, 60, 'k'); % Segmento di congiunzione (nero)

% Creazione della curva unita (circonferenza e segmento)
C0S = curv2_ppbezier_join(Sg0, Cf0, 1.0e-4); 
C0SC1 = curv2_ppbezier_join(C0S, Cf1, 1.0e-4);
xy = curv2_ppbezier_plot(C0SC1, 60, 'r'); % Curva unita (rosso)
fill(xy(:,1), xy(:,2), 'g'); % Riempie l'area con il colore verde
point_plot(AsegA, 'g'); % Mostra i punti di rotazione finali

% Duplicazione della curva per creare un'altra semicerchia
C0SC1B.cp = -C0SC1.cp; % Riflette i punti di controllo
C0SC1B.ab = C0SC1.ab; % Mantiene le estremità della curva
C0SC1B.deg = C0SC1.deg; % Mantiene il grado della curva

xy = curv2_ppbezier_plot(C0SC1B, 60, 'r'); % Stampa la curva riflessa
fill(xy(:,1), xy(:,2), 'g'); % Riempie l'area riflessa
point_plot(AsegA, 'g'); % Mostra i punti di riflessione

% Ripetizione delle operazioni per creare le altre parti dell'anello
% Viene spostata progressivamente l'area per disporre altre semicerchie

% Prima in alto a destra
C0SC1B.cp = -C0SC1.cp; % Riflette di nuovo i punti di controllo
C0SC1B.ab = C0SC1.ab;
C0SC1B.deg = C0SC1.deg;

xy = curv2_ppbezier_plot(C0SC1B, 60, 'r');
fill(xy(:,1), xy(:,2), 'r');
point_plot(AsegA, 'r');

% Altri spostamenti per le semicerchie successive
% Seconda
C0SC1B.cp = -C0SC1.cp + [0.8, -0.8]; % Spostamento
xy = curv2_ppbezier_plot(C0SC1B, 60, 'g');
fill(xy(:,1), xy(:,2), 'g');
point_plot(AsegA + [0.8, -0.8], 'g');

% Terza
C0SC1B.cp = -C0SC1.cp + [1.6, -1.6];
xy = curv2_ppbezier_plot(C0SC1B, 60, 'b');
fill(xy(:,1), xy(:,2), 'b');
point_plot(AsegA + [1.6, -1.6], 'b');

% Quarta
C0SC1B.cp = C0SC1.cp + [1.6, -1.6];
xy = curv2_ppbezier_plot(C0SC1B, 60, 'b');
fill(xy(:,1), xy(:,2), 'b');
point_plot(AsegA + [1.6, -1.6], 'b');

% Quinta
C0SC1B.cp = C0SC1.cp + [0.8, -0.8];
xy = curv2_ppbezier_plot(C0SC1B, 60, 'g');
fill(xy(:,1), xy(:,2), 'g');
point_plot(AsegA + [0.8, -0.8], 'g');

% Sesta
C0SC1B.cp = C0SC1.cp;
xy = curv2_ppbezier_plot(C0SC1B, 60, 'r');
fill(xy(:,1), xy(:,2), 'r');
point_plot(AsegA, 'r');

% Mostra i punti dei segmenti per ogni riflessione/spostamento
point_plot(AsegB, 'r');
point_plot(AsegB + [0.8, -0.8], 'g');
point_plot(AsegB + [1.6, -1.6], 'b');

% Conclusione: Per colorare correttamente, è importante collegare i punti estremi della curva
% con segmenti, evitando discontinuità anche con intervalli molto densi.


%conclusioni: Per colorare creo un segmento che collega, che collega il
%primo punto della crf con il primo punto del segmento, successivamente quel segmento viene oscurato, 
% esmpio: se la fugura ha come primo punto (2.40,3.31) il segmento di collegamento dovrà iniziare da 
% qel punto altrimenti quando si fa la join verrà considerato discontinuo,
% anche se il linspace è molto fitto. Il segmento può essere anche non un
% segmento per esempio un arco però la cosa importantissima è che gli
% estremi del segmento devono essere punti della curva di bez joinata