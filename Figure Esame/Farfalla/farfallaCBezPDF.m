 %script per riprodurre il disegno di fig .
  clear all
  clf
 
  col=['r','g','b','k'];
  open_figure (1) 
  grid("on")

 %primo set di punti da interpolare
  Q1=[218.2 385.4
 206.3 445.0
 238.9 520.4
 285.8 538.8
 330.5 515.6
 354.8 453.8
 348.7 403.68];

 %secondo set di punti da interpolare
 Q2=[348.7 403.68
 443.0 412.2
 528.4 349.1
 504.0 255.8
 375.0 220.5
 321.4 241];

 %disegno punti di interpolazione
 % sono i punti cp della curva di Bez 
 point_plot(Q1,'ko',1,'k');
 point_plot(Q2,'ko',1,'k');
 %intervallo parametrico di definizione
 %[0,1] è un intervallo comune e facilita il controllo
 %di interpolazione di punti
 a=0;
 b=1;
 
 %numero punti di plotting
 np=60;

 %scelta dei parametri per i punti di interpolazione (param = 0, 1 o 2)
 
 %Parametrizzazine uniforme (0):
 %I parametri sono assegnati in modo equidistante, indipendentemente dalla
 %distanza tra i punti. Questo può causare distorsioni se i punti di
 %controllo sono molto distanti tra loro

 %Parametrizzazione con Distanza Proporzionale (1):
 %I parametri sono assegnati proporzionalmente alla distanza tra i punti.
 %Questo metodo produce curve più fluide e meno distorte rispetto a quella
 %uniforme.

 %Prametrizzazione centripeta (2):
 %Qui i parametri sono assegnati in modo ancora più uniforme in funzione
 %delle radici quadrate delle distanze. Questo approccio è utile per curve
 %con curvature accentuate, riducendo oscillazioni indesiderate. 

 param=1;
  
 %chiamata a funzione di interpolazione della libreriaanmglib 4 .1
 %Abbiamo un problema di interpolazione perchè partiamo dai punti in cui la
 %curva deve passare e non dai punti di controllo .cp della curva di Bez
 %Il problema di interpolazione si pone perchè in caso di più curve
 %complesseche passano per molti punti, un unica curva di Bez potrebbe non
 %essere sufficiente 
 bP1=curv2_bezier_interp(Q1,a,b,param);
 bP2=curv2_bezier_interp(Q2,a,b,param) ;
 %bP1 e bP2 sono delle curve di Bez

 %uniformiamo i gradi per definire una curva di Bezier a tratti
 %uniformare il grado permette la continuità e l'integhrazione tra le curve
 %di Bez. Notiamo che bP2 ha un grado -1 rispetto bP1 (bP2.deg = 5 e
 %dP1.deg=6) devo far si che i due gradi siano uguali, con la funzione
 %gc_pol_de2d() restituisce i nuovi punti di controllo .cp all'aumentare +1
 %del grad. Successivamente aumento il .deg aggiungendo +1 al vecchio grado
 %invece .ab rimane invariato   (in caso ci siano casi in cui il grado sia
 %+2 immagino si debba fare .deg+1 
 [bP3.cp(: ,1) ,bP3.cp(: ,2)]=gc_pol_de2d(bP2.deg ,bP2.cp(: ,1), bP2. cp (: ,2) ) ;
 bP3.deg=bP2.deg+1;
 bP3.ab=bP2.ab;

 %join delle due curve di B˜ A©zier
 %questa funzione curv2_ppbezier_join collega due curve di bez in un unica
 %curva continua. Il volre della tolleranza metterei sempre 1.0e-4 che
 %sarebbe (0.0001).Dato che vedo che utilizza solo curve spline utilizzarei
 %anche io solo curve spline ovvero quel pp (spline è meglio)
 ppbP=curv2_ppbezier_join(bP1,bP3,1.0e-4);
 curv2_ppbezier_plot(ppbP,np,'r-') ;
 point_plot(ppbP.cp,'bo-') %cp in blu della figura
 
 %simmetrica della curva a tratti rispetto alla retta che
 %passa per gli estremi (vedi funzione)
 [ppbQ,T,R]=align_curve (ppbP) ;

 %Cambia il segno delle coordinate y dei puntii di controllo della curva
 %ppbQ. Questo crea una riflessione (simmetrice) della curva ppbQ rispetto
 %all'asse x
 ppbQ.cp(: ,2)=-ppbQ.cp(: ,2) ;

 %Si calcola Minv, l'inversa della combinazione R*T, che serve a riportare
 %la curva ppbQ nella sua posizione originale, ma nella versione riflessa
 Minv=inv(R*T) ;
 %funzione che applica questa trasformazione inversa a ppbQ, così che la
 %curva rispecchiata mantenga la sua forma simmetrica, ma si riallinei alla
 %posizione originale della curva ppbP
 ppbQ.cp=point_trans(ppbQ.cp ,Minv) ;
 curv2_ppbezier_plot(ppbQ,np,'g-');
 %disegna la curva riflessa con la linea verde
 point_plot(ppbQ.cp(1 ,:) ,'go-')
 %se le si vuole vedere commentare la parte sotto

 %join delle due curve di B˜ A©zier a tratti
 %La funzione curv2_ppbezier_join riceve come input le due curve di Bez
 %a tratti, ppbP(parte originale) e ppbQ(parte riflessa) e unisce le due
 %curve. L'ultimo parametro è la tolleranza che controlla la precisione
 %dell'unione. ppbR è la curva risultante che combina le due curve
 ppbR=curv2_ppbezier_join(ppbP,ppbQ,1.0e-4);
 %fa vedere la curva, i cp e fa il fill dei punti della curva di Bez 
 xy=curv2_ppbezier_plot(ppbR,np,'b-') ;
 point_plot(ppbR.cp(1 ,:) ,'bo-')
 fill(xy(: ,1) ,xy(: ,2) ,'r') ;
 
 %definiamo una delle antenne direttamente come
 %punti di controllo di una lineare a tratti
 bpS.deg=1;
 bpS.ab=[0 ,1 ,2];
 bpS.cp=[321.3 241;
 450 144.2;
 444.6 131.8;
 321.3 241];
 xy=curv2_ppbezier_plot(bpS,2 ,'k-' ,2) ;
 %point_plot(bpS.cp(1 ,:) ,'bo−')
 fill (xy(: ,1) ,xy(: ,2) ,'y') ;
 % curv2 ppbezier plot(bpS,2,'k−',2);
 
 %ruotiamo la curva intorno al primo punto di controllo in senso orario
 %Il punto C rappresenta il centro di rotazione, intorno al quale si vuole
 %ruotare la curva ( questo punto è una coordinata specifica dell'antenna)
 
 C=[321.3 ,241];
 
 %crea una matrice di traslazione 
 T=get_mat_trasl(-C);
 %radianti 
 alfa=-0.50;
 R=get_mat2_rot(alfa);
 Tinv=get_mat_trasl(C);
 M=Tinv*R*T;
 bpT=bpS;
 bpT.cp=point_trans(bpS.cp ,M) ;
 xy=curv2_ppbezier_plot(bpT,2 ,'k-' ,2) ;
%point_plot(ppbT.cp(1 ,:) ,'bo-');
 fill(xy(: ,1) ,xy(: ,2) ,'y') ;
 curv2_ppbezier_plot(bpT,3,'k-',2);


 %La funzione, align_curve trasla e ruotala curva originale in modo che sia
 %allineata con l'asse orizzontale, semplificando l'applicazione di
 %simmetrie.
 %ppbezQ = una nuova versione della ppbezP allineata rispetto agli estremi
 %T = una matrice di traslazione che sposta il primo punto della curva
 %all'origine
 %R = una matrice di rotazione che ruota la curva in modo che l'ultimo
 %punto si trovi sulla stessa altezza del primo
 function [ppbezQ,T,R]=align_curve (ppbezP)
 %numero totale di punti di controllo della curva
 ncp=length(ppbezP.cp(: ,1) ) ;
 ppbezQ=ppbezP;

 %1 Traslazione
 %T è una matrice di traslazione che sposta il primo punto della curva
 %ppbezP, all'origine del sistema di coordinate.In pratic a, viene
 %calcolato il vettore di spostamento che porta il primo punto (x1,y1)
 %della curva a (0,0)
 T=get_mat_trasl(-ppbezP.cp(1 ,:) ) ;
 
 %alfa è l'angolo tra la linea che collega il primo punto e l'ultimo punto
 %della curva e l'asse x. atan2 calcola l'angolo (in radianti) a partire
 %dalle differenze y e x tra il punto finale e il punto iniziale. L'angolo
 %è negativo per ruotare in senso orario, portando così il segmento
 %iniziale-finale a essere orizzontale.
 alfa = -atan2(ppbezP.cp(ncp ,2) - ppbezP.cp(1 ,2) , ppbezP.cp(ncp ,1) - ppbezP.cp(1 ,1)) ;
 
 %R è una matrice di rotazione che ruota i punti della curva di alfa
 %radianti, allineando il segmento tra primo e ultimo con l'asse x.
 %Definisce la matrice 3x3 di rotazione 2D in base all'angolo alfa in input
 R=get_mat2_rot(alfa ) ;

 %La matrice M combina la traslazione T e la rotazione R. Viene poi
 %applicata alla curva ppbezP per trasformare tutti i suoi punti di
 %controllo, ottenendo ppbezQ, una curva allineata orizzontalmente e pronta
 %per l'operazione di simmetria
 M=R*T;
 %point_trans calcola le lista di punti 2D dopo averli trasformati con la
 %matrice M ( matrice di trasformazione)
 ppbezQ.cp=point_trans(ppbezP.cp ,M) ;
 end






