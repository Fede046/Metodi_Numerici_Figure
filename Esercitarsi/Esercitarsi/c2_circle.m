%circonferenza di centro l'origine e raggio unitario
function [x,y]=c2_circle(t,r)
    %r raggio
    %t angolo
    x=r*cos(t);
    y=r*sin(t);
end