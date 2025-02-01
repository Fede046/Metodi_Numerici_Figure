

clear all
close all


%grafic setting
open_figure(1);
hold on;
grid("on");




%bez del cuore
bezCuoreG = curv2_bezier_load('c2_bezier_heart.db');
%scaliamo
bezCuore = bezCuoreG;
%modifica in base alla scala
S = get_mat_scale([0.97 0.97]);
bezCuore.cp = point_trans(bezCuore.cp,S);

%trovo il punto massimo e minimo del cuore
a=0;
b=1;
npt=150;
t=linspace(a,b,npt);
Pxy=ppbezier_val(bezCuoreG,t);
Massimay = max(Pxy(:,2));
Minimay = min(Pxy(:,2));

bezSeg = curv2_bezier_interp([0,Minimay;0,Massimay],0,1,0); 
%0.3 rappresenta la distanza tra i due punti di intersezione
%intersezione con un segmento
[IP1P2,t1,t2]=curv2_intersect(bezCuoreG,bezSeg);
[sx21,dx21]=ppbezier_subdiv(bezSeg,t2(1));

[sx22,dx22]=ppbezier_subdiv(dx21,t2(2))
%punto di massimo del segmento trovato
a=0;
b=1;
npt=150;
t=linspace(a,b,npt);
Pxy=ppbezier_val(sx22,t);
Massimay = max(Pxy(:,2))
Minimay = min(Pxy(:,2))



%traslo in base alla scala
%modifica in base alla scala
 f = ((Massimay+Minimay)/2)*3/100;
 T = get_mat_trasl([0 f]);
bezCuore.cp = point_trans(bezCuore.cp,T);
%grafico 

curv2_ppbezier_plot(bezCuoreG,60,'k');
curv2_ppbezier_plot(bezCuore,60,'k');

%trovo il punto massimo e minimo del cuore
a=0;
b=1;
npt=150;
t=linspace(a,b,npt);
Pxy=ppbezier_val(bezCuore,t);
Massimax = max(Pxy(:,1));
Minimax = min(Pxy(:,1));

Massimay = max(Pxy(:,2));
Minimay = min(Pxy(:,2));


%faccio il Segmento verticale

p = linspace(Minimax,Massimax,6);

% for i=1:6
%     point_plot([p(i),-0.5;p(i),0.5],'k');
% end 
lunghezzaY = Massimay+0.5;
%lunghezzaY = 0.5;

bezSegsx = curv2_bezier_interp([p(2),-lunghezzaY;p(2),lunghezzaY],0,1,0);
bezSegdx = curv2_bezier_interp([p(3),-lunghezzaY;p(3),lunghezzaY],0,1,0);

%curv2_ppbezier_plot(bezSegsx,60,'r');
%curv2_ppbezier_plot(bezSegdx,60,'r');
%larghezza fascia
d = p(3)-p(2);
%trovo i segmenti orizzontali

Meta = Massimay/2;
pAl = Meta+d/2;
pBas = Meta-d/2;
pAl = fix(pAl * 100) / 100;
pBas = fix(pBas * 100) / 100;


lunghezzaX= Massimax+0.5;
%lunghezzaX= 0.5;

bezSegal = curv2_bezier_interp([-lunghezzaX,pAl;lunghezzaX,pAl],0,1,0);
bezSegbas = curv2_bezier_interp([-lunghezzaX,pBas;lunghezzaX,pBas],0,1,0);

%curv2_ppbezier_plot(bezSegal,60,'r');
%curv2_ppbezier_plot(bezSegbas,60,'r');

%%%faccio l'intersezione tra i segmenti e il cuore
for i=1:2
    if i==2
        bezSegsx = curv2_ppbezier_reverse(bezSegal);
        bezSegdx = bezSegbas;
       % bezCuore = curv2_ppbezier_reverse(bezCuore);
    end
[IP1P2,t1,t2]=curv2_intersect(bezCuore,bezSegsx);
[sx11,dx11]=ppbezier_subdiv(bezCuore,t1(1));
[sx12,dx12]=ppbezier_subdiv(bezCuore,t1(2));
 %curv2_ppbezier_plot(sx11,60,'g',2);
 %curv2_ppbezier_plot(dx12,60,'m',2);

 %join tra queste porzioni di cuore
ppbezCuore1 = curv2_ppbezier_join(sx11,dx12,1.0e-2);


[sx21,dx21]=ppbezier_subdiv(bezSegsx,t2(1));
[sx22,dx22]=ppbezier_subdiv(sx21,t2(2));
%curv2_ppbezier_plot(dx22,60,'b',2);

%join con parte cuore
dx22 = curv2_ppbezier_de(dx22,ppbezCuore1.deg-dx22.deg);
ppbezCuore2 = curv2_ppbezier_join(ppbezCuore1,dx22,1.0e-2);


%intersezione parte del cuore con segmento con l'altro segmento
%ppbezCuore2
%bezSegdx

%curv2_ppbezier_plot(ppbezCuore2,60,'y',3);
%curv2_ppbezier_plot(bezSegdx,60,'g',3);


[IP1P2,t1,t2]=curv2_intersect(ppbezCuore2,bezSegdx);
[sx11,dx11]=ppbezier_subdiv(ppbezCuore2,t1(1));
[sx12,dx12]=ppbezier_subdiv(ppbezCuore2,t1(2));
%curv2_ppbezier_plot(sx12,60,'g',2); ii

%curv2_ppbezier_plot(dx11,60,'y',2); iii
[sx21,dx21]=ppbezier_subdiv(bezSegdx,t2(1));
[sx22,dx22]=ppbezier_subdiv(sx21,t2(2));
%curv2_ppbezier_plot(sx21,60,'g',2);
%curv2_ppbezier_plot(dx22,60,'c',2);ii

%join
dx22 = curv2_ppbezier_de(dx22,sx12.deg-dx22.deg);
ppbezFascia1 =curv2_ppbezier_join(dx22,sx12,1.0e-2);
%xy = curv2_ppbezier_plot(ppbezFascia1,60,'r',8);

%join
ppbezFascia = curv2_ppbezier_join(ppbezFascia1,dx11,1.0e-2);
xy = curv2_ppbezier_plot(ppbezFascia,-60,'r',8);
point_fill(xy,'r','r');

end

