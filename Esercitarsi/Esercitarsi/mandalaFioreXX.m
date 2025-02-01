clear all
close all

%%grafic setting
open_figure(1);
hold on;
grid("on");

%%circonferenza
l = linspace(0,2*pi,8);
[Crf(:,1),Crf(:,2),Crf1(:,1),Crf1(:,2)] = cp2_circle(l);
bezblu = curv2_ppbezierCC1_interp_der(Crf,Crf1,l);
S = get_mat_scale([0.1,0.1]);
bezblu.cp  = point_trans(bezblu.cp,S);
xy = curv2_ppbezier_plot(bezblu,60,'b',2);
point_fill(xy,'b','b');

%%%quarti di crf per fare i petali
l = linspace(0,pi/2,8);
[Crf(:,1),Crf(:,2),Crf1(:,1),Crf1(:,2)] = cp2_circle(l);
bezQuart = curv2_ppbezierCC1_interp_der(Crf,Crf1,l);

[ppbQ,T,R]=align_curve (bezQuart) ;
%Cambia il segno delle coordinate y dei puntii di controllo della curva
%ppbQ. Questo crea una riflessione (simmetrice) della curva ppbQ rispetto
%all'asse x
ppbQ.cp(: ,2)=-ppbQ.cp(: ,2) ;
%Si calcola Minv, l'inversa della combinazione R*T, che serve a riportare
%la curva ppbQ nella sua posizione originale, ma nella versione riflessa
Minv=inv(R*T) ;
%funzione che applica questa trasformazione inversa a ppbQ, così che la
%curva rispecchiata mantenga la sua forma simmetrica, ma si riallinei alla
%posizione originale della curva ppbP
ppbQ.cp=point_trans(ppbQ.cp ,Minv) ;

%%%%join
ppbezQ = curv2_ppbezier_join(ppbQ,bezQuart,1.0e-2);

function [ppbezQ,T,R]=align_curve (ppbezP)
%numero totale di punti di controllo della curva
ncp=length(ppbezP.cp(: ,1) ) ;
ppbezQ=ppbezP;
%1 Traslazione
%T è una matrice di traslazione che sposta il primo punto della curva
%ppbezP, all'origine del sistema di coordinate.In pratic a, viene
%calcolato il vettore di spostamento che porta il primo punto (x1,y1)
%della curva a (0,0)
T=get_mat_trasl(-ppbezP.cp(1 ,:) ) ;
%alfa è l'angolo tra la linea che collega il primo punto e l'ultimo punto
%della curva e l'asse x. atan2 calcola l'angolo (in radianti) a partire
%dalle differenze y e x tra il punto finale e il punto iniziale. L'angolo
%è negativo per ruotare in senso orario, portando così il segmento
%iniziale-finale a essere orizzontale.
alfa = -atan2(ppbezP.cp(ncp ,2) - ppbezP.cp(1 ,2) , ppbezP.cp(ncp ,1) - ppbezP.cp(1 ,1)) ;
%R è una matrice di rotazione che ruota i punti della curva di alfa
%radianti, allineando il segmento tra primo e ultimo con l'asse x.
%Definisce la matrice 3x3 di rotazione 2D in base all'angolo alfa in input
R=get_mat2_rot(alfa ) ;
%La matrice M combina la traslazione T e la rotazione R. Viene poi
%applicata alla curva ppbezP per trasformare tutti i suoi punti di
%controllo, ottenendo ppbezQ, una curva allineata orizzontalmente e pronta
%per l'operazione di simmetria
M=R*T;
%point_trans calcola le lista di punti 2D dopo averli trasformati con la
%matrice M ( matrice di trasformazione)
ppbezQ.cp=point_trans(ppbezP.cp ,M) ;
end


%%metto il petalo in verticale
%%%per evitare che i petali ruotino (in modo brutto)
%%%%%rotazione rispetto al suo baricentro
B=mean(ppbezQ.cp);
%definisce matrice di traslazione
T=get_mat_trasl(-B);
Tinv=get_mat_trasl(B);
%definisce angolo alfa di rotazione
alfa=-pi/4;
%definisce matrice di rotazione usando la get_mat2_rot
R=get_mat2_rot(alfa);
%definisce matrice composta di rotazione rispetto al baricentro
M=Tinv*R*T;
ppbezQ.cp = point_trans(ppbezQ.cp,M);
% curv2_ppbezier_plot(ppbezQ,60,'r',2);



%%%faccio i petali rossi
%scala
ppR = ppbezQ;
S = get_mat_scale([1 1]);
ppR.cp = point_trans(ppR.cp,S);

%traslazione dal centro 
C = ppR.cp(1,:);
T = get_mat_trasl(-C);
T1 = get_mat_trasl([0 0.2]);
M = T*T1;
ppR.cp = point_trans(ppR.cp,M);

%rotazione tipo mandala
ncurv = 8;
ppR1 = ppR;
teta = linspace(pi/7,2*pi+pi/7,ncurv);
np =40;
for i=1:ncurv
    ang = teta(i);
    R = get_mat2_rot(ang);
    ppR1.cp = point_trans(ppR.cp,R);
    xy  = curv2_ppbezier_plot(ppR1,-np,'k');
    point_fill(xy,'r','k');
end

%%%faccio i petali verdi
%scala
ppR = ppbezQ;
S = get_mat_scale([0.3 0.3]);
ppR.cp = point_trans(ppR.cp,S);

%traslazione dal centro 
C = ppR.cp(1,:);
T = get_mat_trasl(-C);
T1 = get_mat_trasl([0 0.1]);
M = T*T1;
ppR.cp = point_trans(ppR.cp,M);
curv2_ppbezier_plot(ppR,60,'r');

%rotazione tipo mandala
ncurv = 8;
ppR1 = ppR;
teta = linspace(0,2*pi,ncurv);
np =40;
for i=1:ncurv
    ang = teta(i);
    R = get_mat2_rot(ang);
    ppR1.cp = point_trans(ppR.cp,R);
    xy  = curv2_ppbezier_plot(ppR1,-np,'k');
    point_fill(xy,'g','k');
end






