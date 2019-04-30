% https://www5.cs.fau.de/research/data/image-manipulation/
% https://www.cl.cam.ac.uk/teaching/0910/R08/work/essay-ls426-cfadetection.pdf

clear; clc;

I = imread('../resources/orig/bicycle_1.jpg');
masks = generate_color_filter_mask();

Ii1 = cfa_interpolation(rgb2cfa(I, masks{1}), 'bilinear');
Ii2 = cfa_interpolation(rgb2cfa(I, masks{2}), 'bilinear');
Ii3 = cfa_interpolation(rgb2cfa(I, masks{3}), 'bilinear');
Ii4 = cfa_interpolation(rgb2cfa(I, masks{4}), 'bilinear');

figure(1); clf;
subplot(1, 2, 1); imshow(I);
subplot(1, 2, 2); imshow(Ii1);

error = [...
    mse(I, Ii1);...
    mse(I, Ii2);...
    mse(I, Ii3);...
    mse(I, Ii4)...
    ];

norm_error = 100 * error ./ repmat(sum(error, 2), 1, 3);
feature = 100 * norm_error(:,2)/sum(norm_error(:,2));
uniformity = sum(abs(feature-25));

function error = mse(orig, reinterpolated)
    [h,w,~] = size(orig);
    error = permute(sum((double(orig) - reinterpolated).^2, [1 2])/(h*w), [3 2 1])';
end

