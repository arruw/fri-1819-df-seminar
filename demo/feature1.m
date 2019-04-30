% https://www5.cs.fau.de/research/data/image-manipulation/
% https://www.cl.cam.ac.uk/teaching/0910/R08/work/essay-ls426-cfadetection.pdf

base_path = "../resources/datasets/base/";
W = 150;
eps = 0.05;

figure(1); clf; hold on;
for i = 1:length(dir(base_path))-2
    f = dir(base_path+i+".*");
    ft = dir(base_path+i+"t.*");
    
    o = imread(fullfile(f.folder, f.name));
    t = imread(fullfile(ft.folder, ft.name));

    f1 = extract_f1(o, W, eps);
    
    plot(i, f1, 'b.', 'MarkerSize', 20);
    drawnow;
    
    f2 = extract_f1(t, W, eps);
    
    plot([i i], [f1 f2], '-r', 'MarkerSize', 20);
    drawnow;
    
end

xlabel("Image pair");
ylabel("F1 - CFA trace metric")

hold off;


