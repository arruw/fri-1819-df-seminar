base_dir = "/home/matjazmav/Downloads/MICC-F220";
auth = dir(base_dir+"/*scale.jpg");
temp = dir(base_dir+"/*tamp*.jpg");

figure(1); clf; hold on;

j = 1;

for i = 1:length(auth)
    I = imread(fullfile(auth(i).folder, auth(i).name));
    f2 = extract_f2(I);
    
    plot(j, f2, 'b.','MarkerSize',20);
    drawnow;
    
    j = j+1;
end

for i = 1:length(temp)
    I = imread(fullfile(temp(i).folder, temp(i).name));
    f2 = extract_f2(I);
    
    plot(j, f2, 'rx','MarkerSize',20);
    drawnow;
    
    j = j+1;
end

xlabel("Image");
ylabel("F2 measure")

hold off;