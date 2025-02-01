%carica un disegno composto da curve chiuse/regioni e colori
%input:
%fname --> stringa indicante file .dat contenente la lista di curve e
%          colori da caricare
%output:
%dis  --> array di celle (ns x 2):
%   la prima colonna contiene la struttura di ns curve di Bézier a tratti;
%   la seconda colonna la tripla indicante il colore da utilizzare per
%   quella curva/regione
function dis=load_geom(fname)
fid = fopen(fname);
ns=fscanf(fid,'%5d',1);
dis=cell(ns,2);
for i=1:ns
    n=fscanf(fid,'%5d',1);
    r=fscanf(fid,'%5f',1);
    g=fscanf(fid,'%5f',1);
    b=fscanf(fid,'%5f',1);
    txtname=[fname(1:end-4),'_',num2str(n),'.db'];
    ppP=curv2_ppbezier_load(txtname);
    dis{i,1}=ppP;
    dis{i,2}=[r,g,b];
end
fclose(fid);
end