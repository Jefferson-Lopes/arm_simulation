% define model
mdl_puma560;

p1 = [0.6 -0.5 0.0];
T1 = transl(p1); % define the start point

p2 = [0.4 0.5 0.2];
T2 = transl(p2);	% and destination

T = ctraj(T1, T2, 50); 	% compute a Cartesian path

q = p560.ikine6s(T);

clf;

plot_sphere(p1, 0.05, 'g');
plot_sphere(p2, 0.05, 'r');
p560.plot(q);