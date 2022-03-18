% define model
mdl_puma560;

% generate random matrix 3x3 for 3 points (only four quadrants)
mxval_x = 0.5; mnval_x = -0.5;
points_x = mnval_x + rand(3,1)*(mxval_x - mnval_x);

mxval_y = 0.5; mnval_y = 0.2;
points_y = mnval_y + rand(3,1)*(mxval_y - mnval_y);

mxval_z = 0.5; mnval_z = -0.5;
points_z = mnval_z + rand(3,1)*(mxval_z - mnval_z);

points = [points_x points_y points_z]; % three 3x1 matrices into one 3x3 matrix

p1 = points(1, :); % get first row of points
t1 = transl(p1);   % define the start point

p2 = points(2, :); % get second row of points
t2 = transl(p2);   % middle destination

p3 = points(3, :); % get third row of points
t3 = transl(p3);   % and destination

% compute a Cartesian path
T1 = ctraj(t1, t2, 50);
T2 = ctraj(t2, t3, 50);
T = cat(3, T1, T2); % concat T1 and T2

% calculate arm's joint angles during path
q = p560.ikine6s(T);

% draw dots at arm's simulation
plot_sphere(p1, 0.05, 'g'); % green dot
plot_sphere(p2, 0.05, 'y'); % yellow dot
plot_sphere(p3, 0.05, 'r'); % red dot

% animation arm's moviment
p560.plot(q, 'loop');