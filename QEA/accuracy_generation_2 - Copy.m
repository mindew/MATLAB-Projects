function accuracy = accuracy_generation_2
load face_detect_fixed_names.mat
% returns accuracy

for i = 1:length(names_test_easy)
    face_number = i;
    [Reduced_Train, Reduced_Test, name_train, name_test] = face_detection_eigenfaces_reduced(face_number);
    [testname, trainname, index] = calculate_difference(Reduced_Train, Reduced_Test, face_number);
    accuracy(i) = accuracy_generation(testname, trainname);
end

 accuracy = sum(accuracy)/40;

end


