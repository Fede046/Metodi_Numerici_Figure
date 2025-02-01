
function main()
close all
% 
% Esercizio d'esame di MNC2425
% Fare uno script per riprodurre il disegno di Figure 2 e le stampe richieste.
% Il quadrato smussato si ottenga mediante modellazione procedurale a partire da un
% quadrato centrato nell'origine e lato 2. Il secondo quadrato smussato sia
% scalato in modo uniforme di 0.97, il terzo di 0.65.
% La curva sinusoidale si ricostruisca, per interpolazione di Hermite, della curva
% in forma parametrica: x(t)=s*t-1.25, y(t)=s*sin(t) con s=0.1 e t in [0,8*pi], con
% una curva di Bézier cubica a tratti, con 2.5e-2 <= MaxErr <= 5.5e-02.
% Si determini e stampi il perimetro della regione sinusoidale verde.
% 
% ---Stampe---
% MaxErr: 3.378787e-02
% Perimetro regione sinusoidale verde: 3.659953e+00

%%impostazioni grafiche
open_figure(3);
hold on;
grid("on");


%utilizzo il quadrato preso dalla esercitazione 6
%definiamo un poligono regolare di 4 vertici e lati
nv=5;
%utilizzo la funzione circle2_plot della libreiria per trovare i punti
%della crf
[xp,yp]=circle2_plot([0,0],sqrt(2),-nv);
%compongo una matrice Q con i vettori trasposti dati dalla funzione
Q=[xp',yp'];

%disegna i punti
%point_plot(Q,'ko',1,'k');

%ruotiamo il poligono di pi/4
R=get_mat2_rot(pi/4);
%S = get_mat_scale([2 2]);
Q=point_trans(Q,R);
%point_plot(Q,'ko',1,'k');


%smussiamo gli angoli
ppP.deg=2;
%quantita' di smooth
d=0.4;
ppP.cp=[Q(1,:)+[0,-d];Q(1,:);Q(1,:)+[-d,0];
        0.5.*(Q(1,:)+Q(2,:));Q(2,:)+[d,0];
        Q(2,:);Q(2,:)+[0,-d];
        0.5.*(Q(2,:)+Q(3,:));Q(3,:)+[0,+d];
        Q(3,:);Q(3,:)+[d,0];
        0.5.*(Q(3,:)+Q(4,:));Q(4,:)+[-d,0];
        Q(4,:);Q(4,:)+[0,d];
        0.5.*(Q(4,:)+Q(5,:));Q(5,:)+[0,-d]];
ppP.ab=0:8;
%point_plot(ppP.cp,'b-o');

np=20;
%disegna curva di bezier a tratti
%Pxy=curv2_ppbezier_plot(ppP,np,'k-',1.5);


%%%ruoto ppP
R = get_mat2_rot(pi/4);
ppP.cp = point_trans(ppP.cp,R);
%disegno
curv2_ppbezier_plot(ppP,50,'r');
%%%scalo in modo da creare i 3 quadrati
ppPG = ppP;
ppPM = ppP;
ppPS = ppP;

%medio
S = get_mat_scale([0.97 0.97]);
ppPM.cp = point_trans(ppPM.cp,S);


%piccolo applico una rotazione inversa per facilitarmi posizioni delle
%sinusoidi
S = get_mat_scale([0.65 0.65]);
R = get_mat2_rot(-pi/4);
ppPS.cp = point_trans(ppPS.cp,S*R);

%%plotto
curv2_ppbezier_plot(ppPS,60,'b');
curv2_ppbezier_plot(ppPM,60,'g');
curv2_ppbezier_plot(ppPG,60,'r');

%%%%%%%%%%%%%
%%%%facccio la sinusoide 
% t della consegna prendo 30 punti perchè se faccio di meno la figura mi
% risulta differente da quella dell'immagine
t = linspace(0,8*pi,30);
%Creo una funzione con le funzioni parametriche dei dati
[Sin(:,1),Sin(:,2)] = c2_sinus(t);
%applica una interpolazione di Hermite con interpCC1
ppbezSin = curv2_ppbezierCC1_interp(Sin,0,8*pi,0);


%%%%calcolo l'errore
p = linspace(0,8*pi);
%%utilizzo ppbezier val per trovare le coordinate di tutti i punti della
%%curva di bez a tratti
Pxy = ppbezier_val(ppbezSin,p);
%%per la stessa linspace utilizzata per ppbezier_val trovo
[Qxy(:,1),Qxy(:,2)] = c2_sinus(p);

MaxErr=max(vecnorm((Pxy-Qxy)'));
fprintf('MaxErr: %e\n',MaxErr);

%creo due sinusoidi come in figura
ppbezSinD = ppbezSin;
ppbezSinU = ppbezSin; 
%scelgo 41 perchè dal disegno della mi sembra valido
l = linspace(-1,1,41);
T = get_mat_trasl([0,l(18)]);
ppbezSinD.cp = point_trans(ppbezSin.cp,T);

%la secondo sinusoide la faccio inversa della prima
ppbezSinU.cp = -ppbezSinD.cp;
curv2_ppbezier_plot(ppbezSinD,60,'b');
curv2_ppbezier_plot(ppbezSinU,60,'r');

%%%faccio le intersezioni tra le sinusoidi e il quadrato
[IP1P2,t1,t2]=curv2_intersect(ppPS,ppbezSinD);
[IP1P2,t1,t2]=curv2_intersect(ppPS,ppbezSinU);


%%trovo le intersezioni dei segmenti
%utilizzo un ciclo for per trovare le curve di entrambi i segmenti
ppbezSinD0 = ppbezSinD;
for i=1:2
    if i==2
        ppbezSinD0 = ppbezSinU;
    end
[sx21,dx21]=ppbezier_subdiv(ppbezSinD0,t2(1));
[sx22,dx22]=ppbezier_subdiv(sx21,t2(2));

%salvo la parte del seg
if i==2 

bezSegU = dx22;  

else

bezSegD = dx22;  

end
end

%trovo le intersezioni tra le curva di bez delle sinusoide con il
%rettangolo
[IP1P2,t1D,t2D]=curv2_intersect(ppPS,ppbezSinD);
[IP1P2,t1U,t2U]=curv2_intersect(ppPS,ppbezSinU);

%prendo la parte t1 della curva del quadrato 
[sx11,dx11]=ppbezier_subdiv(ppPS,t1U(1));
[sx12,dx12]=ppbezier_subdiv(dx11,t1D(1));
%curv2_ppbezier_plot(sx12,60,'g',2);
%salvo la curva
bezQuaddx = sx12;

%prendo la parte t2 della curva del quadrato 
[sx11,dx11]=ppbezier_subdiv(ppPS,t1D(2));
[sx12,dx12]=ppbezier_subdiv(dx11,t1U(2));
%curv2_ppbezier_plot(sx12,60,'g',2);
%salvo la curva
bezQuadsx = sx12;


%%%join di tutte le parti in  modo da avere una specie di rettangolo con le
%%%sinusoidi
%alzo il grado della parte del quadrato in modo da fare il join tra la
%sinusoide (grado 3) e il quandrato (grado 2) 
bezQuadsx = curv2_ppbezier_de(bezQuadsx,bezSegU.deg-bezQuadsx.deg);

ppbezSin0 = curv2_ppbezier_join(bezQuadsx,bezSegU,1.0e-2);

%alzo il grado della parte del quadrato in modo da fare il join tra la
%sinusoide (grado 3) e il quandrato (grado 2) 

bezQuaddx = curv2_ppbezier_de(bezQuaddx,bezSegU.deg-bezQuaddx.deg);

ppbezSin1 = curv2_ppbezier_join(bezQuaddx,ppbezSin0,1.0e-2);
%join finale che mi da la curva di bez a tratti della ragione verde
ppbezSinF = curv2_ppbezier_join(bezSegD,ppbezSin1,1.0e-2);

curv2_ppbezier_plot(ppbezSinF,70,'m',4);

%%ruoto ppbezSinF e ppPS entrambe di pi/4 in modo che sia coerente alla
%%figuara data
R = get_mat2_rot(3*pi/4);
ppPS.cp = point_trans(ppPS.cp,R);
ppbezSinF.cp = point_trans(ppbezSinF.cp,R);



%%calcolo il perimetro
%disegno della curva a tratti
ppP = ppbezSinF;
nt=length(ppP.ab)-1;
[ncp,~] = size(ppP.cp);
val = 0;
%estrae le singole curve di Bezier e calcola la loro lunghezza
bez.deg=ppP.deg;
for i=1:nt
   i1=(i-1)*ppP.deg+1;
   i2=i1+ppP.deg;
   bez.cp=ppP.cp(i1:i2,:);
   bez.ab=[ppP.ab(i),ppP.ab(i+1)];
   %sommo la lunghezza del tratto
   val =val+integral(@(x)norm_c1_val(bez,x),bez.ab(1),bez.ab(2));
end
fprintf('Perimetro regione sinusoidale verde: %e\n',val);

%%%%grafico in open figure 2
open_figure(2);
set(gca,'color',[0.80, 0.84 ,0.97]);

%dispongo nell'ordine le mie curve di bez a tratti e faccio i relativi fill

%bianco
xy = curv2_ppbezier_plot(ppPG,-60,'k',2);
point_fill(xy,'w','k',2);
%blu
xy = curv2_ppbezier_plot(ppPM,-60,'k',2);
point_fill(xy,'b','k',2);
%giallo
xy = curv2_ppbezier_plot(ppPS,-60,'k',2);
point_fill(xy,'y','k',2);
%verde
xy = curv2_ppbezier_plot(ppbezSinF,-60,'k',2);
point_fill(xy,'g','k',2);





function [x,y]= c2_sinus(t)
s=0.1;   
x=s*t-1.25;
  y=s*sin(t);
end
end