function vel = curv2_bezier_vel_plot(bezier,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function vel = curv2_bezier_vel_plot(bezier,np,varargin)
%Disegna la funzione velocita' di una curva di Bezier 2D
%bezier --> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (bezier.deg+1)x2
%          bezier.ab  --> intervallo di definizione
%np --> numero di punti in cui valutare e disegnare i valori velocita'
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%vel <-- valori della  funzione velocita'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%n=g+1;

mesh = linspace(bezier.ab(1),bezier.ab(2),abs(np));

Px=decast_valder(bezier,1,mesh);

if (np > 0)
    for i=1:np
        vel(i)=norm([Px(2,i,1),Px(2,i,2)],2);
    end
end

mesh_curv2_plot(mesh,vel,varargin{:});

end