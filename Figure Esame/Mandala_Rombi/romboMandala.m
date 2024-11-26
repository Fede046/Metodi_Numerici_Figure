clear all
close all


%grafic
open_figure(1);
grid("on");

%ounti quarto di crf per rombo
ik = 1;
for i=0:pi/8:pi/2
    Q(ik,1)=-sin(i);
    Q(ik,2)=-cos(i)+1;
    ik=ik+1;
end
%point_plot(Q,'ro-');

%interp 
bezQ = curv2_bezier_interp(Q,0,1,1);
curv2_ppbezier_plot(bezQ,60,'r');

%altro quarto
Q1 = Q.*[-1 1]+[-2 0];

%point_plot(Q1)
bezQ1 = curv2_bezier_interp(Q1,0,1,1);
curv2_ppbezier_plot(bezQ1,60,'r');

%join
bezNord = curv2_ppbezier_join(bezQ,bezQ1,1.0e-4);
curv2_ppbezier_plot(bezNord,60,'r');


%point_plot(bezNord.cp,'k');
bezSud.cp = -1*bezNord.cp+[-2 0]
bezSud.deg = bezNord.deg;
bezSud.ab = bezNord.ab;


%point_plot(bezSud.cp,'g');


curv2_ppbezier_plot(bezSud,60,'m')

%join
bezRombo =curv2_ppbezier_join(bezSud,bezNord,1.0e-4);

xy = curv2_ppbezier_plot(bezRombo,60,'k');
fill(xy(:,1),xy(:,2),'g');

% rombo dx
bezRomboD.cp = bezRombo.cp +[2,0];
bezRomboD.deg = bezRombo.deg;
bezRomboD.ab = bezRombo.ab;

xy = curv2_ppbezier_plot(bezRomboD,60,'k');
fill(xy(:,1),xy(:,2),'b');

%rombo nord
bezRomboDn.cp = bezRombo.cp +[1,1];
bezRomboDn.deg = bezRombo.deg;
bezRomboDn.ab = bezRombo.ab;

xy = curv2_ppbezier_plot(bezRomboDn,60,'k');
fill(xy(:,1),xy(:,2),'b');

%rombo sud
bezRomboDs.cp = bezRombo.cp +[1,-1];
bezRomboDs.deg = bezRombo.deg;
bezRomboDs.ab = bezRombo.ab;


xy = curv2_ppbezier_plot(bezRomboDs,60,'k');
fill(xy(:,1),xy(:,2),'y');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%rombi al centro
%circonferenza del pentagono
p=linspace(pi/2,2*pi+pi/2,6);
for i=1:6
    [Cf5(i,1),Cf5(i,2)]=c2_circle(p(i),3.5);
end

%point_plot(Cf5);


%curva ppbez rombo top verde
bezRomboDgn.cp = bezRomboDs.cp*1.5+[Cf5(1,1),Cf5(1,2)];
bezRomboDgn.deg = bezRomboDs.deg; 
bezRomboDgn.ab = bezRomboDs.ab;
xy = curv2_ppbezier_plot(bezRomboDgn,60,'k');
fill(xy(:,1),xy(:,2),'r');
%applico una rotazione attorno a un punto di controllo tipo antenne della
%farfalla
bezRomboDgsx.cp = bezRomboD.cp*1.5+[Cf5(2,1),Cf5(2,2)];
bezRomboDgsx.deg = bezRomboD.deg; 
bezRomboDgsx.ab = bezRomboD.ab;
%xy = curv2_ppbezier_plot(bezRomboDgdx,60,'k');
%fill(xy(:,1),xy(:,2),'r');



 C=[Cf5(2,1),Cf5(2,2)];

 %crea una matrice di traslazione 
 T=get_mat_trasl(-C);
 %radianti 
 alfa=-0.33;
 R=get_mat2_rot(alfa);
 Tinv=get_mat_trasl(C);
 M=Tinv*R*T;
 bpT=bezRomboDgsx;
 bpT.cp=point_trans(bezRomboDgsx.cp ,M) ;
 xy=curv2_ppbezier_plot(bpT,60 ,'k-') ;
%point_plot(ppbT.cp(1 ,:) ,'bo-');
 fill(xy(: ,1) ,xy(: ,2) ,'y') ;
% curv2_ppbezier_plot(bpT,3,'k-',2);


%rombo dx simmetrico del rombo sx

bezRomboDgdx = bpT;
bezRomboDgdx.cp = bpT.cp.*[-1 1];

xy =curv2_ppbezier_plot(bezRomboDgdx,60,'k');
 fill(xy(: ,1) ,xy(: ,2) ,'y') ;


%rombi in basso
bezRomboDgSx.cp = bezRomboD.cp*1.5+[Cf5(3,1),Cf5(3,2)];
bezRomboDgSx.deg = bezRomboD.deg; 
bezRomboDgSx.ab = bezRomboD.ab;
%xy = curv2_ppbezier_plot(bezRomboDgSx,60,'k');
%fill(xy(:,1),xy(:,2),'r');

%crea una matrice di traslazione 
 C=[Cf5(3,1),Cf5(3,2)];

T=get_mat_trasl(-C);
 %radianti 
 alfa=1;
 R=get_mat2_rot(alfa);
 Tinv=get_mat_trasl(C);
 M=Tinv*R*T;
 bpTB=bezRomboDgSx;
 bpTB.cp=point_trans(bezRomboDgSx.cp ,M) ;
  xy=curv2_ppbezier_plot(bpTB,60 ,'k-') ;
%point_plot(ppbT.cp(1 ,:) ,'bo-');
  fill(xy(: ,1) ,xy(: ,2) ,'y') ;
% % curv2_ppbezier_plot(bpT,3,'k-',2);

%rombo simmetrico basso
bezRomboDgDx = bpTB;
bezRomboDgDx.cp = bpTB.cp.*[-1 1];
%xy=curv2_ppbezier_plot(bezRomboDgDx,60 ,'k-') ;
%fill(xy(: ,1) ,xy(: ,2) ,'y') ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%rombi rossi
%creo un dodecagono regolare

p=linspace(0,2*pi,13);
for i=1:13
    [Cf12(i,1),Cf12(i,2)]=c2_circle(p(i),4);
end
Cf12
%point_plot(Cf12);

%primo rombo esterno sx
for i=1:13 

    if Cf12(i,1)<-0.1
bezEsternosx=bezRomboD;
bezEsternosx.cp =bezRomboD.cp*0.9+[Cf12(i,1) Cf12(i,2)];
%xy=curv2_ppbezier_plot(bezEsternosx,60 ,'k-') ;
%fill(xy(: ,1) ,xy(: ,2) ,'y') ;


C=[Cf12(i,1),Cf12(i,2)];

T=get_mat_trasl(-C);
alfa =0;
 %radianti 
 if i==5
  alfa=-2*pi/6;
 end
 if i==6
 alfa=-pi/6;
 end
if i==9
   alfa=2*pi/6;  
end
if i==8
   alfa=pi/6;  
end

 R=get_mat2_rot(alfa);
 Tinv=get_mat_trasl(C);
 M=Tinv*R*T;
 bpTBx=bezEsternosx;
 bpTBx.cp=point_trans(bezEsternosx.cp ,M) ;
 xy=curv2_ppbezier_plot(bpTBx,60 ,'k-') ;
%point_plot(ppbT.cp(1 ,:) ,'bo-');
 fill(xy(: ,1) ,xy(: ,2) ,'r') ;
%


    elseif i==10 ||i==4
bezEsternosx=bezRombo;
bezEsternosx.cp =bezRombo.cp*0.9+[Cf12(i,1) Cf12(i,2)];

%xy=curv2_ppbezier_plot(bezEsternosx,60 ,'k-') ;
%fill(xy(: ,1) ,xy(: ,2) ,'y') ;

%ruoto di 90 gradi
C=[Cf12(i,1),Cf12(i,2)];

T=get_mat_trasl(-C);
 %radianti 
  alfa=pi/2;
 if i==10
 alfa=-pi/2;
 end
 R=get_mat2_rot(alfa);
 Tinv=get_mat_trasl(C);
 M=Tinv*R*T;
 bpTBx=bezEsternosx;
 bpTBx.cp=point_trans(bezEsternosx.cp ,M) ;
 xy=curv2_ppbezier_plot(bpTBx,60 ,'k-') ;
%point_plot(ppbT.cp(1 ,:) ,'bo-');
 fill(xy(: ,1) ,xy(: ,2) ,'r') ;
%




    else
        bezEsternosx=bezRombo;
bezEsternosx.cp =bezRombo.cp*0.9+[Cf12(i,1) Cf12(i,2)];

%xy=curv2_ppbezier_plot(bezEsternosx,60 ,'k-') ;
%fill(xy(: ,1) ,xy(: ,2) ,'g') ;



C=[Cf12(i,1),Cf12(i,2)];

T=get_mat_trasl(-C);
alfa =0;
 %radianti 
 if i==2
  alfa=pi/6;
 end
 if i==3
 alfa=2*pi/6;
 end
if i==12
   alfa=-pi/6;  
end
if i==11
   alfa=-2*pi/6;  
end

 R=get_mat2_rot(alfa);
 Tinv=get_mat_trasl(C);
 M=Tinv*R*T;
 bpTBx=bezEsternosx;
 bpTBx.cp=point_trans(bezEsternosx.cp ,M) ;
 xy=curv2_ppbezier_plot(bpTBx,60 ,'k-') ;
%point_plot(ppbT.cp(1 ,:) ,'bo-');
 fill(xy(: ,1) ,xy(: ,2) ,'r') ;
%



    end
end




%grafico i verdi grandi
%grande basso dx
xy=curv2_ppbezier_plot(bezRomboDgDx,60 ,'k-') ;
fill(xy(: ,1) ,xy(: ,2) ,'g') ;

%grande basso sx
  xy=curv2_ppbezier_plot(bpTB,60 ,'k-') ;
  fill(xy(: ,1) ,xy(: ,2) ,'g') ;

%rombo medio sx
 xy=curv2_ppbezier_plot(bpT,60 ,'k-') ;
 fill(xy(: ,1) ,xy(: ,2) ,'g') ;

%rombo medio dx

xy =curv2_ppbezier_plot(bezRomboDgdx,60,'k');
 fill(xy(: ,1) ,xy(: ,2) ,'g') ;


%rombo grande in alto
xy = curv2_ppbezier_plot(bezRomboDgn,60,'k');
fill(xy(:,1),xy(:,2),'g');


%grafico rombi medi blu centrali

%rombo sx
xy = curv2_ppbezier_plot(bezRombo,60,'k');
fill(xy(:,1),xy(:,2),'b');

% rombo dx

xy = curv2_ppbezier_plot(bezRomboD,60,'k');
fill(xy(:,1),xy(:,2),'b');

%rombo nord

xy = curv2_ppbezier_plot(bezRomboDn,60,'k');
fill(xy(:,1),xy(:,2),'b');

%rombo sud

xy = curv2_ppbezier_plot(bezRomboDs,60,'k');
fill(xy(:,1),xy(:,2),'b');


