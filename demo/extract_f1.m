function [f1,f1s] = extract_f1(I, W, eps)
% INPUTS
% I - RGB image
% W - size of each block to process
% eps - smoothness treshold
% OUTPUTS
% f1 - F1 score
% f1s - uniformitiy for each block

    fun = @(block) extract_feature1(block.data, generate_color_filter_mask, W, eps);
    
    f1s = reshape(blockproc(I, [W W], fun, ...
        'PadPartialBlocks',true,...
        'PadMethod',0,...
        'UseParallel',true,...
        'DisplayWaitbar',true), [], 1);

    f1s(f1s == 0) = [];     % remove smooth measures
    f1 = median(f1s);

    
end

function f1 = extract_feature1(Bi, masks, W, eps)
    f1 = 0;
    if is_smooth(Bi, W, eps)
        return;
    end

    Bi1 = cfa_interpolation(rgb2cfa(Bi, masks{1}), 'bilinear');
    Bi2 = cfa_interpolation(rgb2cfa(Bi, masks{2}), 'bilinear');
    Bi3 = cfa_interpolation(rgb2cfa(Bi, masks{3}), 'bilinear');
    Bi4 = cfa_interpolation(rgb2cfa(Bi, masks{4}), 'bilinear');
    
    error = [...
        mse(Bi, Bi1);...
        mse(Bi, Bi2);...
        mse(Bi, Bi3);...
        mse(Bi, Bi4)...
        ];
    norm_error = 100 * error ./ repmat(sum(error, 2), 1, 3);
    feature = 100 * norm_error(:,2)/sum(norm_error(:,2));
    f1 = sum(abs(feature-25));
end

function error = mse(orig, reinterpolated)
    [h,w,~] = size(orig);
    error = permute(sum((double(orig) - reinterpolated).^2, [1 2])/(h*w), [3 2 1])';
end

function x = is_smooth(Bi, W, eps)
    edges = double(rangefilt(rgb2gray(Bi)));
    edges = edges / max(max(edges));
    
    smoothness = sum(edges, 'all') / W^2;
    % smoothness [0 ... 1]
    % 0 ... smooth
    % 1 ... not smooth
    
    x = logical(smoothness <= eps);
end
