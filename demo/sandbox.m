I = double(imread('../resources/datasets/base/1t.png'));

W = 96;

fun = @(block) extract_feature2(block.data, [0 1;1 0], 4);
f2_map = blockproc(double(I(:,:,2)), [W/2 W/2], fun, ...
        'BorderSize',[W/2 W/2],...
    'TrimBorder', false,...
    'PadPartialBlocks',true,...
    'PadMethod',0,...
    'UseParallel',true,...
    'DisplayWaitbar',true);

f2_map = f2_map.^(-1);
f2_map = f2_map .* (f2_map > 0.9);

figure(1); clf; 
imagesc(f2_map);  colormap(gray); colorbar();

function f2 = extract_feature2(block, mask, level)
    [h,w] = size(block);
    mask = logical(repmat(mask, [h/2 w/2]));
    
%     [c1,s1] = wavedec2((block .* mask),level,'haar');
%     [c2,s2] = wavedec2((block .* ~mask),level,'haar');
%     [H1,V1,D1] = detcoef2('all', c1,s1,level);
%     [H2,V2,D2] = detcoef2('all', c2,s2,level);
%     
%     vA1 = var(D1(:));
%     vA2 = var(D2(:));
% 
%     f2 = max(vA1/vA2, vA2/vA1);

    Gwt = dddtree2('ddt',(block .* mask),level,'filters2');
    Nwt = dddtree2('ddt',(block .* ~mask),level,'filters2');
    
    HH1 = Gwt.cfs{1}(:,:,5);
    HH2 = Nwt.cfs{1}(:,:,5);
    
    vA1 = var(HH1(:));
    vA2 = var(HH2(:));

    f2 = max(vA1/vA2, vA2/vA1);
end