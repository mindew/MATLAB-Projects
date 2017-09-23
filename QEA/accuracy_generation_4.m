function accuracy = accuracy_generation_4
load face_detect_fixed_names.mat
% returns accuracy

for i = 1:length(names_test_hard)
    face_number = i;
    [trainname,testname] = accuracyforfisher(i);
    accuracy(i) = accuracy_generation(testname, trainname);
end

 accuracy = sum(accuracy)/40;

end
