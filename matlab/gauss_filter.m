function [filter] = gauss_filter(sigma)

% hsize should be odd so that the filter can be centered on a pixel
% Based on the default values ( hsize = 5 and sigma = 0.5 ) and that the hsize should be odd, we take this relation
hsize = 2 * ceil(3*sigma) + 1;
filter = fspecial('gaussian', hsize, sigma);
%filter = (sigma) * filter;  % normalizing the filter

end