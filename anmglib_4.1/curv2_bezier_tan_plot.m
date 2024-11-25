function Px=curv2_bezier_tan_plot(bezier,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=curv2_bezier_tan_plot(bezier,np,varargin)
%Disegna il vettore tangente di una curva 2D di Bezier
%bezier --> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (bezier.deg+1)x2
%          bezier.ab  --> intervallo di definizione
%np --> numero di punti in cui valutare e disegnare i vettori tangente
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%Px <-- vettori tangenti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=bezier.deg+1;

mesh = linspace(bezier.ab(1),bezier.ab(2),abs(np));

%Algoritmo1
%bas_bernst = bernst_valder(g,t);
%x=bas_bernst*qx;
%y=bas_bernst*qy;

%Algoritmo2
Px=decast_valder(bezier,1,mesh);

if (np > 0)
    for i=1:np
     vect2_plot([Px(1,i,1),Px(1,i,2)],[Px(2,i,1),Px(2,i,2)],varargin{:});
    end
end

end

