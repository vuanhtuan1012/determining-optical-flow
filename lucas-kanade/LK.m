function [U, V, C] = LK(Im1, Im2, ws)
% function LK computes flow velocities U, V of a sequence of 2 images
% Im1, Im2 of double class based on Lucas-Kanade method. ws is the
% window size.
% return (U, V) flow velocities, C coordinates of corners in Im1

% find corners by Harris
C = corner(Im1, 500);

% mark corners in the margin as (-1, -1)
[m, n] = size(Im1);
w = round(ws/2); % half of windows size
for i = 1:size(C, 1)
    x = C(i, 1);
    y = C(i, 2);
    if (x <= w) || (x >= n-w) % corners in left, right margin
        C(i,:) = -1;
    end
    if (y <= w) || (y >= m-w) % corner in top, bottom margin
        C(i,:) = -1;
    end
end

% remove corners in margins
i = 0;
while i < size(C, 1)
    i = i+1;
    if C(i,1) == -1
        C(i,:) = [];
        i = i - 1;
    end
end

% Lucas-Kanade constraint
nc = size(C, 1); % number of suitable corners
U = zeros(nc, 1);
V = zeros(nc, 1);

% compute partial derivatives
[Ex, Ey, Et] = derivative(Im1, Im2);

for i = 1:nc
    % get derivatives of neighborhood points
    x = C(i, 1); y = C(i, 2);
    Ix = Ex(y-w:y+w, x-w:x+w)';
    Iy = Ey(y-w:y+w, x-w:x+w)';
    It = Et(y-w:y+w, x-w:x+w)';
    
    % get A, b
    Ix = Ix(:); Iy = Iy(:); It = It(:);
    A = [Ix Iy];
    b = -It;
    
    % compute U, V
    X = pinv(A) * b;
    U(i) = X(1);
    V(i) = X(2);
end