clear all
close all


%grafic setting
open_figure(1);
hold on;
grid("on");




%%faccio le crf con le cp2_circle
%interpolazione con derivate

l = linspace(0,2*pi,8);
[Crf(:,1),Crf(:,2),CrfP(:,1),CrfP(:,2)]= cp2_circle(l);

ppbezCrfG = curv2_ppbezierCC1_interp_der(Crf,CrfP,l);
ppbezCrf = ppbezCrfG;
S = get_mat_scale([0.75,0.75]);
ppbezCrf.cp = point_trans(ppbezCrf.cp,S);

curv2_ppbezier_plot(ppbezCrf,60,'k');
curv2_ppbezier_plot(ppbezCrfG,60,'r');

%%calcolo l'errore di interpolazione della crf
l = linspace(0,2*pi,150);
[Pxy(:,1),Pxy(:,2)] = cp2_circle(l);
Qxy = ppbezier_val(ppbezCrfG,l);
MaxErr=max(vecnorm((Pxy-Qxy)'));
fprintf('MaxErr3: %e\n',MaxErr);


%%%traslo la crf sotto
ppbezCrfGM = ppbezCrfG;
ppbezCrfM = ppbezCrf;
C= [0.75 -0.75];
T = get_mat_trasl(C);
ppbezCrfGM.cp = point_trans(ppbezCrfGM.cp,T);
ppbezCrfM.cp = point_trans(ppbezCrf.cp,T);

curv2_ppbezier_plot(ppbezCrfM,60,'g');
curv2_ppbezier_plot(ppbezCrfGM,60,'b');





%%%spacatura in alto crf in mezzo

%%circonferenza grande escludo la parte sotto
ppbezCrfGM00 = ppbezCrfGM;

for i=1:2
    if i==2
       ppbezCrfGM00 = ppbezCrfM; 
    end


[IP1P2,t1,t2]=curv2_intersect(ppbezCrfGM00,ppbezCrf);
[IP1P2,t1b,t2b]=curv2_intersect(ppbezCrfGM00,ppbezCrfG);

[sx11,dx11]=ppbezier_subdiv(ppbezCrfGM00,t1(2));
[sx11b,dx11b]=ppbezier_subdiv(ppbezCrfGM00,t1b(2));
 curv2_ppbezier_plot(dx11,60,'g',2);
 curv2_ppbezier_plot(sx11b,60,'b',2);
 
 %%%join

if i==1
    ppbezTopGM = curv2_ppbezier_join(dx11,sx11b,1.0e-2);
else
    ppbezTopM = curv2_ppbezier_join(dx11,sx11b,1.0e-2);
end

end

%%%colleco le due crf spezzate con parti della circonferenza media


[IP1P2,t1,t2]=curv2_intersect(ppbezCrf,ppbezCrfM);
[IP1P2,t1b,t2b]=curv2_intersect(ppbezCrf,ppbezTopGM);

[sx11,dx11]=ppbezier_subdiv(ppbezCrf,t1(1));
[sx11b,dx11b]=ppbezier_subdiv(sx11,t1b(2));
curv2_ppbezier_plot(sx11b,60,'r',2);

%%join
ppbezTop1M = curv2_ppbezier_join(sx11b,ppbezTopM,1.0e-2);
ppbezTopG1M = curv2_ppbezier_join(ppbezTop1M,ppbezTopGM,1.0e-2);



%%%%%altra perte di crf G del medio M


[IP1P2,t1,t2]=curv2_intersect(ppbezCrfG,ppbezCrfM);
[IP1P2,t1b,t2b]=curv2_intersect(ppbezCrfG,ppbezCrfGM);

[sx11,dx11]=ppbezier_subdiv(ppbezCrfG,t1(2));
[sx11b,dx11b]=ppbezier_subdiv(sx11,t1b(2));
curv2_ppbezier_plot(dx11,60,'k',2);
curv2_ppbezier_plot(sx11b,60,'y',2);

%caso di merda perchè sono vicino all'origine sono obbligato a fare un join
ppbezSeg  = curv2_ppbezier_join(dx11,sx11b,1.0e-2);



%%%%%join
ppbezMedioF = curv2_ppbezier_join(ppbezTopG1M,ppbezSeg,1.0e-2);

curv2_ppbezier_plot(ppbezMedioF,60,'c',2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for kk= 1
%%%faccio le intersezioni della crf alta spaccatura in basso


%%circonferenza grande escludo la parte sotto
ppbezCrfG00 = ppbezCrfG;

for i=1:2
    if i==2
       ppbezCrfG00 = ppbezCrf; 
    end


[IP1P2,t1,t2]=curv2_intersect(ppbezCrfG00,ppbezCrfM);
[IP1P2,t1b,t2b]=curv2_intersect(ppbezCrfG00,ppbezCrfGM);

[sx11,dx11]=ppbezier_subdiv(ppbezCrfG00,t1(1));
[sx11b,dx11b]=ppbezier_subdiv(ppbezCrfG00,t1b(1));
 curv2_ppbezier_plot(dx11,60,'g',2);
 curv2_ppbezier_plot(sx11b,60,'b',2);

 %%%join

if i==1
    ppbezTopG = curv2_ppbezier_join(dx11,sx11b,1.0e-2);
else
    ppbezTop = curv2_ppbezier_join(dx11,sx11b,1.0e-2);
end

end

curv2_ppbezier_plot(ppbezTop,60,'m',2);
curv2_ppbezier_plot(ppbezTopG,60,'y',2);

%%%colleco le due crf spezzate con parti della circonferenza media


[IP1P2,t1,t2]=curv2_intersect(ppbezCrfM,ppbezCrf);
[IP1P2,t1b,t2b]=curv2_intersect(ppbezCrfM,ppbezTopG);

[sx11,dx11]=ppbezier_subdiv(ppbezCrfM,t1(1));
[sx11b,dx11b]=ppbezier_subdiv(dx11,t1b(1));
curv2_ppbezier_plot(sx11b,60,'g',2);

%%join
ppbezTop1 = curv2_ppbezier_join(sx11b,ppbezTop,1.0e-2);
ppbezTopG1 = curv2_ppbezier_join(ppbezTop1,ppbezTopG,1.0e-2);

%%%%%altra perte di crf G del medio M


[IP1P2,t1,t2]=curv2_intersect(ppbezCrfGM,ppbezCrf);
[IP1P2,t1b,t2b]=curv2_intersect(ppbezCrfGM,ppbezTopG);

[sx11,dx11]=ppbezier_subdiv(ppbezCrfGM,t1(1));
[sx11b,dx11b]=ppbezier_subdiv(dx11,t1b(1));
% curv2_ppbezier_plot(sx11b,60,'k',2);

%%%%%join
ppbezTopF = curv2_ppbezier_join(ppbezTopG1,sx11b,1.0e-2);

curv2_ppbezier_plot(ppbezTopF,60,'c',2);

end

%%%facio la figure 2

open_figure(2);



xy = curv2_ppbezier_plot(ppbezTopF,60,'c',2);
point_fill(xy,'r','k');

xy = curv2_ppbezier_plot(ppbezMedioF,60,'c',2);
point_fill(xy,'g','k');
 


