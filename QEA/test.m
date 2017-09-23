function test_images_reshape = test(original_image) 
test_images_reshape = reshape(original_image, [size(original_image,1)*size(original_image,2),size(original_image,3)]);
end

vectorized_images = test(test_images);
o = ones(size(vectorized_images,1),1);
% m = o * mean(vectorized_images);
% Covariance = 1/sqrt((size(vectorized_images,1)))*(vectorized_images-m);

