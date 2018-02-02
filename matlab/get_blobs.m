function [all_x, all_y, all_radii] = get_blobs(maxSuppression, scale_space, threshold, initial_sigma, k, n)

tic
all_x = [];
all_y = [];
all_radii = [];
for i = 1:n
    maxSuppValues = maxSuppression(:, :, i);
    maxSuppValues = ((maxSuppValues == scale_space(:, :, i)) & (maxSuppValues > threshold));
    [y, x] = find(maxSuppValues);
    radius = initial_sigma * (k ^ (i - 1)) * sqrt(2); % from formula
    current_radii = (ones(length(y), 1) .* radius);
    all_x = [all_x; x];
    all_y = [all_y; y];
    all_radii = [all_radii; current_radii];
end
toc

end