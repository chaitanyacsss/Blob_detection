function test_blob_detector()
%% place the file in ../data directory and enter the name here.

%% INPUTS: [filename (from ../data folder), initial_sigma (standard deviation for initial_scale), n (number of levels),
%% k (scale multiplication factor), threshold, filterType = {'logdown', 'logup', 'dog'}]
blob_detector('mnist_img_1.png', 2, 5, 1.4, 0.01, 'logdown');
end