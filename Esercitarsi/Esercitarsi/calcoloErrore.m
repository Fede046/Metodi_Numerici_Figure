clear all
close all

%grafic setting
open_figure(1);
hold on



%t
mp=40;
a=-1;  
b=1;

%bez
x=linspace(a,b,5);
y1=c2_bicorn1(x)

matrix = [x' y1'];
%interpolazione
ppbezy = curv2_bezier_interp(matrix,a,b,0);


%%%%%%%%calcolo dell'errore nel caso di curva di bez non a tratti
Qxy = curv2_ppbezier_plot(ppbezy,150,'r');
kk = linspace(-1,1,150);
y1=c2_bicorn1(kk);


fprintf('\n---Stampe---\n');
MaxErr1=max(abs(Qxy(:,2)-y1'));
fprintf('MaxErr1: %e\n',MaxErr1);



%%%%%%calcolo dell'errore nel caso di curva di ppbez a tratti


%%%%%tratti
t=linspace(a,b,40);
y1i=c2_bicorn1(t);

matrix = [t' y1i'];
%interpolazione
ppbezyi = curv2_ppbezierCC1_interp(matrix,a,b,0);


%valutazione in punti equispaziati per test sull'errore

Pxy=ppbezier_val(ppbezyi,t);
%point_plot(Pxy,'k',2);
% point_plot(Pxy,'r',4)
yi=c2_bicorn1(t);
Qxy=[t',yi'];
%point_plot(Qxy,'m',2);


%calcola la distanza euclidea fra i punti della curva test
%e della curva di Bézier a tratti interpolante e considera
%la distanza massima
MaxErr=max(vecnorm((Pxy-Qxy)'));
fprintf('MaxErr3: %e\n',MaxErr);



function y=c2_bicorn1(x)
%espressione parametrica della curva bicorn1 
%per t in [-1,1]
    y = (2-2*x.^2-sqrt(1-3*x.^2+3*x.^4-x.^6))./(3+x.^2);
end


















