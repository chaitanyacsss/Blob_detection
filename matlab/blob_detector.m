function [] = blob_detector(filename, initial_sigma, n, k, threshold, filterType)

if nargin == 0
    error('No inputs given! Please run test_blob_detector to try this out.');
end

%% get the image and its dimensions
file = ['../data/', filename];
img = im2double(rgb2gray(imread(file)));
[h, w] = size(img);

%% Downsampling the image
fprintf('\nDownsampling image for LoG filter...\n');
scale_space_downscaledImages = filter_by_downsampling(img, initial_sigma, h, w, n, k);

%% increasing the filter size
fprintf('\nUpsampling filter for LoG filter...\n');
scale_space_upscaleFilter = filter_by_upscaling(img, initial_sigma, h, w, n, k);

%% dog filter
fprintf('\nDoG filter using the method in Lowe...\n');
scale_space_dog = filter_by_DoG(img, initial_sigma, h, w, n, k); 

%% Performing nonmaximum suppression in each scale
%scale_space = scale_space_downscaledImages;
%scale_space = scale_space_upscaleFilter;
%scale_space = scale_space_dog;
if (strcmp(filterType,'logdown'))
    scale_space = scale_space_downscaledImages;
elseif (strcmp(filterType,'logup'))
    scale_space = scale_space_upscaleFilter;
elseif(strcmp(filterType,'dog'))
    scale_space = scale_space_dog;
else
    error('Unknown filter type. It is be either of logdown, logup or dog.');
end
fprintf('\nScale type selected: %s\n',filterType);
fprintf('\nNonmaximum suppression within scale...\n');
maxSuppression = nonmaximum_suppression_single_scale(scale_space, h, w, n);

%% Performing nonmaximum suppression between neighbouring scales
fprintf('\nNonmaximum suppression between neighbouring scales...\n');
maxSuppression = nonmaximum_suppression_between_scales(maxSuppression, n);

%% Collecting the blob centers and radii
fprintf('\nCollecting blob centers and radii...\n');
[all_x, all_y, all_radii] = get_blobs(maxSuppression, scale_space, threshold, initial_sigma, k, n);

%% draw blobs on the image
fprintf('\nDrawing blobs...\n');
tic
show_all_circles(img, all_x, all_y, all_radii);
toc
