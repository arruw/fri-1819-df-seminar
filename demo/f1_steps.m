I = imread('../resources/datasets/base/2t.jpg');

[h,w,~] = size(I);

masks = generate_color_filter_mask();

mask1 = uint8(repmat(masks{1}, h/2, w/2) * 255);
resampled1 = rgb2cfa(I, masks{1});
reinterpolated1 = cfa_interpolation(resampled1, 'bilinear');

figure(1); clf;
imshow(I);
figure(2); clf;
imshow(mask1);
figure(3); clf;
imshow(resampled1);
figure(4); clf;
imshow(reinterpolated1);
