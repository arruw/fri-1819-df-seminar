function f2 = extract_f2(I)

[h,w,~] = size(I);

G = double(I(:,:,2));   % extracted green color channel
Gd = wdenoise2(G,1);    % denoise
N = G - Gd;             % extract noise

% resize green color mask
mask = logical(repmat([1 0; 0 1], ceil([h/2 w/2])));
mask = mask(1:h, 1:w);

% extract green (A1) and non-green (A2) channel noise vectors
A1 = N .* mask;
A2 = N .* ~mask;

% caluclate f2 measure
vA1 = var(A1(:));
vA2 = var(A2(:)); 
f2 = max(vA1/vA2, vA2/vA1);

end