clear all
close all


%grafics settings
open_figure(1);
grid("on");

%faccio la crf 
p=linspace(0,2*pi,16);
for i=1:16
[A0(i,1), A0(i,2)] = c2_circle(p(1,i),0.5);
end
point_plot(A0,'ro-')
%curva di bez
Cf=curv2_bezier_interp(A0,0,1,1);

%grafico
curv2_ppbezier_plot(Cf,60,'r');

%faccio 1 l'onda 

ik = 1;

for i=-2*pi:pi/4:2*pi
        M(ik,1)=i;
        M(ik,2)=sin(i);
    ik = ik+1;
end

%curva di bez 
%dato che ci sono molti atlti e bassi devo fare una join
Mbez= curv2_bezier_interp(M,0,1,0);

M0=M+[4*pi 0];
M;
M0;
Mbez0= curv2_bezier_interp(M0,0,1,0);

MbezF = curv2_ppbezier_join(Mbez0,Mbez,1.0e-4);
MbezF.cp = (MbezF.cp+[-6 0])*0.05;
%grafico
curv2_ppbezier_plot(MbezF,60,'k');


%traslo la curva e la metto 5 volte in posizioni diferse

%0 la più alta
MbezF0.cp=MbezF.cp+[0 0.3];
MbezF0.ab=MbezF.ab;
MbezF0.deg=MbezF.deg;
curv2_ppbezier_plot(MbezF0,60,'g');

%1 
MbezF1.cp=MbezF.cp+[0 0.1];
MbezF1.ab=MbezF.ab;
MbezF1.deg=MbezF.deg;
curv2_ppbezier_plot(MbezF1,60,'g');

%2
MbezF2.cp=MbezF.cp+[0 -0.1];
MbezF2.ab=MbezF.ab;
MbezF2.deg=MbezF.deg;
curv2_ppbezier_plot(MbezF2,60,'g');

%3
MbezF3.cp=MbezF.cp+[0 -0.3];
MbezF3.ab=MbezF.ab;
MbezF3.deg=MbezF.deg;
curv2_ppbezier_plot(MbezF3,60,'g');





%trovo i punti di intersezione della parte in alto
[ICfF0,t1,t2] = curv2_intersect(Cf,MbezF0);
ICfF0(1,1)
ICfF0(1,2)
ik = 1;

for i=-2*pi:pi/4:2*pi
    if ICfF0(1,1)<(i-6)*0.05
        Mz(ik,1)=(i-6)*0.05;
        Mz(ik,2)=sin(i)*0.05+0.3;
        ik = ik+1;
    end
end

ik = 1;

for i=-2*pi:pi/4:2*pi
    if  ICfF0(1,2)>(i-6)*0.05+(4*pi)*0.05
        Mz0(ik,1)=(i-6)*0.05+(4*pi)*0.05;
        Mz0(ik,2)=sin(i)*0.05+0.3;
        ik = ik+1;
    end
end




%imposto come primo punto il punto di inters con la crf
Mz(1,1)=ICfF0(1,1);
Mz(1,2)=ICfF0(2,1);
%imposto l'ultimo punto
Mz0(ik,1)=ICfF0(1,2);
Mz0(ik,2)=ICfF0(2,2);


%point_plot(Mz,'mo-');

%point_plot(Mz0,'ko-');

bezMz= curv2_bezier_interp(Mz,0,1,0);
bezMz0 = curv2_bezier_interp(Mz0,0,1,0);

%metto pari il grado
 [bezMz01.cp(: ,1) ,bezMz01.cp(: ,2)]=gc_pol_de2d(bezMz0.deg ,bezMz0.cp(: ,1), bezMz0. cp (: ,2) ) ;
 %[bezMz03.cp(: ,1) ,bezMz03.cp(: ,2)]=gc_pol_de2d(bezMz0.deg+1 ,bezMz01.cp(: ,1), bezMz01. cp (: ,2) ) ;
 %[bezMz02.cp(: ,1) ,bezMz02.cp(: ,2)]=gc_pol_de2d(bezMz0.deg+2 ,bezMz03.cp(: ,1), bezMz03. cp (: ,2) ) ;

 bezMz01.deg = bezMz0.deg+1;
 bezMz01.ab = bezMz0.ab;
    bezMz;
    bezMz01;
Mz0Mz0 = curv2_ppbezier_join(bezMz,bezMz01,1.0e-4);

%grafico
curv2_ppbezier_plot(Mz0Mz0,60,'b');
Mz0Mz0;
%parte della crf con quei punti
p = linspace(ICfF0(1,1),ICfF0(1,2),8);

Crf0(1,1)=ICfF0(1,2);
Crf0(1,2)=ICfF0(2,2);
ik = 2;
for i=2:16

    if A0(i,1)<Crf0(1,1) && A0(i,2)>0 && A0(i,1)>ICfF0(1,1)
        Crf0(ik,1)=A0(i,1);  
        Crf0(ik,2)=A0(i,2);
        ik=ik+1;
    end
end
Crf0(ik,1)=ICfF0(1,1);
Crf0(ik,2)=ICfF0(2,1);


%point_plot(Crf0,'mo-')
bezCrf0 = curv2_bezier_interp(Crf0,0,1,1);
bezCrf00 = cambia_grado(bezCrf0,Mz0Mz0.deg);
curv2_ppbezier_plot(bezCrf00,60,'m')

bezCrf00;
Mz0Mz0;

%join
Finale0 = curv2_ppbezier_join(bezCrf00,Mz0Mz0,1.0e-4);

xy =curv2_ppbezier_plot(Finale0,60,'g');
fill(xy(:,1),xy(:,2),'k');

%num = curv2_ppbezier_area(Finale);





%giallo%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%trovo il punto di intersezione tra la crf e l'onda 1



%trovo i punti di intersezione della parte onda 1
[ICfF0,t1,t2] = curv2_intersect(Cf,MbezF1);
ICfF0(1,1)
ICfF0(1,2)
ik = 1;

for i=-2*pi:pi/4:2*pi
    if ICfF0(1,1)<(i-6)*0.05
        MzM(ik,1)=(i-6)*0.05;
        MzM(ik,2)=sin(i)*0.05+0.1;
        ik = ik+1;
    end
end

ik = 1;

for i=-2*pi:pi/4:2*pi
    if  ICfF0(1,2)>(i-6)*0.05+(4*pi)*0.05
        Mz0M(ik,1)=(i-6)*0.05+(4*pi)*0.05;
        Mz0M(ik,2)=sin(i)*0.05+0.1;
        ik = ik+1;
    end
end




%imposto come primo punto il punto di inters con la crf
MzM(1,1)=ICfF0(1,1);
MzM(1,2)=ICfF0(2,1);
%imposto l'ultimo punto
Mz0M(ik,1)=ICfF0(1,2);
Mz0M(ik,2)=ICfF0(2,2);


bezMzM= curv2_bezier_interp(MzM,0,1,0);
bezMz0M = curv2_bezier_interp(Mz0M,0,1,0);

curv2_ppbezier_plot(bezMz0M,60,'r');
bezMzM
bezMz0M
curv2_ppbezier_plot(bezMzM,60,'m');
%metto pari il grado
bezMzM1 = curv2_bezier_de(bezMzM,1);

Mz0Mz1M = curv2_ppbezier_join(bezMzM1,bezMz0M,1.0e-4);

%grafico
curv2_ppbezier_plot(Mz0Mz1M,60,'b');
Mz0Mz1M
%parte della crf con quei punti
p = linspace(ICfF0(1,1),ICfF0(1,2),8);
 

%faccio le due parti di crf
 Crf0M1dx(1,1)=ICfF0(1,2);
 Crf0M1dx(1,2)=ICfF0(2,2);
 Crf0M1sx(1,1)=ICfF0(1,1);
 Crf0M1sx(1,2)=ICfF0(2,1);
  ik = 2;
  ij = 2;
for i=2:16
 
     if A0(i,1)<Crf0M1dx(1,1) && A0(i,2)>0 && A0(i,1)>Crf0(1,1)
         Crf0M1dx(ik,1)=A0(i,1);  
         Crf0M1dx(ik,2)=A0(i,2);
         ik=ik+1;
     end


     if A0(i,1)>Crf0M1sx(1,1) && A0(i,2)>0 && A0(i,1)<Crf0(length(Crf0),1)
         Crf0M1sx(ik,1)=A0(i,1);  
         Crf0M1sx(ik,2)=A0(i,2);
         ij=ij+1;
     end
 
 end
Crf0M1dx(ik,1)=Crf0(1,1);
Crf0M1dx(ik,2)=Crf0(1,2);
Crf0M1sx(ij,1)=Crf0(length(Crf0),1);
Crf0M1sx(ij,2)=Crf0(length(Crf0),2);
%grafico
point_plot(Crf0M1dx,'mo-')
point_plot(Crf0M1sx,'go-')

bezCrf0M1dx = curv2_bezier_interp(Crf0M1dx,0,1,1);
curv2_ppbezier_plot(bezCrf0M1dx,60,'k');

bezCrf0M1sx = curv2_bezier_interp(Crf0M1sx,0,1,1);
curv2_ppbezier_plot(bezCrf0M1sx,60,'k');

%faccio un join tra le due parti di crf e le due curve

%cambio grado
bezCrf00M1dx = cambia_grado(bezCrf0M1dx,Mz0Mz1M.deg);

Finaledx = curv2_ppbezier_join(bezCrf00M1dx,Mz0Mz1M,1.0e-4);

bezCrf00M1sx = cambia_grado(bezCrf0M1sx,Finaledx.deg);

Finalesx= curv2_ppbezier_join(bezCrf00M1sx,Finaledx,1.0e-4);

%curva originale
%curv2_ppbezier_plot(Mz0Mz0,60,'g',10);
 
%idea farlo manualemnte 


Mz0Mz012=curv2_ppbezier_de(Mz0Mz0,2);
%la funzione curv2_ppbezier_de mi fa aumentare il grado una ppbez (caso
%quando faccio il join di due curve di bez)
%point_plot(Mz0Mz012.cp,'ko-',10);
%curv2_bezier_de (aumento di grado di una singola curva di bez) ( non
%funziona con le ppbez)

%bbbbb=Mz0Mz012.ab
%FinaleM1gr = cambia_grado(Mz0Mz0,Finalesx.deg);
%curva aumentata di grado
%curv2_ppbezier_plot(Mz0Mz012,60,'b',10);

%point_plot(FinaleM1.cp,'bo-');
%M0 = FinaleM1gr.deg;
M1 =Finalesx.deg;


%curv2_ppbezier_plot(Mz0Mz0M1,60,'b',10)

FinaleM1 = curv2_ppbezier_join(Mz0Mz012,Finalesx,1.0e-4);

xyM1 = curv2_ppbezier_plot(FinaleM1,60,'k');
fill(xyM1(:,1),xyM1(:,2),'y');


%bezCrf00 = cambia_grado(bezCrf0,Mz0Mz0.deg);
% curv2_ppbezier_plot(bezCrf00,60,'m')
% 
% bezCrf00
% Mz0Mz0
% 
% %join
% Finale = curv2_ppbezier_join(bezCrf00,Mz0Mz0,1.0e-4);
% 
% xy =curv2_ppbezier_plot(Finale,60,'g');
% fill(xy(:,1),xy(:,2),'k');




