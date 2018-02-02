function [scale_space_dog] = filter_by_DoG(img, initial_sigma, h, w, n, ~)
tic
dog_filters = zeros(h, w, n);
scale_space_dog = zeros(h, w, n);
s = 5;
k = 2^(1/s);    % Sigma doubles (or image downsampled by factor of 2) up after finishing each octave

i = 1;
while i < n+1
    for inscale = 1 : s   %single scale octave loop
        current_sigma = initial_sigma * (k ^ (inscale - 1));
        current_filter = gauss_filter(current_sigma);
        img_filtered = imfilter(img, current_filter, 'same', 'replicate');
        img_filtered = img_filtered .^ 2;
        dog_filters(:, :, i) = imresize(img_filtered, [h, w]);
        i = i+1;
    end
    img = imresize(img, 1/2);  %downsampling image after every complete octave by factor 2
end

for i = 1:n-1
    scale_space_dog(:,:,i) = dog_filters(:,:,i+1) - dog_filters(:,:,i); %saving the difference of Gaussian
end
toc
end