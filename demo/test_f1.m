auth = dir("/home/matjazmav/Downloads/personal_columbia_downsized_jpeg/auth_jpeg_images_experiment/*.jpg");
temp = dir("/home/matjazmav/Downloads/columbia-prcg-datasets/prcg_images/*.jpg");

figure(1); clf; hold on;

j = 1;
W = 96;
eps = 0.05;

for i = 1:length(auth)
    I = imread(fullfile(auth(i).folder, auth(i).name));
    f1 = extract_f1(I, W, eps);
    
    plot(j, f1, 'b.');
    drawnow;
    
    j = j+1;
end

for i = 1:length(temp)
    I = imread(fullfile(temp(i).folder, temp(i).name));
    f1 = extract_f1(I, W, eps);
    
    plot(j, f1, 'rx');
    drawnow;
    
    j = j+1;
end

xlabel("Image");
ylabel("F1 measure")

hold off;