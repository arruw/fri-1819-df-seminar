function I = cfa_interpolation(cfa, type)

Rh = cfa(:,:,1);
Gh = cfa(:,:,2);
Bh = cfa(:,:,3);
switch type
    case 'neighbor' % nearest neighbor interpolation
        R = Rh(floor([0:end-1]/2)*2+1,floor([0:end-1]/2)*2+1);
        G = zeros(size(Gh));
        G(floor([0:end-1]/2)*2+1,:) = Gh(floor([0:end-1]/2)*2+1,floor([0:end-1]/2)*2+2);
        G(floor([0:end-1]/2)*2+2,:) = Gh(floor([0:end-1]/2)*2+2,floor([0:end-1]/2)*2+1);
        B = Bh(floor([0:end-1]/2)*2+2,floor([0:end-1]/2)*2+2);
    case 'bilinear' % bilinear interpolation
        R = conv2(Rh,[1 2 1;2 4 2;1 2 1]/4,'same');
        G = conv2(Gh,[0 1 0;1 4 1;0 1 0]/4,'same');
        B = conv2(Bh,[1 2 1;2 4 2;1 2 1]/4,'same');
    case 'smooth_hue' % smooth hue transition interpolation
        G = conv2(Gh,[0 1 0;1 4 1;0 1 0]/4,'same') ;
        R = G.*conv2(Rh./G,[1 2 1;2 4 2;1 2 1]/4,'same') ;
        B = G.*conv2(Bh./G,[1 2 1;2 4 2;1 2 1]/4,'same') ;
    case 'median' % median-filtered bilinear interpolation
        R = conv2(Rh,[1 2 1;2 4 2;1 2 1]/4,'same') ;
        G = conv2(Gh,[0 1 0;1 4 1;0 1 0]/4,'same') ;
        B = conv2(Bh,[1 2 1;2 4 2;1 2 1]/4,'same') ;
        Mrg = R-G;
        Mrb = R-B;
        Mgb = G-B;
        R = S+Mrg.*Gcfa+Mrb.*Bcfa ;
        G = S-Mrg.*Rcfa+Mgb.*Bcfa ;
        B = S-Mrb.*Rcfa-Mgb.*Gcfa ;
    case 'gradient' % gradient-based interpolation
        H = abs((S(:,[1 1 1:end-2])+S(:,[3:end end end]))/2-S);
        V = abs((S([1 1 1:end-2],:)+S([3:end end end],:))/2-S);
        G = Gh+(Rcfa+Bcfa).*((H<V).*((Gh(:,[1 1:end-1])+Gh(:,[2:end end]))/2)+(H>V).*((Gh([1 1:end-1],:)+Gh([2:end end],:))/2)+(H==V).*((Gh(:,[1 1:end-1])+Gh(:,[2:end end])+Gh([1 1:end-1],:)+Gh([2:end end],:))/4)) ;
        R = G+conv2(Rh-Rcfa.*G,[1 2 1;2 4 2;1 2 1]/4,'same');
        B = G+conv2(Bh-Bcfa.*G,[1 2 1;2 4 2;1 2 1]/4,'same');
end

I(:,:,1)=R;
I(:,:,2)=G;
I(:,:,3)=B;

end

