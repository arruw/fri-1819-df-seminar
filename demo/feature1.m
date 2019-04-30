% https://www5.cs.fau.de/research/data/image-manipulation/
% https://www.cl.cam.ac.uk/teaching/0910/R08/work/essay-ls426-cfadetection.pdf

W = 150;
eps = 0.05;

figure(1); clf; hold on;
for i = 1:100
    orig = imread("../resources/datasets/coverage/image/"+i+".tif");
    tamp = imread("../resources/datasets/coverage/image/"+i+"t.tif");

    f1 = extract_f1(orig, W, eps);
    
    plot(i, f1, 'b.', 'MarkerSize', 20);
    drawnow;
    
    f2 = extract_f1(tamp, W, eps);
    
    plot([i i], [f1 f2], '-r', 'MarkerSize', 20);
    drawnow;
    
end

xlabel("Image pair");
ylabel("F1 - CFA trace metric")

hold off;


