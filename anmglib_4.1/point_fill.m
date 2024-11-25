function point_fill(p,col,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function point_fill(p,col,varargin)
%Disegna punti, liste di punti o griglie di punti 2D
%p  --> punto/i 2D (nx2)
%col  --> colore di riempimento come singolo char o tripla 
%varargin --> argomenti opzionali di disegno del bordo da assegnare
%             nel seguente ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%check sul numero di opzionali inseriti
numvarargs = length(varargin);
if numvarargs > 5
    error('Inserire al massimo 5 parametri opzionali');
end

if numvarargs > 0
%default per i parametri opzionali
  optargs = {'-k' 1 'k' [0.5,0.5,0.5] 6};

%sovrascrivo in optargs gli opzionali specificati in varargin
  optargs(1:numvarargs) = varargin;

  [ls, lw, mec, mfc, ms] = optargs{:};
end

[m,n,l]=size(p);
if (l==1)
  if (n==2)
    x=p(:,1);
    y=p(:,2);
    fill(x,y,col,'LineStyle','none');
    if (numvarargs > 0)
       plot(x,y,ls,...
          'LineWidth',lw,...
          'MarkerEdgeColor',mec,...
          'MarkerFaceColor',mfc,...
          'MarkerSize',ms);
    end
  end
else
  error('I punti devono essere 2D');
end

end
