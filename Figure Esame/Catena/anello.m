clear all
close all

%grafic settings
open_figure(1);
hold on
grid("on");

%anello formato da due circonferenze


%prima semi crf alta

p = linspace(-pi/4,(3*pi)/4,8);

for i=1:8
[A0(i,1), A0(i,2)] = c2_circle(p(i),1);
[A1(i,1),A1(i,2)]= c2_circle(p(i),0.7);
end



%faccio le curve di bez dei punti
Cf0 = curv2_bezier_interp(A0,0,1,1); 
Cf1 = curv2_bezier_interp(A1,0,1,1); 

%stampo
curv2_ppbezier_plot(Cf0,60,'g');
curv2_ppbezier_plot(Cf1,60,'b');


%seg
s = linspace(0.7,1,8);
for i=1:8
    Aseg(i,1)=s(i);
    Aseg(i,2)=0;
end

%traslo i segmenti
q=-pi/4;
AsegB = Aseg*[cos(q),sin(q);-sin(q),cos(q)];
q=(3*pi)/4
AsegA = Aseg*[cos(q),sin(q);-sin(q),cos(q)];

%creo la curva di bez
Sg0 = curv2_bezier_interp(AsegB,0,1,1);

%stampo
curv2_ppbezier_plot(Sg0,60,'k');

%faccio la join tra cf sg cf
C0S = curv2_ppbezier_join(Sg0,Cf0,1.0e-4);
C0SC1 = curv2_ppbezier_join(C0S,Cf1,1.0e-4);
xy =curv2_ppbezier_plot(C0SC1,60,'r');
fill(xy(:,1),xy(:,2),'g');
point_plot(AsegA,'g');


%altra semi crf

C0SC1B.cp = -C0SC1.cp;
C0SC1B.ab = C0SC1.ab;
C0SC1B.deg = C0SC1.deg;

xy =curv2_ppbezier_plot(C0SC1B,60,'r');
fill(xy(:,1),xy(:,2),'g');
point_plot(AsegA,'g');

%prima in alto a dx

C0SC1B.cp = -C0SC1.cp;
C0SC1B.ab = C0SC1.ab;
C0SC1B.deg = C0SC1.deg;

xy =curv2_ppbezier_plot(C0SC1B,60,'r');
fill(xy(:,1),xy(:,2),'r');
point_plot(AsegA,'r');

%seconda

C0SC1B.cp = -C0SC1.cp+[0.8,-0.8];
C0SC1B.ab = C0SC1.ab;
C0SC1B.deg = C0SC1.deg;

xy =curv2_ppbezier_plot(C0SC1B,60,'g');
fill(xy(:,1),xy(:,2),'g');
point_plot(AsegA+[0.8,-0.8],'g');

%terza


C0SC1B.cp = -C0SC1.cp+[1.6,-1.6];
C0SC1B.ab = C0SC1.ab;
C0SC1B.deg = C0SC1.deg;

xy =curv2_ppbezier_plot(C0SC1B,60,'b');
fill(xy(:,1),xy(:,2),'b');
point_plot(AsegA+[1.6,-1.6],'b');
%Quarta

C0SC1B.cp = C0SC1.cp+[1.6,-1.6];
C0SC1B.ab = C0SC1.ab;
C0SC1B.deg = C0SC1.deg;

xy =curv2_ppbezier_plot(C0SC1B,60,'b');
fill(xy(:,1),xy(:,2),'b');
point_plot(AsegA+[1.6,-1.6],'b');



%quinta

C0SC1B.cp = C0SC1.cp+[0.8,-0.8];
C0SC1B.ab = C0SC1.ab;
C0SC1B.deg = C0SC1.deg;

xy =curv2_ppbezier_plot(C0SC1B,60,'g');
fill(xy(:,1),xy(:,2),'g');
point_plot(AsegA+[0.8,-0.8],'g');

%sesta


C0SC1B.cp = C0SC1.cp;
C0SC1B.ab = C0SC1.ab;
C0SC1B.deg = C0SC1.deg;

xy =curv2_ppbezier_plot(C0SC1B,60,'r');
fill(xy(:,1),xy(:,2),'r');
point_plot(AsegA,'r');

%sistemo AsegB
point_plot(AsegB,'r');
point_plot(AsegB+[0.8,-0.8],'g')
point_plot(AsegB+[1.6,-1.6],'b')




%conclusioni: Per colorare creo un segmento che collega, che collega il
%primo punto della crf con il primo punto del segmento, successivamente quel segmento viene oscurato, 
% esmpio: se la fugura ha come primo punto (2.40,3.31) il segmento di collegamento dovrà iniziare da 
% qel punto altrimenti quando si fa la join verrà considerato discontinuo,
% anche se il linspace è molto fitto. Il segmento può essere anche non un
% segmento per esempio un arco però la cosa importantissima è che gli
% estremi del segmento devono essere punti della curva di bez joinata