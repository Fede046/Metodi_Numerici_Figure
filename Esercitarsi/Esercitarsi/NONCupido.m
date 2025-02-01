clear all
close all


%grafic setting
open_figure(1);
hold on;
grid("on");


%prima parte
bezC1.cp = [0.0,0.0;0.15,0.2;0.4,0.2;0.3,0.6;0.0,0.6;-0.5,0.0;0.5,0.0;0.0,0.6;-0.3,0.6;-0.4,0.2;-0.15,0.2;0.0,0.0];
%bezC1.cp= bezC1S(1:6,:); 
bezC1.ab = [0 1];
bezC1.deg = 11;

% point_plot(bezC1.cp,'bo-')
% curv2_ppbezier_plot(bezC1,60,'r');

%%%%
npt=13;
t=linspace(0,1,npt);

Pxy=ppbezier_val(bezC1,t);

%point_plot(Pxy,'g',3);

%trovato i punti da interpolare
%bezXmezzo = 
bezCsx =curv2_bezier_interp(Pxy(1:7,:),0,1,1);

xy = curv2_ppbezier_plot(bezCsx,-60,'m',3);
%point_fill(xy,'r','r');
bezCdx =curv2_bezier_interp(Pxy(7:13,:),0,1,1);


curv2_ppbezier_plot(bezCdx,60,'c',3);
curv2_ppbezier_plot(bezCsx,60,'b',3);


%join
bezCuore =curv2_ppbezier_join(bezCdx,bezCsx,1.0e-2);


%calcolo errore
%valutazione in punti equispaziati per test sull'errore
npt=150;
t=linspace(0,1,npt);
Pxy1=ppbezier_val(bezCuore,t);
%si fa solo per crf, per casi normali utilizzare quella non der
Qxy1 = curv2_ppbezier_plot(bezCuore,-npt,'g');
% [x,y]=cp2_circle(t);
% Qxy1=[x',y'];
%calcola la distanza euclidea fra i punti della curva test
%e della curva di Bézier a tratti interpolante e considera
%la distanza massima
% MaxErr1=max(vecnorm(Qxy1-Pxy1)');
% fprintf('MaxErr1: %e\n',MaxErr1);

t = linspace(0, 1, 100);
Qxyh = decast_val(bezC1, t);
Pxyh = decast_val(bezCuore, t);

MaxErr=max(vecnorm((Qxyh-Pxyh)'));
fprintf('MaxErr: %e\n',MaxErr);

%curv2_ppbezier_plot(bezCuore,60,'k',2);

%%%freccia
%divido il cuore in 6 

%da chiedere
% a=0;
% b=1;
% npt=150;
% t=linspace(a,b,13);
%Pxy=ppbezier_val(bezCuore,t);
%point_plot(Pxy,'m',9);
Massimax = max(Pxy(:,1));
Minimax = min(Pxy(:,1));

Massimay = max(Pxy(:,2));
Minimay = min(Pxy(:,2));


%metà del cuore
pp = (Massimay+Minimay)/2;

%divido in 5 fasce
p = linspace(Minimax,Massimax,6);

% for i =1 :6
%     point_plot([p(i),-pp-1.5;p(i),pp],'r');
% end

% 3 4
%traslazione -pp-1.5
   % point_plot([p(3),-pp-1.5;p(3),pp],'r');
   % point_plot([p(4),-pp-1.5;p(4),pp],'r');

%curva di bez sei segmenti
bezSegsx=curv2_bezier_interp([p(3),-pp-1.5;p(3),pp],0,1,0);
bezSegdx=curv2_bezier_interp([p(4),-pp-1.5;p(4),pp],0,1,0);

%traslo il cuore
bezCuoreSo = bezCuore;
S = get_mat_trasl([0 -pp-1.5]);
bezCuoreSo.cp = point_trans(bezCuoreSo.cp,S);

%curv2_ppbezier_plot(bezCuoreSo,60,'g',2);

%%faccio le intersezioni tra il segmento alto e i segmenti

[IP1P2,t1,t2]=curv2_intersect(bezCuore,bezSegdx);
[sx11,dx11]=ppbezier_subdiv(bezCuore,t1(1));
 %curv2_ppbezier_plot(dx11,60,'b',2); iiii
[sx21,dx21]=ppbezier_subdiv(bezSegdx,t2(1));
%curv2_ppbezier_plot(sx21,60,'g',2); iiiii

[IP1P2,t1,t2]=curv2_intersect(bezCuore,bezSegsx);
[sx110,dx110]=ppbezier_subdiv(bezCuore,t1(1));
 %curv2_ppbezier_plot(sx11,60,'b',2); iii


 %join tra parti di cuore
 ppbezCuTop = curv2_ppbezier_join(sx110,dx11,1.0e-2);
% curv2_ppbezier_plot(ppbezCuTop,60,'b',6);

%join conil segmento
sx21 = curv2_ppbezier_de(sx21,ppbezCuTop.deg-sx21.deg);
 ppbezCuTop = curv2_ppbezier_join(ppbezCuTop,sx21,1.0e-2);
 %curv2_ppbezier_plot(ppbezCuTop,60,'b',6);


[bezSegsx,dx21]=ppbezier_subdiv(bezSegsx,t2(1));
%curv2_ppbezier_plot(sx21,60,'g',2); iii 


%join
bezSegsx = curv2_ppbezier_de(bezSegsx,ppbezCuTop.deg-bezSegsx.deg);
 ppbezCuTop = curv2_ppbezier_join(ppbezCuTop,bezSegsx,1.0e-2);
 %curv2_ppbezier_plot(ppbezCuTop,60,'m',6);


%%%join col cuore sotto



[IP1P2,t1,t2]=curv2_intersect(ppbezCuTop,bezCuoreSo);
[sx11,dx11]=ppbezier_subdiv(ppbezCuTop,t1(1));
[sx12,dx12]=ppbezier_subdiv(sx11,t1(3));
 %curv2_ppbezier_plot(dx12,60,'y',6);
[sx21,dx21]=ppbezier_subdiv(bezCuoreSo,t2(1));
[sx22,dx22]=ppbezier_subdiv(dx21,t2(3));
%curv2_ppbezier_plot(sx22,60,'g',2); 

%faccio il hjoin totale


 bezFreccia = curv2_ppbezier_join(sx22,dx12,1.0e-2);
% curv2_ppbezier_plot(bezFreccia,60,'k',6);

%%%%%%rimpicciolisco la freccia e la ruoto

R = get_mat2_rot(4*pi/6);
S = get_mat_scale([0.4 0.4]);

M= R*S;
bezFreccia.cp = point_trans(bezFreccia.cp,M);
bezFreccia.cp = bezFreccia.cp + [-0.15 pp-0.1];

xy = curv2_ppbezier_plot(bezCdx,-60,'m',3);
point_fill(xy,'r','r');

xy = curv2_ppbezier_plot(bezFreccia,60,'r')
point_fill(xy,'b','r');


xy = curv2_ppbezier_plot(bezCsx,60,'b',3);
point_fill(xy,'r','r');


