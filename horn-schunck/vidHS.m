function vidHS(alpha, N)
% function vidHS shows optical flow in a video
% computations based on the algorithm of Horn and Schunck.
% alpha is the weighting factor, by default alpha = 0.5
% N is the number of iteration, by default N = 128

% clear the command window
clc;

%set default value to alpha, N
if (nargin < 1)
    alpha = 0.5;
    N = 128;
elseif (nargin == 1)
    N = 128;
end

% read video to object
vidObj = VideoReader('video.mpg');

% get first frame
if hasFrame(vidObj)
    Fr1 = rgb2gray(readFrame(vidObj));
    Fr1 = im2double(Fr1);
else
    return
end

while hasFrame(vidObj)
    Fr2 = rgb2gray(readFrame(vidObj)); % get second frame
    Fr2 = im2double(Fr2);
    
    % compute U, V by HS
    [U, V] = HS(Fr1, Fr2, alpha, N);
        
    % show frames and optical flow
    subplot(1, 3, 1);
    imshow(Fr1, []); title('Frame 1');
    subplot(1, 3, 2);
    imshow(Fr2, []); title('Frame 2');
    subplot(1, 3, 3);
    showOF(U, V); title('Optical Flow');
    axis image; % set subplot same size
    str = sprintf('%.5g; N = %d', alpha, N);
    suptitle(strcat('\alpha = ',str));
    
    Fr1 = Fr2; % Fr2 becomes first frame of next sequence
end