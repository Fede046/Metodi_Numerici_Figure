clear all
close all
%grafic setting
open_figure(1);
hold on;
grid("on");


%carico il cuore in una curva di bez
bezCuo=curv2_bezier_load('c2_bezier_heart.db');


a=0;
b=1;
npt=150;
t=linspace(a,b,npt);
Pxy=ppbezier_val(bezCuo,t);
point_plot(Pxy,'m',9);
Massimay = max(Pxy(:,2));
Minimay = min(Pxy(:,2));

bezCuoEsterno=bezCuo;
S=get_mat_scale([1.05,1.05]);
bezCuoEsterno.cp=point_trans(bezCuoEsterno.cp,S);
T = get_mat_trasl([0 -0.01]);
bezCuoEsterno.cp=point_trans(bezCuoEsterno.cp,T);

curv2_ppbezier_plot(bezCuo,60,'r',2);

%faccio il segmento 
p = linspace(Minimay,Massimay,4);
%p = linspace(0,0.35,4);
%tronco perchè i dati del db sono decimali, (penso sia per questo motivo)
p = fix(p * 10) / 10;
x = [0.2,-0.2];

%per fare le curve di bez si potrebbe anche usare curv2_bezier_interp
%deg 
Seg1.deg = 1;
Seg2.deg = Seg1.deg;
Seg3.deg = Seg1.deg;
Seg4.deg = Seg1.deg;

%ab
Seg1.ab=[0 1];
Seg2.ab = Seg1.ab;
Seg3.ab = Seg2.ab;
Seg4.ab = Seg3.ab;

%cp
Seg1.cp = [x(1),p(1);x(2),p(1)];
Seg2.cp = [x(1),p(2);x(2),p(2)];
Seg3.cp = [x(1),p(3);x(2),p(3)];
Seg4.cp = [x(1),p(4);x(2),p(4)];


curv2_ppbezier_plot(Seg3,60,'k',2);

%intersezioni
[IP1P2,t1,t2]=curv2_intersect(bezCuo,Seg2);

%intersezioni cuore
[sx12,dx12]=ppbezier_subdiv(bezCuo,t1(1));
 %curv2_ppbezier_plot(sx12,60,'g',2);
 %curv2_ppbezier_plot(dx12,60,'b',2);


[sx11,dx11]=ppbezier_subdiv(bezCuo,t1(2));
%curv2_ppbezier_plot(sx11,60,'g',2);
%curv2_ppbezier_plot(dx11,60,'b',2);

%join parte sotto
tol = 1.0e-2;
bezCuorB = curv2_ppbezier_join(dx12,sx11,tol);
%curv2_ppbezier_plot(bezCuorB,60,'m',2);


%tratto di intersezione del segmanto

[sx21,dx21]=ppbezier_subdiv(Seg2,t2(1));
 %curv2_ppbezier_plot(sx21,60,'g',2);
 %curv2_ppbezier_plot(dx21,60,'b',2);

[sx22,Seg2]=ppbezier_subdiv(sx21,t2(2));
%curv2_ppbezier_plot(sx22,60,'g',2);
curv2_ppbezier_plot(Seg2,60,'b',2);

%join tra la curva del segmento e del cuore
Seg2=curv2_ppbezier_de(Seg2,bezCuorB.deg-Seg2.deg);

bezBasso = curv2_ppbezier_join(Seg2,bezCuorB,tol);
%curv2_ppbezier_plot(bezBasso,60,'k',3);

%%%%%parte nel mezzo

%parte sopra la parte bassa del cuore
[sx12,dx12]=ppbezier_subdiv(bezCuo,t1(1));
 %curv2_ppbezier_plot(sx12,60,'g',2);
 %curv2_ppbezier_plot(dx12,60,'b',2);


[sx11,bezCuorM]=ppbezier_subdiv(sx12,t1(2));
%curv2_ppbezier_plot(sx11,60,'g',2);
%curv2_ppbezier_plot(bezCuorM,60,'b',2);

%join tra seg2 e bezCuorM

Seg2=curv2_ppbezier_de(Seg2,bezCuorM.deg-Seg2.deg);

bezMedio1 = curv2_ppbezier_join(Seg2,bezCuorM,tol);

%curv2_ppbezier_plot(bezMedio1,60,'g',2)

%intersezione col segmento 3 (superiore)

[IP1P2,t1,t2]=curv2_intersect(bezMedio1,Seg3);


%intersezioni cuore
[sx11,dx11]=ppbezier_subdiv(bezMedio1,t1(1));
 curv2_ppbezier_plot(sx11,60,'g',2);
 %curv2_ppbezier_plot(dx11,60,'b',2);


[sx12,dx12]=ppbezier_subdiv(bezMedio1,t1(2));
%curv2_ppbezier_plot(sx12,60,'g',2);
curv2_ppbezier_plot(dx12,60,'b',2);


%join tra le due parti
bezMedio2 = curv2_ppbezier_join(dx12,sx11,tol);
curv2_ppbezier_plot(bezMedio2,60,'c',3);

%parte del segmento

%intersezioni cuore
[sx21,dx21]=ppbezier_subdiv(Seg3,t2(1));
 %curv2_ppbezier_plot(sx21,60,'g',2);
 %curv2_ppbezier_plot(dx21,60,'b',2);


[sx22,Seg3]=ppbezier_subdiv(sx21,t2(2));
%curv2_ppbezier_plot(sx22,60,'g',2);
curv2_ppbezier_plot(Seg3,60,'b',2);

%join tra la curva del segmento e quella del cuore

Seg3=curv2_ppbezier_de(Seg3,bezMedio2.deg-Seg3.deg);

bezMedio = curv2_ppbezier_join(Seg3,bezMedio2,tol);

curv2_ppbezier_plot(bezMedio,60,'y',3);


%per l'altra parte superiore coloro il cuore totale 
%(si poteva fare con la parte centrale)

%%%%%%%%%%%%%%%%%%%%%%
open_figure(2);

%compongo


xy =curv2_ppbezier_plot(bezCuoEsterno,60,'w');
point_fill(xy,'w','k');


xy =curv2_ppbezier_plot(bezCuo,60,'k');
point_fill(xy,'k','k');

xy =curv2_ppbezier_plot(bezMedio,60,'r');
point_fill(xy,'r','r');


xy =curv2_ppbezier_plot(bezBasso,60,'y');
point_fill(xy,'y','y');





%calcolo dell'area
Area = curv2_ppbezier_area(bezCuoEsterno);
fprintf('Area cuore grande: %e\n',Area);


%calcolo il perimetro
nt=length(bezCuoEsterno.ab)-1;
[ncp,~] = size(bezCuoEsterno.cp);
val = 0;
%estrae le singole curve di Bezier e calcola la loro lunghezza
bez.deg=bezCuoEsterno.deg;
for i=1:nt
   %vcol=col(mod(i,7)+1); colorazione della curve di bez atratti colorate
   %spezzettate (non implementato)
   i1=(i-1)*bezCuoEsterno.deg+1;
   i2=i1+bezCuoEsterno.deg;
   bez.cp=bezCuoEsterno.cp(i1:i2,:);
   bez.ab=[bezCuoEsterno.ab(i),bezCuoEsterno.ab(i+1)];
   val =val+integral(@(x)norm_c1_val(bez,x),bez.ab(1),bez.ab(2));
end
fprintf('Lunghezza della curva: %e\n',val);


function val = norm_c1_val(bezier,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calcola il valore della funzione ||C'(t)|| con C(t) curva di Bezier 2D
%bezier --> struttura di una curva di Bezier:
%           bezier.deg --> grado della curva
%           bezier.cp  --> lista dei punti di controllo (bezier.deg+1)x2
%           bezier.ab  --> intervallo di definizione
%t --> valore/i parametrici in cui valutare
%val <-- valore/i della funzione ||C'(t)|| in corrispondenza di t
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Pt=decast_valder(bezier,1,t);
%norm sta per norma
for i=1:length(t)
   val(i)=norm([Pt(2,i,1),Pt(2,i,2)],2);
end
end

%trovo la prima tangente
%notiamo l'effetto di curv2_ppbezier_reverse
%bezCuoEsterno=curv2_ppbezier_reverse(bezCuoEsterno);
%uso la funzione della libreria curv2_bezier_tan_plot
%Px = curv2_bezier_tan_plot(bezCuoEsterno,2,'c-',2);
% Px=decast_valder(bezP,1,0)

%se abbiamo delle limitazioni della tolleranza:
% esempio ci impone una tolleranza di tol = 1.0e-3;
% io rimpicciolirei la figura ma non sono sicuro sarebbe da provare


% io questo caso abbiao dei punti che non seguono una funzione quindi non 
% non penso sia necessario calcolare l'errore

