function [maxSuppression] = nonmaximum_suppression_single_scale(scale_space, h, w, n)
tic
maxSuppression = zeros(h, w, n);
block_size = 3;
for i = 1:n
    %maxSuppression(:,:,i) =  colfilt(scale_space(:,:,i), [block_size block_size],'sliding',@max);
    maxSuppression(:, :, i) = ordfilt2(scale_space(:, :, i), block_size ^ 2, ones(block_size));
end
toc

end