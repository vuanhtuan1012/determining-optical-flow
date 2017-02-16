function imLK(ws)
% function imLK shows optical flow of given sequence of images
% computations based on the algorithm of Lucas-Kanade.
% ws is the window size, by default ws = 15

% clear the command window
clc;

%set default value to alpha, N
if (nargin < 1)
    ws = 15;
end

% read images
Im1 = imread('Im6.png');
Im2 = imread('Im7.png');

% compute U, V by Lucas Kanade
% C is coordinates of corners in Im1
Im1 = im2double(Im1);
Im2 = im2double(Im2);
[U, V, C] = LK(Im1, Im2, ws);

% show images
figure; 
subplot(1, 2, 1); imshow(Im1, []); title('Im6.png');
subplot(1, 2, 2);  imshow(Im2, []); title('Im7.png');

% show optical flow and save it to a file
figure; showOF(Im1, C, U, V);
filename = sprintf('lk-%d.png', ws);
print(filename, '-dpng');