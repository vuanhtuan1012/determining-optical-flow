function vidLK(ws)
% function vidLK shows optical flow in a video
% computations based on the algorithm of Lucas and Kanade.
% ws is the window size, by default ws = 15

% clear the command window
clc;

%set default value to alpha, N
if (nargin < 1)
    ws = 15;
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
i = 0;
while hasFrame(vidObj)
    i = i+1;
    Fr2 = rgb2gray(readFrame(vidObj)); % get second frame
    Fr2 = im2double(Fr2);
    
    % compute U, V by LK
    [U, V, C] = LK(Fr1, Fr2, ws);
        
    % show frames and optical flow
    subplot(1, 3, 1);
    imshow(Fr1, []); title('Frame 1');
    subplot(1, 3, 2);
    imshow(Fr2, []); title('Frame 2');
    subplot(1, 3, 3);
    showOF(Fr1, C, U, V); title('Optical Flow');
    axis image; % set subplot same size
    str = sprintf('Window size = %d', ws);
    suptitle(strcat(str));
    
    Fr1 = Fr2; % Fr2 becomes first frame of next sequence
end