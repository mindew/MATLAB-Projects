function [name_train, name_test] = accuracyforfisher(face_number)
load face_detect.mat
load face_detect_fixed_names.mat

%vectorizing the data
reshaped_data = (reshape(faces_train, [size(faces_train,1)*size(faces_train,2),size(faces_train,3)]))';

%making the data mean-centered (similar to covariance matrix)
mean_centered_data = mean_centered(reshaped_data);

%going to remove all eigenvectors after num
num = 50;

%using singular value decomposition in order to find the largest eigenvalues and their corresponding eigenvectors
[U, S, V] = svd(reshaped_data, 'econ');

%pca; getting rid of the smallest eigenvectors
principal_eigenvectors = V(:,3:num);    %remove largest three eigenvectors because those are usually lighting differences

%projecting the face data onto a line
projection = (reshaped_data * principal_eigenvectors)';
train_projection = (reshaped_data*principal_eigenvectors)';

%finding the indices of the 'start' of each persons' picture set by using the names matrix
class_indices = [];
class_indices(1) = 1;
index = 2;
for j = 2:size(names_train, 2) - 1
    if names_train(:,j) == names_train(:, j + 1)
    else
        class_indices(1, index) = j + 1;
        index = index + 1;
    end
end

%scatter matrices
Sw = zeros(size(projection, 1), size(projection, 1));
Sb = zeros(size(projection, 1), size(projection, 1));

%making the class set based on the indices and the projections
for i = 1:size(class_indices, 2)
    class_begin = class_indices(i);
    if i == size(class_indices, 2)
        class_end = size(names_train, 2);
    else
        class_end = class_indices(i + 1) - 1;
    end
    classed_images = projection(:,class_begin:class_end);
    
    %finding the scatter matrix within classes
    mean_centered_classed_images = mean_centered(classed_images);
    Sw = Sw + mean_centered_classed_images*mean_centered_classed_images';
    %finding the scatter matrix between classes
    mean_centered_images = mean(projection, 2) - mean(classed_images, 2);
    Sb = Sb + size(classed_images, 2) * mean_centered_images * mean_centered_images';
end

%this finds the largest variation between the classes and the smallest variation within the classes
[V, D] = eig(Sb, Sw);
[sort_num, index] = sort(diag(D), 'descend');
V = V(:,index);

%the optimal W value in order to get largest between-class variation and smallest within-class variation
optimalW = principal_eigenvectors*V;

%creation of the fisherfaces
fisherface = reshaped_data*optimalW;