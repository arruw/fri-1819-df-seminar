base_dir = "/home/matjazmav/Downloads/MICC-F220";
auth = dir(base_dir+"/*scale.jpg");
temp = dir(base_dir+"/*tamp*.jpg");

figure(1); clf; hold on;

j = 1;
W = 96;
eps = 0.05;

for i = 1:length(auth)
    I = imread(fullfile(auth(i).folder, auth(i).name));
    f1 = extract_f1(I, W, eps);
    
    plot(j, f1, 'b.','MarkerSize',20);
    drawnow;
    
    j = j+1;
end

for i = 1:length(temp)
    I = imread(fullfile(temp(i).folder, temp(i).name));
    f1 = extract_f1(I, W, eps);
    
    plot(j, f1, 'rx','MarkerSize',20);
    drawnow;
    
    j = j+1;
end

xlabel("Image");
ylabel("F1 measure")

hold off;