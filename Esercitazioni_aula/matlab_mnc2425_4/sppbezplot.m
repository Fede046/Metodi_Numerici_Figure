%main di esempio per visualizzazione curva di Bezier a tratti
clear all
close all

col=['r','g','b','k','m','c','y','r','g','b','k','m','c','y'];
open_figure(2);
axis_plot(1,0.125);
ppP=curv2_ppbezier_load('c2_ppbez_esse.db');
curv2_ppbezier_plot(ppP,100,'k-');
length(ppP.cp)

%for i = 1:8
%    [sx, dx] = decast_subdiv(ppP, 0.5);
%    curv2_ppbezier_plot(sx, 100, col(i));
%    ppP=dx;
%end

%cerca: suddividere curva di bezier a tratti
somma = 4;
righe = 1;


bezP.deg = ppP.deg;

for i= 1:8
    bezP.ab = ppP.ab;%[ppP.ab(i),ppP.ab(i+1)]; % intervallo i-esima curva
    bezP.cp = [ppP.cp(righe:somma,1),ppP.cp(righe:somma,2)];% punti di controllo i-esima curva
    bezP.cp;
    righe = righe+3;
    somma = somma+3;
    %point_plot(bezP.cp,col(i));
    curv2_bezier_plot(bezP,40,col(i),1);
end


%script del prof
%n=ppP.ddeg;
%[ncp,~]= size(ppP.cp);
%ncp(ncp-1)/n;
%foto su cell