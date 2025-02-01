clear all 
close all


%grafic setting
open_figure(1);
hold on;
grid("on");



%%%
%%uso la funzoine seno per far l'onda

x = linspace(0,2*pi,8);
y = sin(x);

bezS = curv2_bezier_interp([x' y'],-1,1,0);
curv2_ppbezier_plot(bezS,60,'r');

%%prendo dei punti della curva
l = linspace(-1,1,21);
puntiS  = ppbezier_val(bezS,l);

point_plot(puntiS,'ko');

%%faccio la crf di base

[Crf(:,1),Crf(:,2),Crf1(:,1),Crf1(:,2)]= cp2_circle(x);
ppbezC = curv2_ppbezierCC1_interp_der(Crf,Crf1,x); 
ppbezC0 = ppbezC;
for i=1:length(l)-1
     distanza = sqrt((puntiS(i,1) - puntiS(i+1,1))^2 + (puntiS(i,2) - puntiS(i+1,2))^2);
    S = get_mat_scale([distanza/2,distanza/2]);
    T = get_mat_trasl(puntiS(i,:));
    %T1 = get_mat_trasl(-puntiS(i,:));
    M = T*S;
    ppbezC0.cp = point_trans(ppbezC.cp,M); 
    curv2_ppbezier_plot(ppbezC0,70,'r');
end







