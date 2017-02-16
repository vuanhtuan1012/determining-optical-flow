function showOF(I, C, U, V)
% function showOF draws the optical flow from flow velocities U, V
% and suitable corners C on image I

imshow(I); hold on;
quiver(C(:,1), C(:,2), -U, -V, 1, 'r'); hold off;