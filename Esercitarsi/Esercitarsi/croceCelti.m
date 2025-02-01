clear all
close all


%
open_figure(1);
hold on;
grid("on");



%faccio ua crf
p = linspace(0,2*pi,16);
for i=1:16
    [Ad(i,1),Ad(i,2)]=c2_circle(p(i),1);
    [A1d(i,1),A1d(i,2)]=c2_circle(p(i),0.8);
end
As=Ad+[-1 0];
A1s=A1d+[-1 0];

Ab = Ad+[-0.5 -0.9];
A1b = A1d + [-0.5 -0.9]; 

%sx
bezAs = curv2_bezier_interp(As,0,1,0);
bezA1s = curv2_bezier_interp(A1s,0,1,0);

curv2_ppbezier_plot(bezA1s,60,'g');
curv2_ppbezier_plot(bezAs,60,'g');



%dx
bezAd = curv2_bezier_interp(Ad,0,1,0);
bezA1d = curv2_bezier_interp(A1d,0,1,0);

curv2_ppbezier_plot(bezA1d,60,'r');
curv2_ppbezier_plot(bezAd,60,'r');

%basso
bezAb = curv2_bezier_interp(Ab,0,1,0);
bezA1b = curv2_bezier_interp(A1b,0,1,0);

curv2_ppbezier_plot(bezA1b,60,'b');
curv2_ppbezier_plot(bezAb,60,'b');


