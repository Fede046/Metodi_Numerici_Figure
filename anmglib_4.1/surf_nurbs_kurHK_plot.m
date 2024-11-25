function [xx,yy,zz,cc] = surf_nurbs_kurHK_plot(surfnurbs, ni, nj, cflag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [xx,yy,zz] = surf_nurbs_kurHK_plot(surfnurbs, ni, nj, cflag)
%Disegna una superficie 3D nurbs
%surfnurbs --> struttura di una superficie spline:
%      surfnurbs.deguv --> grado della superficie in u e in v
%      surfnurbs.cp --> griglia dei punti di controllo (ncpu)x(ncpv)x3
%      surfnurbs.ku  --> vettore dei knot in u
%      surfnurbs.kv  --> vettore dei knot in v
%      surfnurbs.w --> griglia dei pesi (ncpu)x(ncpv)
%ni,nj --> numero di punti da plottare (nixnj) per ogni tratto 
%cflag --> 1.curvatura media
%          2.curvatura Gaussiana
%xx,yy,zz <-- coordinate dei punti plottati
%cc <-- valore curvatura nei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[ncpu,ncpv,dim]=size(surfnurbs.cp);
nu=length(surfnurbs.ku);
nv=length(surfnurbs.kv);
%griglia di valutazione
[npu,uu]=gc_mesh(surfnurbs.deguv(1),surfnurbs.ku,ni);
[npv,vv]=gc_mesh(surfnurbs.deguv(2),surfnurbs.kv,nj);

for i=1:ncpu
 for j=1:ncpv
  x(i,j)=surfnurbs.cp(i,j,1);
  y(i,j)=surfnurbs.cp(i,j,2);
  z(i,j)=surfnurbs.cp(i,j,3);
 end
end

%Algoritmo1: usa B-spline
Bu=gc_bspl_valder(surfnurbs.deguv(1),surfnurbs.ku,uu,2);
Bv=gc_bspl_valder(surfnurbs.deguv(2),surfnurbs.kv,vv,2);
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
ww=bsu*surfnurbs.w*bsv';
wx=surfnurbs.w.*x;
wy=surfnurbs.w.*y;
wz=surfnurbs.w.*z;

xx=bsu*wx*bsv';
yy=bsu*wy*bsv';
zz=bsu*wz*bsv';
xx=xx./ww;
yy=yy./ww;
zz=zz./ww;

xxu=du*wx*bsv'-xx.*(du*(surfnurbs.w)*bsv');
yyu=du*wy*bsv'-yy.*(du*(surfnurbs.w)*bsv');
zzu=du*wz*bsv'-zz.*(du*(surfnurbs.w)*bsv');
xxu=xxu./ww;
yyu=yyu./ww;
zzu=zzu./ww;

xxv=bsu*wx*dv'-xx.*(bsu*(surfnurbs.w)*dv');
yyv=bsu*wy*dv'-yy.*(bsu*(surfnurbs.w)*dv');
zzv=bsu*wz*dv'-zz.*(bsu*(surfnurbs.w)*dv');
xxv=xxv./ww;
yyv=yyv./ww;
zzv=zzv./ww;

xxuu=duu*wx*bsv'-2.*xxu.*(du*(surfnurbs.w)*bsv')-xx.*(duu*(surfnurbs.w)*bsv');
yyuu=duu*wy*bsv'-2.*yyu.*(du*(surfnurbs.w)*bsv')-yy.*(duu*(surfnurbs.w)*bsv');
zzuu=duu*wz*bsv'-2.*zzu.*(du*(surfnurbs.w)*bsv')-zz.*(duu*(surfnurbs.w)*bsv');
xxuu=xxuu./ww;
yyuu=yyuu./ww;
zzuu=zzuu./ww;

xxvv=bsu*wx*dvv'-2.*xxv.*(bsu*(surfnurbs.w)*dv')-xx.*(bsu*(surfnurbs.w)*dvv');
yyvv=bsu*wy*dvv'-2.*yyv.*(bsu*(surfnurbs.w)*dv')-yy.*(bsu*(surfnurbs.w)*dvv');
zzvv=bsu*wz*dvv'-2.*zzv.*(bsu*(surfnurbs.w)*dv')-zz.*(bsu*(surfnurbs.w)*dvv');
xxvv=xxvv./ww;
yyvv=yyvv./ww;
zzvv=zzvv./ww;

xxuv=du*wx*dv'-xxv.*(du*(surfnurbs.w)*bsv')-xxu.*(bsu*(surfnurbs.w)*dv')-xx.*(du*(surfnurbs.w)*dv');
yyuv=du*wy*dv'-yyv.*(du*(surfnurbs.w)*bsv')-yyu.*(bsu*(surfnurbs.w)*dv')-yy.*(du*(surfnurbs.w)*dv');
zzuv=du*wz*dv'-zzv.*(du*(surfnurbs.w)*bsv')-zzu.*(bsu*(surfnurbs.w)*dv')-zz.*(du*(surfnurbs.w)*dv');
xxuv=xxuv./ww;
yyuv=yyuv./ww;
zzuv=zzuv./ww;

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

colormap(jet);
s=surf(xx,yy,zz,cc);
s.EdgeColor='none';
colorbar;

%   // Coefficienti della prima forma fondamentale
%   E = du[0]*du[0] + du[1]*du[1] + du[2]*du[2];
%   F = du[0]*dv[0] + du[1]*dv[1] + du[2]*dv[2];
%   G = dv[0]*dv[0] + dv[1]*dv[1] + dv[2]*dv[2];
%   // Coefficienti della seconda forma fondamentale
%   e = d2u[0]*nn[0] + d2u[1]*nn[1] + d2u[2]*nn[2];
%   f = duv[0]*nn[0] + duv[1]*nn[1] + duv[2]*nn[2];
%   g = d2v[0]*nn[0] + d2v[1]*nn[1] + d2v[2]*nn[2];
%   // Curvatura media H
%   // NOTA: e' stato messo un segno "-" davanti, per coerenza con la convenzione delle normali esterne e della scala di colori
%   // usualmente associata alla curvatura (positiva-rossi, negativa-blu)
%   HK[0] = -(e*G-2.0*f*F+g*E)/(2.0*(E*G-F*F));
%   // Curvatura gaussiana K
%   HK[1] = (e*g-f*f)/(E*G-F*F);
  
end
