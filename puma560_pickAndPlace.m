% define model
mdl_puma560;

% pick and place points
h1 = [ 0.5  0.3  0.5]; % hover 1
a1 = [ 0.5  0.3 -0.2]; % approximation 1
c1 = [ 0.5  0.3 -0.5]; % contact 1
h2 = [-0.5  0.3  0.5]; % hover 2
a2 = [-0.5  0.3 -0.2]; % approximation 2
c2 = [-0.5  0.3 -0.5]; % contact 2

t1 = transl(h1);
t2 = transl(a1);
t3 = transl(c1);
t4 = transl(h2);
t5 = transl(a2);
t6 = transl(c2);

% trajectory
% h1 -> a1 -> c1 -> h1 -> h2 -> a2 -> c2

% compute a Cartesian path
T1 = ctraj(t1, t2, 50); % h1 -> a1
T2 = ctraj(t2, t3, 50); % a1 -> c1
T3 = ctraj(t3, t1, 50); % c1 -> h1
T4 = ctraj(t1, t4, 50); % h1 -> h2
T5 = ctraj(t4, t5, 50); % h2 -> a2
T6 = ctraj(t5, t6, 50); % a2 -> c2


T = cat(3, T1, T2, T3, T4, T5, T6); % concat T1 ~ T6

% calculate arm's joint angles during path
% also check the Denavit-Hartenberg to
% determinate if the robot meets the criteria
q = p560.ikine6s(T, 'ru'); % ru -> Rigth arm and elbow Up

% draw dots at arm's simulation
plot_sphere(h1, 0.05, 'g'); % hover 1 dot
plot_sphere(a1, 0.05, 'g'); % approximation 1 dot
plot_sphere(c1, 0.05, 'g'); % contact 1 dot
plot_sphere(h2, 0.05, 'r'); % hover 1 dot
plot_sphere(a2, 0.05, 'r'); % approximation 1 dot
plot_sphere(c2, 0.05, 'r'); % contact 1 dot

% animation arm's movement
p560.plot(q, 'loop');