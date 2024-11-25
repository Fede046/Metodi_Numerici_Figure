function ppbez=curv2_ppbezier_join(pp1,pp2,tol)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function ppbez = curv2_ppbezier_join(pp1,pp2,tol)
%Calcola la curva 2D di Bezier a tratti, join delle due
%curve di Bézier o di Bézier a tratti pp1 e pp2
%pp1,pp2 --> strutture delle curve 2D di Bezier a tratti:
%            pp1.deg --> grado della curva
%            pp1.cp  --> lista dei punti di controllo
%            pp1.ab  --> partizione nodale di [a b]
%tol   --> tolleranza entro cui gli estremi delle due curve 
%          vengono considerati uguali
%ppbez <-- struttura della curva 2D di Bezier a tratti :
%          ppbez.deg --> grado della curva
%          ppbez.cp  --> lista dei punti di controllo
%          ppbez.ab  --> partizione nodale di [a b]
%Nota: come detto questa function può essere utilizzata anche se
%le due curve di input sono solo curve di Bézier dello stesso grado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 ppbez=[];
 if (pp1.deg == pp2.deg)
  n1=length(pp1.ab);
  n2=length(pp2.ab);
  ncp1=length(pp1.cp(:,1));
  ncp2=length(pp2.cp(:,1));
  if (norm(pp1.cp(ncp1,:) - pp2.cp(1,:),2) <= tol)
     %caso in cui le due curve da connettere 
     %sono orientate nello stesso senso (up)
%        disp('caso 1')
     ppbez=pp1;
     ppbez.ab=[ppbez.ab,ppbez.ab(n1)+pp2.ab(2:n2)-pp2.ab(1)];
     ppbez.cp=[pp1.cp;pp2.cp(2:ncp2,:)];
  elseif (norm(pp1.cp(ncp1,:)-pp2.cp(ncp2,:),2) <= tol)
     %caso in cui le due curve da connettere 
     %sono orientate in senso opposto (uu)
%        disp('caso 2')
     pp2=curv2_ppbezier_reverse(pp2);
     ppbez=pp1;
     ppbez.ab=[ppbez.ab,ppbez.ab(n1)+pp2.ab(2:n2)-pp2.ab(1)];
     ppbez.cp=[pp1.cp;pp2.cp(2:ncp2,:)];
  elseif (norm(pp1.cp(1,:) - pp2.cp(1,:),2) <= tol)
     %caso in cui le due curve da connettere
     %sono orientate in senso opposto (pp)
%        disp('caso 3')
     pp2=curv2_ppbezier_reverse(pp2);
     ppbez=pp2;
     ppbez.ab=[ppbez.ab,ppbez.ab(n2)+pp1.ab(2:n1)-pp1.ab(1)];
     ppbez.cp=[pp2.cp;pp1.cp(2:ncp1,:)];
   elseif (norm(pp1.cp(1,:) - pp2.cp(ncp2,:),2) <= tol)
     %caso in cui le due curve da connettere
     %sono orientate nello stesso senso (pu)
%             disp('caso 4')
     ppbez=pp2;
     ppbez.ab=[ppbez.ab,ppbez.ab(n2)+pp1.ab(2:n1)-pp1.ab(1)];
     ppbez.cp=[pp2.cp;pp1.cp(2:ncp1,:)];
  else
     fprintf('Le curve sono disgiunte\n');
     ppbez=[];
  end
 else
     fprintf('Le curve non hanno stesso grado\n');
     ppbez=[];
 end
end