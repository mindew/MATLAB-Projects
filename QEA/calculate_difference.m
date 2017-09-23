function [name_test, name_train, index] = calculate_difference(Reduced_Train, Reduced_Test, face_number)
load face_compress.mat
load face_detect_fixed_names.mat

% Calculate the difference between weights of training / test
w_test = repmat(Reduced_Test,1,size(Reduced_Train,2));
difference = w_test - Reduced_Train;
distances = (sum(difference.^2)).^1.5;

% find the minimum distance
minDis = min(distances);

% find the index of the minimum distance value
index = find(distances==minDis,1); 

% find names corresponding to the images
name_train = names_train(:,index)';
name_test = names_test_hard(:,face_number)';

end

