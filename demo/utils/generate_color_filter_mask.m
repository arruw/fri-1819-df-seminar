function mask = generate_color_filter_mask()
% Generates 4 commonly used color filter masks
% OUTPUTS
% mask - cell array of 4 commonly used color filter masks

    mask = cell(1,4);
    mask{1} =        [0 1; 0 0];
    mask{1}(:,:,2) = [1 0; 0 1];
    mask{1}(:,:,3) = [0 0; 1 0];

    mask{2} =        [0 0; 1 0];
    mask{2}(:,:,2) = [1 0; 0 1];
    mask{2}(:,:,3) = [0 1; 0 0];

    mask{3} =        [1 0; 0 0];
    mask{3}(:,:,2) = [0 1; 1 0];
    mask{3}(:,:,3) = [0 0; 0 1];

    mask{4} =        [0 0; 0 1];
    mask{4}(:,:,2) = [0 1; 1 0];
    mask{4}(:,:,3) = [1 0; 0 0];
    
    mask{1} = logical(mask{1});
    mask{2} = logical(mask{2});
    mask{3} = logical(mask{3});
    mask{4} = logical(mask{4});
end

