function [scale_space_downscaledImages] = filter_by_downsampling(img, sigma, h, w, n, k)
tic
scale_space_downscaledImages = zeros(h, w, n);
filter = log_filter(sigma);

for i = 1:n
    downscaled_image = imresize(img, 1 / (k ^ (i - 1)));
    img_filtered = imfilter(downscaled_image, filter, 'same', 'replicate');
    img_filtered = img_filtered .^ 2;
    img_rescaled = imresize(img_filtered, [h, w]);
    scale_space_downscaledImages(:, :, i) = img_rescaled;
end
toc
end