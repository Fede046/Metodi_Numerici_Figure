%main di esempio per visualizzazione curva di Bezier a tratti
clear all
close all



col=['r','g','b','k','m','c','y','r','g','b','k','m','c','y'];
open_figure(2);
axis_plot(1.25,0.125);


%curva da file

ppP=curv2_ppbezier_load('ppbez_esse.db');
%disegno della curva a tratti
%

%estrae le singole curve di Bezier e calcola la loro area

%TO DO

fprintf('area della curva: %e\n',val); 

