function [xx,yy,zz,cc] = surf_spline_kurHK_plot(surfspline, ni, nj, cflag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [xx,yy,zz] = surf_spline_kurHK_plot(surfspline, ni, nj, cflag)
%Disegna una superficie 3D spline
%surfspline --> struttura di una superficie spline:
%      surfspline.deguv --> grado della superficie in u e in v
%      surfspline.cp --> griglia dei punti di controllo (ncpu)x(ncpv)x3
%      surfspline.ku  --> vettore dei knot in u
%      surfspline.kv  --> vettore dei knot in v
%ni,nv --> numero di punti da plottare (nixnj) per ogni tratto
%cflag --> 1.curvatura media
%          2.curvatura Gaussiana
%xx,yy,zz <-- coordinate dei punti plottati
%cc <-- valore curvatura nei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[ncpu,ncpv,dim]=size(surfspline.cp);
nu=length(surfspline.ku);
nv=length(surfspline.kv);
%griglia di valutazione
[npu,uu]=gc_mesh(surfspline.deguv(1),surfspline.ku,ni);
[npv,vv]=gc_mesh(surfspline.deguv(2),surfspline.kv,nj);

for i=1:ncpu
 for j=1:ncpv
  x(i,j)=surfspline.cp(i,j,1);
  y(i,j)=surfspline.cp(i,j,2);
  z(i,j)=surfspline.cp(i,j,3);
 end
end

%Algoritmo1: usa B-spline
Bu=gc_bspl_valder(surfspline.deguv(1),surfspline.ku,uu,2);
Bv=gc_bspl_valder(surfspline.deguv(2),surfspline.kv,vv,2);

for i=1:npu
    for j=1:ncpu
        bsu(i,j)=Bu(1,i,j);
        du(i,j)=Bu(2,i,j);
        duu(i,j)=Bu(3,i,j);
    end
end
for i=1:npv
    for j=1:ncpv
        bsv(i,j)=Bv(1,i,j);
        dv(i,j)=Bv(2,i,j);
        dvv(i,j)=Bv(3,i,j);
    end
end
xx=bsu*x*bsv';
yy=bsu*y*bsv';
zz=bsu*z*bsv';

xxu=du*x*bsv';
yyu=du*y*bsv';
zzu=du*z*bsv';

xxv=bsu*x*dv';
yyv=bsu*y*dv';
zzv=bsu*z*dv';

xxuu=duu*x*bsv';
yyuu=duu*y*bsv';
zzuu=duu*z*bsv';

xxvv=bsu*x*dvv';
yyvv=bsu*y*dvv';
zzvv=bsu*z*dvv';

xxuv=du*x*dv';
yyuv=du*y*dv';
zzuv=du*z*dv';

for i=1:npu
    for j=1:npv
        A=[xxu(i,j),yyu(i,j),zzu(i,j)];
        B=[xxv(i,j),yyv(i,j),zzv(i,j)];
        N=cross(A,B);
        N=N./norm(N,2);
        nnx(i,j)=N(1);
        nny(i,j)=N(2);
        nnz(i,j)=N(3);
    end
end

%Coefficienti della prima forma fondamentale
E = xxu.*xxu + yyu.*yyu + zzu.*zzu;
F = xxu.*xxv + yyu.*yyv + zzu.*zzv;
G = xxv.*xxv + yyv.*yyv + zzv.*zzv;
%Coefficienti della seconda forma fondamentale
e = xxuu.*nnx + yyuu.*nny + zzuu.*nnz;
f = xxuv.*nnx + yyuv.*nny + zzuv.*nnz;
g = xxvv.*nnx + yyvv.*nny + zzvv.*nnz;

switch (cflag)
    case 1
      %curvatura Media
      cc=(e.*G-2.0.*f.*F+g.*E)./(2.0.*(E.*G-F.*F));
    case 2
      %curvatura Gaussiana
      cc=(e.*g-f.*f)./(E.*G-F.*F);
end

%disegna superficie e curvatura
colormap(jet);
s=surf(xx,yy,zz,cc);
s.EdgeColor='none';
colorbar;

end
