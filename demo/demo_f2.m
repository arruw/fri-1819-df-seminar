I = imread('../resources/datasets/ours/snote3_1t.jpg');

W = 96;     % sliding window size
S = 6;      % sliding window step W/S
T = 0.8;    % trashold

[h,w,~] = size(I);

G = double(I(:,:,2));   % extracted green color channel
Gd = wdenoise2(G,1);    % denoise
N = G - Gd;             % extract noise

fun = @(block) extract_feature2(block, [0 1;1 0]);
f2_map = blockproc(N, [W/S W/S], fun, ...
    'BorderSize',[2*W/S 2*W/S],...
    'TrimBorder', false,...
    'PadPartialBlocks',true,...
    'PadMethod',0,...
    'UseParallel',true,...
    'DisplayWaitbar',true);

f2_map = imresize(f2_map.^(-1), [h w]);

figure(1); clf; 
subplot(1,2,1); imagesc(f2_map); colormap(gray); colorbar(); axis image; axis off;
subplot(1,2,2); imshow(I);
hold on;
trashold(f2_map, T);
hold off;
drawnow;

function f2 = extract_feature2(data, mask)
    block = data.data;

    % resize green color mask
    [h,w] = size(block);
    mask = logical(repmat(mask, [h/2 w/2]));
    
    % extract green (A1) and non-green (A2) vectors
    A1 = block .* mask;
    A2 = block .* ~mask;
    
    % caluclate f2 measure
    vA1 = var(A1(:));
    vA2 = var(A2(:)); 
    f2 = max(vA1/vA2, vA2/vA1);
end

function trashold(f2_map, T)
    plot_trashold(f2_map, T);
    uicontrol('Style','text',...
        'String','Treshold: ',...
        'Position',[5 5 100 20]);
    uicontrol('Style','edit',...
        'String',  T,...
        'Value', T,...
        'Position',[110 5 100 20],...
        'Callback', {@trackold_callbacl, f2_map});
end

function trackold_callbacl(src, evt, f2_map)
    h = findobj('type','line');
    delete(h);

    T = str2double(src.String);
    src.Value = T;
    
    hold on;
    plot_trashold(f2_map, T);
    hold off;
    drawnow;
end

function handles = plot_trashold(f2_map, T)
    f2_map_mask = f2_map >= T;
    
    boundaries = bwboundaries(f2_map_mask,8,'noholes');
    handles = cell(length(boundaries),1);
    
    for i = 1:length(boundaries)
        boundary = boundaries{i};
        handles{i} = plot(boundary(:,2), boundary(:,1), 'y-', 'LineWidth', 2);
    end
    
end