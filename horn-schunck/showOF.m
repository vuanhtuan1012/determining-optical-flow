function showOF(U, V)
% function showOF shows the optical flow from flow velocities matrix U, V

[l,c] = size(U);
d = 5; % step
IndX = 1:d:l;
IndY = 1:d:c;
[X,Y] = meshgrid(IndY, IndX);
U1 = U(IndX, IndY);
V1 = V(IndX, IndY);
quiver(X, Y, U1(end:-1:1,:), V1(end:-1:1,:), 3);