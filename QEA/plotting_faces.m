function accuracy = accuracy_generation_2
% Finally Plotting Functions!
% load face_detect.mat
% load face_detect_fixed_names.mat

% face_number = randi(size(faces_test_hard,3));

% returns Reduced_Train, Reduced_Test, name_train, name_test
% [Reduced_Train, Reduced_Test, name_train, name_test] = face_detection_eigenfaces_reduced(face_number);

% returns testname, trainname, index
% [testname, trainname, index] = calculate_difference(Reduced_Train, Reduced_Test, face_number);

% returns accuracy

correct = ones(40,40);

for i = 1:40
    face_number = 1:40;
    [Reduced_Train, Reduced_Test, name_train, name_test] = face_detection_eigenfaces_reduced(face_number);
    [testname, trainname, index] = calculate_difference(Reduced_Train, Reduced_Test, face_number);
    correct(i,:) = accuracy_generation(testname, trainname);
end

accuracy = sum(correct)/40;

end
