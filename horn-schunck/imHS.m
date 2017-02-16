function imHS(alpha, N)
% function imHS shows optical flow of given sequence of images
% computations based on the algorithm of Horn and Schunck.
% alpha is the weighting factor, by default alpha = 0.01
% N is the number of iteration, by default N = 512

% clear command window
clc;

%set default value to alpha, N
if (nargin < 1)
    alpha = 0.01;
    N = 512;
elseif (nargin == 1)
    N = 512;
end

% read images
Im1 = imread('Im6.png');
Im2 = imread('Im7.png');

% compute U, V by HS
Im1 = im2double(Im1);
Im2 = im2double(Im2);
[U,V] = HS(Im1, Im2, alpha, N);

% show images
figure; 
subplot(1, 2, 1); imshow(Im1, []); title('Im6.png');
subplot(1, 2, 2);  imshow(Im2, []); title('Im7.png');

% show optical flow and save it to a file
figure; showOF(U, V);
str = sprintf('%.5g; N = %d', alpha, N);
title(strcat('\alpha = ',str));
filename = sprintf('hs-%0.5g-%d.png', alpha, N);
print(filename, '-dpng');