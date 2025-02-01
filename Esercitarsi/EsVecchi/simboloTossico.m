clear all
close all

%grafic settings
open_figure(1);
hold on;
grid("on") 
%Ax = gca;
%Ax.Color='c';

%linea
p = linspace(0,1,9);
Lin(:,1) = p;
Lin(:,2) = 0;
%point_plot(Lin,'go-');

%divisione in sedicesimi di una crf
l = linspace(18*pi/16,(32+14)*pi/16,33);


for i=1:33
    [Crf(i,1),Crf(i,2)]=c2_circle(l(i),0.5);
    [Crf1(i,1),Crf1(i,2)]=c2_circle(l(i),Lin(6,1));
    ix=i;
end
Crf = Crf+[0.5 0];
%point_plot(Crf,'r');

Crf1 = Crf1+Lin(6,1:2);
%point_plot(Crf1,'c');


%segmento di unione
SegA(1,1:2) =Crf1(1,1:2); 
SegA(2,1:2) =Crf(1,1:2);
SegB(1,1:2) =Crf1(ix,1:2); 
SegB(2,1:2) =Crf(ix,1:2);

%point_plot(SegA)


%join
bezCrf = curv2_bezier_interp(Crf,0,1,0);
bezCrf1 = curv2_bezier_interp(Crf1,0,1,0);
bezSegA = curv2_bezier_interp(SegA,0,1,0);



bezSegA = curv2_bezier_de(bezSegA,31);

ppCrfSeg = curv2_ppbezier_join(bezSegA,bezCrf,1.0e-4);
ppCrfCrf1 = curv2_ppbezier_join(ppCrfSeg,bezCrf1,1.0e-4);

%xy =curv2_ppbezier_plot(ppCrfCrf1,60,'b');
%fill(xy(:,1),xy(:,2),'r');


%rotazione e traslazione
AngRot = [-11*pi/6,-pi/2,-7*pi/6];
Trasl = [-1.1,-0.5;0,1.342;1.1,-0.5];

%alto 
ppCrfCrf1Alto = ppCrfCrf1;
ppCrfCrf1Alto.cp = ppCrfCrf1.cp*[cos(AngRot(2)),sin(AngRot(2));-sin(AngRot(2)),cos(AngRot(2))];
ppCrfCrf1Alto.cp= ppCrfCrf1Alto.cp+Trasl(2,1:2);
%curv2_ppbezier_plot(ppCrfCrf1Alto,60,'m');

%basso a sx
ppCrfCrf1Sx = ppCrfCrf1;
ppCrfCrf1Sx.cp = ppCrfCrf1.cp*[cos(AngRot(1)),sin(AngRot(1));-sin(AngRot(1)),cos(AngRot(1))];
ppCrfCrf1Sx.cp = ppCrfCrf1Sx.cp+Trasl(1,1:2);
%curv2_ppbezier_plot(ppCrfCrf1Sx,60,'g');


%basso a dx
ppCrfCrf1Dx = ppCrfCrf1;
ppCrfCrf1Dx.cp = ppCrfCrf1.cp*[cos(AngRot(3)),sin(AngRot(3));-sin(AngRot(3)),cos(AngRot(3))];
ppCrfCrf1Dx.cp = ppCrfCrf1Dx.cp+Trasl(3,1:2);
%curv2_ppbezier_plot(ppCrfCrf1Dx,60,'c');



%trovo i punti  di intersezione tra le ppbez
[PInterAltoSx,t1,t2]=curv2_intersect(ppCrfCrf1Alto,ppCrfCrf1Sx);
[PInterAltoDx,t1,t2]=curv2_intersect(ppCrfCrf1Alto,ppCrfCrf1Dx);
[PInterDxSx,t1,t2]=curv2_intersect(ppCrfCrf1Dx,ppCrfCrf1Sx);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%trovati i punti di intersezione ri faccio la crf grande

%basso dx
pEsternoAS(1,1:2) =PInterAltoSx(1:2,1)
pEsternoAD(1,1:2) =PInterAltoDx(1:2,2)
pEsternoDS(1,1:2) =PInterDxSx(1:2,2)


for i=1:33
    [Crfu(i,1),Crfu(i,2)]=c2_circle(l(i),0.5);
    [Crf1u(i,1),Crf1u(i,2)]=c2_circle(l(i),Lin(6,1));
    ix=i;
end
Crfu = Crfu+[0.5 0];
%point_plot(Crfu,'r');

Crf1u = Crf1u+Lin(6,1:2)
%point_plot(Crf1u,'c');



%segmento di unione
SegAu(1,1:2) =Crf1u(1,1:2); 
SegAu(2,1:2) =Crfu(1,1:2);
SegBu(1,1:2) =Crf1u(ix,1:2); 
SegBu(2,1:2) =Crfu(ix,1:2);


%segmento A
%basso a dx 
SegAu1(1,1:2) = (SegAu(1,1:2)*[cos(AngRot(3)),sin(AngRot(3));-sin(AngRot(3)),cos(AngRot(3))])+Trasl(3,1:2);
SegAu1(2,1:2) = (SegAu(2,1:2)*[cos(AngRot(3)),sin(AngRot(3));-sin(AngRot(3)),cos(AngRot(3))])+Trasl(3,1:2);
%basso a sx
SegAu2(1,1:2) = (SegAu(1,1:2)*[cos(AngRot(1)),sin(AngRot(1));-sin(AngRot(1)),cos(AngRot(1))])+Trasl(1,1:2);
SegAu2(2,1:2) = (SegAu(2,1:2)*[cos(AngRot(1)),sin(AngRot(1));-sin(AngRot(1)),cos(AngRot(1))])+Trasl(1,1:2);
%alto
SegAu3(1,1:2) = (SegAu(2,1:2)*[cos(AngRot(2)),sin(AngRot(2));-sin(AngRot(2)),cos(AngRot(2))])+Trasl(2,1:2);
SegAu3(2,1:2) = (SegAu(2,1:2)*[cos(AngRot(2)),sin(AngRot(2));-sin(AngRot(2)),cos(AngRot(2))])+Trasl(2,1:2);

%segmento B
%basso a dx 
SegBu1(1,1:2) = (SegBu(1,1:2)*[cos(AngRot(3)),sin(AngRot(3));-sin(AngRot(3)),cos(AngRot(3))])+Trasl(3,1:2);
SegBu1(2,1:2) = (SegBu(2,1:2)*[cos(AngRot(3)),sin(AngRot(3));-sin(AngRot(3)),cos(AngRot(3))])+Trasl(3,1:2);
%basso a sx
SegBu2(1,1:2) = (SegBu(1,1:2)*[cos(AngRot(1)),sin(AngRot(1));-sin(AngRot(1)),cos(AngRot(1))])+Trasl(1,1:2);
SegBu2(2,1:2) = (SegBu(2,1:2)*[cos(AngRot(1)),sin(AngRot(1));-sin(AngRot(1)),cos(AngRot(1))])+Trasl(1,1:2);
%alto
SegBu3(1,1:2) = (SegBu(2,1:2)*[cos(AngRot(2)),sin(AngRot(2));-sin(AngRot(2)),cos(AngRot(2))])+Trasl(2,1:2);
SegBu3(2,1:2) = (SegBu(2,1:2)*[cos(AngRot(2)),sin(AngRot(2));-sin(AngRot(2)),cos(AngRot(2))])+Trasl(2,1:2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%impostazioni crf in basso a destra

CrfuProva = Crfu*[cos(AngRot(3)),sin(AngRot(3));-sin(AngRot(3)),cos(AngRot(3))];
CrfuProva = CrfuProva +Trasl(3,1:2);
%point_plot(CrfuProva,'y',6);

Crfu1Prova = Crf1u*[cos(AngRot(3)),sin(AngRot(3));-sin(AngRot(3)),cos(AngRot(3))];
Crfu1Prova = Crfu1Prova +Trasl(3,1:2);
%point_plot(Crfu1Prova,'y',6);

ik = 1;
for i=1:33
     if pEsternoAD(1,1)<Crfu1Prova(i,1) || pEsternoDS(1,2)>Crfu1Prova(i,2)
         Crf1Dx(ik,1)=Crfu1Prova(i,1);
         Crf1Dx(ik,2)=Crfu1Prova(i,2);
         ik = ik+1;
     end
 end



temp = false
ij1 = 2;
ij2 = 2;
for i=2:ik-1
    if sqrt((Crf1Dx(i,1)-Crf1Dx(i-1))^2)>0.5
    temp = true;
    end
    
    if temp
       Arco2(ij2,1) = Crf1Dx(i,1);
       Arco2(ij2,2)= Crf1Dx(i,2);
       ij2 = ij2+1;
    else
       Arco1(ij1,1) = Crf1Dx(i,1);
       Arco1(ij1,2)= Crf1Dx(i,2);
        ij1 = ij1 +1;
    end
end

%sistemo gli estremi
Arco1(1,1:2)=SegAu1(1,1:2);
Arco1(ij1,1:2)=pEsternoAD(1,1:2);

Arco2(1,1:2)=pEsternoDS(1,1:2);
Arco2(ij2,1:2)=SegBu1(1,1:2);


% point_plot(Arco1,'g',8);
% point_plot(Arco2,'b',8);

Arco1
Arco2

%faccio le curve di bez
bezArco1 = curv2_bezier_interp(Arco1,0,1,0);
bezArco2 = curv2_bezier_interp(Arco2,0,1,0);
bezCrfPiccola = curv2_bezier_interp(CrfuProva,0,1,1);
bezSegmento = curv2_bezier_interp(SegAu1,0,1,1);
bezSegmento = curv2_ppbezier_de(bezSegmento,31);
bezSegmentoB = curv2_bezier_interp(SegBu1,0,1,1);
bezSegmentoB = curv2_ppbezier_de(bezSegmentoB,31);


bezArco2 = curv2_bezier_de(bezArco2,20);
bezArco1 = curv2_ppbezier_de(bezArco1,22);

bezArco1
bezArco2

bezArcoSeg = curv2_ppbezier_join(bezArco1,bezSegmento,1.0e-4);
bezArcoSegB = curv2_ppbezier_join(bezArco2,bezSegmentoB,1.0e-4);
%curv2_ppbezier_plot(bezArcoSegB,60,'k',9);

bezArco2
bezArcoSeg
bezCrfPiccola
bezArcoSegB
bezArcoCrf1 = curv2_ppbezier_join(bezArcoSeg,bezCrfPiccola,1.0e-4);
bezBassoDx = curv2_ppbezier_join(bezArcoCrf1,bezArcoSegB,1.0e-4);
%curv2_ppbezier_plot(bezBassoDx,60,'g',9);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%impostazioni crf in basso a sinistra

CrfuProva = Crfu*[cos(AngRot(1)),sin(AngRot(1));-sin(AngRot(1)),cos(AngRot(1))];
CrfuProva = CrfuProva +Trasl(1,1:2);
%point_plot(CrfuProva,'c',6);

Crfu1Prova = Crf1u*[cos(AngRot(1)),sin(AngRot(1));-sin(AngRot(1)),cos(AngRot(1))];
Crfu1Prova = Crfu1Prova +Trasl(1,1:2);
%point_plot(Crfu1Prova,'y',6);

ik = 1;
for i=1:33
     if pEsternoAS(1,1)>Crfu1Prova(i,1) || pEsternoDS(1,2)>Crfu1Prova(i,2)
         Crf1Dx(ik,1)=Crfu1Prova(i,1);
         Crf1Dx(ik,2)=Crfu1Prova(i,2);
         ik = ik+1;
     end
 end

 %point_plot(Crf1Dx,'k',8)


temp = false
ij1 = 2;
ij2 = 2;
Arco1=[];
Arco2=[];
for i=2:ik-1
    if sqrt((Crf1Dx(i,1)-Crf1Dx(i-1))^2)>0.5
    temp = true;
    end
    
    if temp
       Arco2(ij2,1) = Crf1Dx(i,1);
       Arco2(ij2,2)= Crf1Dx(i,2);
       ij2 = ij2+1;
    else
       Arco1(ij1,1) = Crf1Dx(i,1);
       Arco1(ij1,2)= Crf1Dx(i,2);
        ij1 = ij1 +1;
    end
end

%point_plot(Arco1,'r',8);
%point_plot(Arco2,'g',8);


%sistemo gli estremi
Arco2(1,1:2)=pEsternoAS(1,1:2);
Arco2(ij2,1:2)=SegBu2(1,1:2);

Arco1(1,1:2)=SegAu2(1,1:2);

Arco1(ij1,1:2)=pEsternoDS(1,1:2);


 %point_plot(Arco1,'g',8);
 %point_plot(Arco2,'b',8);

Arco1
Arco2

%faccio le curve di bez
bezArco1 = curv2_bezier_interp(Arco1,0,1,0);
bezArco2 = curv2_bezier_interp(Arco2,0,1,0);
bezCrfPiccola = curv2_bezier_interp(CrfuProva,0,1,1);
bezSegmento = curv2_bezier_interp(SegAu2,0,1,1);
bezSegmento = curv2_ppbezier_de(bezSegmento,31);

bezSegmentoB = curv2_bezier_interp(SegBu2,0,1,1);
bezSegmentoB = curv2_ppbezier_de(bezSegmentoB,31);

bezArco2 = curv2_ppbezier_de(bezArco2,21);
bezArco1 = curv2_ppbezier_de(bezArco1,21);

bezSegmentoB
bezArco1
bezArco2

bezArcoSeg = curv2_ppbezier_join(bezArco1,bezSegmento,1.0e-4);
bezArcoSegB = curv2_ppbezier_join(bezArco2,bezSegmentoB,1.0e-4);

bezArco1;
bezArco2;
bezArcoSeg;
bezArcoSegB;
bezCrfPiccola;
bezArcoCrf1 = curv2_ppbezier_join(bezArcoSeg,bezCrfPiccola,1.0e-4);
bezBassoSx = curv2_ppbezier_join(bezArcoCrf1,bezArcoSegB,1.0e-4);

%curv2_ppbezier_plot(bezBassoSx,60,'r',3);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%circonferenza alta

CrfuProva = Crfu*[cos(AngRot(2)),sin(AngRot(2));-sin(AngRot(2)),cos(AngRot(2))];
CrfuProva = CrfuProva +Trasl(2,1:2);
%point_plot(CrfuProva,'m',6);

Crfu1Prova = Crf1u*[cos(AngRot(2)),sin(AngRot(2));-sin(AngRot(2)),cos(AngRot(2))];
Crfu1Prova = Crfu1Prova +Trasl(2,1:2);
%point_plot(Crfu1Prova,'y',6);

ik = 1;
for i=1:33
     if pEsternoAS(1,2)<Crfu1Prova(i,2)% || pEsternoDS(1,2)>Crfu1Prova(i,2)
         Crf1Dx(ik,1)=Crfu1Prova(i,1);
         Crf1Dx(ik,2)=Crfu1Prova(i,2);
         ik = ik+1;
     end
 end

 %point_plot(Crf1Dx,'k',10)


temp = false
ij1 = 2;
ij2 = 2;
Arco1=[];
Arco2=[];
for i=2:ik-1
    if sqrt((Crf1Dx(i,1)-Crf1Dx(i-1))^2)>0.5
    temp = true;
    end
    
    if temp
       Arco2(ij2,1) = Crf1Dx(i,1);
       Arco2(ij2,2)= Crf1Dx(i,2);
       ij2 = ij2+1;
    else
       Arco1(ij1,1) = Crf1Dx(i,1);
       Arco1(ij1,2)= Crf1Dx(i,2);
        ij1 = ij1 +1;
    end
end

%point_plot(Arco1,'r',8);
%point_plot(Arco2,'g',8);


%sistemo gli estremi
Arco2(1,1:2)=pEsternoAD(1,1:2);
Arco2(ij2,1:2)=SegBu3(2,1:2);

Arco1(1,1:2)=SegAu3(2,1:2);

Arco1(ij1,1:2)=pEsternoAS(1,1:2);


%point_plot(Arco1,'g',8);
 %point_plot(Arco2,'b',8);

Arco1
Arco2

%faccio le curve di bez
bezArco1 = curv2_bezier_interp(Arco1,0,1,0);
bezArco2 = curv2_bezier_interp(Arco2,0,1,0);
bezCrfPiccola = curv2_bezier_interp(CrfuProva,0,1,0);
bezSegmento = curv2_bezier_interp(SegAu3,0,1,0);
bezSegmento = curv2_ppbezier_de(bezSegmento,31);

bezSegmentoB = curv2_bezier_interp(SegBu3,0,1,0);
bezSegmentoB = curv2_ppbezier_de(bezSegmentoB,31);

bezArco2 = curv2_ppbezier_de(bezArco2,21);
bezArco1 = curv2_ppbezier_de(bezArco1,22);

bezSegmentoB
bezArco1
bezArco2

bezArcoSeg = curv2_ppbezier_join(bezArco1,bezSegmento,1.0e-4);
bezArcoSegB = curv2_ppbezier_join(bezArco2,bezSegmentoB,1.0e-4);

% curv2_ppbezier_plot(bezArcoSeg,60,'r',8);
% curv2_ppbezier_plot(bezCrfPiccola,60,'m',8);

bezArco1;
bezArco2;
bezArcoSeg;
bezArcoSegB;
bezCrfPiccola;
bezArcoCrf1 = curv2_ppbezier_join(bezArcoSeg,bezCrfPiccola,1.0e-4);
bezAlto = curv2_ppbezier_join(bezArcoCrf1,bezArcoSegB,1.0e-4);

%curv2_ppbezier_plot(bezAlto,60,'k',3);


%-------------------------------------------%%%%%%%%%%%%%%%%%%%%%%%%%%%
%join a tutte le ppbez

ppbezBasse = curv2_ppbezier_join(bezBassoSx,bezBassoDx,1.0e-4);
ppbezTot = curv2_ppbezier_join(ppbezBasse,bezAlto,1.0e-4);

xy =curv2_ppbezier_plot(ppbezTot,60,'k');

fill(xy(:,1),xy(:,2),'r');



%circonferenza blu centrale
r = linspace(0,2*pi,16);
for i=1:16 
    [M(i,1),M(i,2)]=c2_circle(r(i),0.2);
end
M = M+[0 0.1];

bezM = curv2_bezier_interp(M,0,1,0);
xy = curv2_ppbezier_plot(bezM,60,'k');
fill(xy(:,1),xy(:,2),'b');







