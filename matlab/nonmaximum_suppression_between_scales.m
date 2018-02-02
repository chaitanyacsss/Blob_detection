function [maxSuppression] = nonmaximum_suppression_between_scales(maxSuppression, n)

tic
for i = 1:n
    if i == 1
        maxSuppression(:, :, i) = max(maxSuppression(:, :, i:i + 1), [], 3);
    elseif i == n
        maxSuppression(:, :, i) = max(maxSuppression(:, :, i - 1:i), [], 3);
    else
        maxSuppression(:, :, i) = max(maxSuppression(:, :, i - 1:i + 1), [], 3);
    end
end
toc

end