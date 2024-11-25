function point_plot(p,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function point_plot(p,varargin)
%Disegna punti, liste di punti o griglie di punti 2D e 3D
%p  --> punto/i 2D o 3D (nx2 o nx3)
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%check sul numero di opzionali inseriti
numvarargs = length(varargin);
if numvarargs > 5
    error('Inserire al massimo 5 parametri opzionali');
end

%default per i parametri opzionali
optargs = {'-k' 1 'k' [0.5,0.5,0.5] 6};

%sovrascrivo in optargs gli opzionali specificati in varargin
optargs(1:numvarargs) = varargin;

[ls, lw, mec, mfc, ms] = optargs{:};

[m,n,l]=size(p);
if (l==1)
  if (n==2)
    x=p(:,1);
    y=p(:,2);
    plot(x,y,ls,...
    'LineWidth',lw,...    
    'MarkerEdgeColor',mec,...
    'MarkerFaceColor',mfc,...
    'MarkerSize',ms);
  end
  if (n==3)
    x=p(:,1);
    y=p(:,2);
    z=p(:,3);
    plot3(x,y,z,ls,...
    'LineWidth',lw,...
    'MarkerEdgeColor',mec,...
    'MarkerFaceColor',mfc,...
    'MarkerSize',ms);
  end
else
  x=p(:,:,1);
  y=p(:,:,2);
  z=p(:,:,3);
  plot3(x,y,z,ls,...
    'LineWidth',lw,...
    'MarkerEdgeColor',mec,...
    'MarkerFaceColor',mfc,...
    'MarkerSize',ms);
  plot3(x',y',z',ls,...
    'LineWidth',lw,...
    'MarkerEdgeColor',mec,...
    'MarkerFaceColor',mfc,...
    'MarkerSize',ms);
end

end
