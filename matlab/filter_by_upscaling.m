function [scale_space_upscaleFilter] = filter_by_upscaling(img, initial_sigma, h, w, n, k)
tic
scale_space_upscaleFilter = zeros(h, w, n);
for i = 1:n
    current_sigma = initial_sigma * (k ^ (i - 1));
    current_filter = log_filter(current_sigma);
    img_filtered = imfilter(img, current_filter, 'same', 'replicate');
    img_filtered = img_filtered .^ 2;
    scale_space_upscaleFilter(:, :, i) = img_filtered;
end
toc
end