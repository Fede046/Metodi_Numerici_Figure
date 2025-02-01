function [g,cP,cB]=def_pol(ex)
%function che definisce polinomi in [0,1] sia 
%nella base canonica che nella base di Bersntein

switch ex
    case 1
        % polinomio di Wilkinson di grado 6;
        % cP coefficienti nella base canonica (1,t,t^2,...,t^6):
        % cB coefficienti nella base di Bernstein
        g = 6;
        cP = [5/324, -49/216, 203/162, -245/72, 175/36, -7/2, 1];
        cB = [5/324, -29/1296, 227/9720, -227/12960, 29/3240, -5/1944, 0];
    case 2
        % polinomio di grado 10 con coefficienti di segno alterno nella base canonica;
        % cP coefficienti nella base (1,t,t^2,...,t^10):
        % +1 -1 +1 -1 +1 -1 +1 -1 +1 -1 +1
        % cB coefficienti nella base di Bernstein
        g = 10;
        cP = (-1).^(0:g);
        cB = [1, 9/10, 37/45, 91/120, 74/105, 83/126, 13/21, 7/12, 5/9, 1/2, 1];
    case 3
        % polinomio di grado 10 con coefficienti di segno alterno sia nella
        % base di Bernstein che canonica;
        % cP coefficienti nella base(1,t,t^2,...,t^10):
        % cB coefficienti nella base di Bernstein
        g = 10;
        cP = [1, -20, 180, -960, 3360, -8064, 13440, -15360, 11520, -5120, 1024];
        cB = (-1).^(0:g);
    case 4
        % p(t)=1+t+t^2+...+t^g
        % CP coefficienti nella base canonica:
        % 1, ..., 1
        % CB coefficienti nella base di Bernstein:
        % 1, (g+1)/g, ... , (g+1)/2, g+1
        g = 6;
        cP = ones(1,g+1);
        cB = (g+1)./((g+1):-1:1);
    case 5
        % p(t)=1+t+t^2/2!+...+t^g/g!
        % CP coefficienti nella base canonica:
        % 1/i!, i=0,...,g
        % CB coefficienti nella base di Bernstein, per g=11:
        % 1, 12/11, 131/110, 644/495, 751/528, 21569/13860, 566827/332640, 21569/11550, 13627073/6652800, 2244083/997920, 4697191/1900800, 13563139/4989600
        g = 11;
        cP = 1./factorial(0:g);
        cB = [1, 12/11, 131/110, 644/495, 751/528, 21569/13860, 566827/332640, 21569/11550, 13627073/6652800, 2244083/997920, 4697191/1900800, 13563139/4989600];
    case 6
        % p(t)=(1-t)^g
        % CP coefficienti nella base canonica:
        % 1, 0, ..., 0, -1
        % CB coefficienti nella base di Bernstein:
        % 1, 1, ..., 1, 0
        g = 7;
        cP = zeros(1,g+1); cP(1) = 1; cP(g+1) = -1;
        cB = ones(1,g+1); cB(g+1) = 0;
    otherwise
        error('Scelta dell''esempio non valida; indicare un altro numero.')
end