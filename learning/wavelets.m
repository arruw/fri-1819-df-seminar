I1 = imcrop(rgb2gray(imread('resources/datasets/base/1.png')), [700 500 600 600]);
I2 = imnoise(I1, 'gaussian');
I3 = wdenoise2(I2,1);
I4 = I3 - double(I2);

figure(1); clf; colormap(gray);
subplot(2,2,1); imagesc(I1); axis image; axis off; title 'Original';
subplot(2,2,2); imagesc(I2); axis image; axis off; title 'Original + Gaussian Noise';
subplot(2,2,3); imagesc(I3); axis image; axis off; title 'Denoised';
subplot(2,2,4); imagesc(I4); axis image; axis off; title 'Extracted Noise';

[cA,cH,cV,cD] = dwt2(I2, 'sym4');
figure(2); clf; colormap(gray);
subplot(2,2,1); imagesc(cA); axis image; axis off; title 'Aproximation';
subplot(2,2,2); imagesc(cH); axis image; axis off; title 'Horizontal';
subplot(2,2,3); imagesc(cV); axis image; axis off; title 'Vertical';
subplot(2,2,4); imagesc(cD); axis image; axis off; title 'Diagonal';