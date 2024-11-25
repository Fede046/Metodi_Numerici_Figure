clear all
clf

%creazione della struttura
bex.cp=[0,0;0,2;2,2;2,0;0,0];
bex.deg=length(bex.cp(:,1))-1;
bex.ab=[0 1];

%setting grafico
figure(1);
hold on
grid("on");
axis_plot();axis equal;

%disegno della curva di bex e dei cp
curv2_bezier_plot(bex,40,'b');
point_plot(bex.cp,'g-o')



%disegno della curva di bez ma traslata di [1,1]
bexT.cp=bex.cp+[0,-2];
bexT.deg=length(bexT.cp(:,1))-1;
bexT.ab=[0 1];

%disegno della curva di bexT e dei cp
curv2_bezier_plot(bexT,40,'b');
point_plot(bexT.cp,'r-o');


%disegno della curva di bex ma con scala maggiore
bexS.cp=bex.cp.*[2,2];
bexS.deg=length(bexS.cp(:,1))-1;
bexS.ab=[0 1];

%disegno della curva bexS e dei cp
curv2_bezier_plot(bexS,40,'b');
point_plot(bexS.cp,'k-o')

%disegno della curva di bex ma ruotata di angolo q
%l'origine è il punto fisso
q=0;
for i=1:8
q=q+pi/4
bexR.cp=bex.cp*[cos(q),sin(q);-sin(q),cos(q)]+[9,5];
bexR.deg=length(bexR.cp(:,1))-1;
bexR.ab=[0 1];

%disegno della curva bexR
point_plot(bexR.cp,'m-o')
curv2_bezier_plot(bexR,40,'b');
end




