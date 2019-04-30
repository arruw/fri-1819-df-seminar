% orig = imread("../resources/datasets/coverage/image/1.tif");
% tamp = imread("../resources/datasets/coverage/image/1t.tif");
% 
% masks = generate_color_filter_mask();
% 
% figure(1); clf;
% imshow(orig);
% 
% dorig = uint8(wdenoise2(orig, 10));
% 
% figure(2); clf;
% imshow(dorig);