%script che richiama def_pol e valuta i polinomi con Alg.2
clear all
close all

ex = 6;
[g, cP, cB] = def_pol(ex);

% definizione polinomio nella base di Bernstein
p.deg = g;
p.ab = [0, 1];
p.cp = cB';

% numero dei punti di valutazione in [0,1]
np = 100;
t = linspace(0, 1, np)';

% valutazione polinomio nella base di Bernstein
% funzione decast_valder del toolbox anmglib_4.0
% cerca: derivata curva decast
Px = decast_valder(p, g - 1, t);
y = Px(1, :);  
y1 = Px(2, :);

figure('Name', 'Polinomio test')
hold on
plot(t, y, '-', 'Color', 'r', 'LineWidth', 1.5);
plot(t, y1, '-', 'Color', 'b', 'LineWidth', 1.5);
title('Polinomio test', 'FontWeight', 'bold')
legend('p_P(x)', "p_P'(x)")