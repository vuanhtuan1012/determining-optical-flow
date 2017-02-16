function [U, V] = HS(Im1, Im2, alpha, N)
% function HS computes flow velocities U, V of a sequence of 2 images
% Im1, Im2 of double class based on Horn-Schunck algorithm. alpha is the
% weighting factor and N is the number of iteration.

% compute partial derivatives
[Ex, Ey, Et] = derivative(Im1, Im2);

% intial U, V
[l, c] = size(Im1);
U = zeros(l, c);
V = zeros(l, c);

K = [1/12 1/6 1/12; 1/6 -1 1/6; 1/12 1/6 1/12]; % Laplacian kernel
A = alpha^2 + Ex.^2 + Ey.^2;

for i = 1:N
    % compute U,V averages
    U_avg = conv2(U, K, 'same');
    V_avg = conv2(V, K, 'same');
    B = (Ex.*U_avg + Ey.*V_avg + Et);
    
    % compute U, V at current iteration
    U = U_avg - Ex.*B./A;
    V = V_avg - Ey.*B./A;
end;