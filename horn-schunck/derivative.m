function [Ex, Ey, Et] = derivative(Im1, Im2)
% function DERIVATIVE computes partial derivatives Ex, Ey, Et
% of a sequence of 2 images Im1, Im2 of double class.

% kernels for convolution
Kx = 0.25 * [-1 1; -1 1];
Ky = 0.25 * [-1 -1; 1 1];
Kt = 0.25 * [-1 -1; -1 -1]; % kt1 = Kt, kt2 = -Kt

% compute derivatives
Ex = conv2(Im1, Kx, 'same') + conv2(Im2, Kx, 'same');
Ey = conv2(Im1, Ky, 'same') + conv2(Im2, Ky, 'same');
Et = conv2(Im1, Kt, 'same') + conv2(Im2, -Kt, 'same');