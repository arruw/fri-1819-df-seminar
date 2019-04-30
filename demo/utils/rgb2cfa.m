function cfa = rgb2cfa(I,mask)
% Filters RGB image with selected CFA filter mask (2*2)
% INPUTS
% I - Original RGB images
% mask - CFA filter mask (2*2)
% OUTPUTS
% cfa - color filter array

    [h,w,~] = size(I);
    mask = repmat(mask, h/2, w/2);
    cfa = im2double(I) .* mask;
end

