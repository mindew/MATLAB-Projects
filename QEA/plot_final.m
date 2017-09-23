% Finally Plotting Functions!
load face_detect.mat
load face_detect_fixed_names.mat

face_number = randi(size(faces_test_hard,3));

tic()
% returns Reduced_Train, Reduced_Test, name_train, name_test
[Reduced_Train, Reduced_Test, name_train, name_test] = face_detection_eigenfaces_reduced(face_number);
toc()

tic()
accuracy = .8250;
% accuracy for hard test set is .8250
% accuracy for easy test set is 1

% returns testname, trainname, index
[testname, trainname, index] = calculate_difference(Reduced_Train, Reduced_Test, face_number);
toc()
accuracy_rate_eigenface(Reduced_Train, Reduced_Test)


% plots!

subplot(2,2,1); 
imagesc(faces_test_hard(:,:,face_number)); colormap('gray')
xlabel(testname)
title('Right = Test Face, Left = Train Face')

subplot(2,2,2); 
imagesc(faces_train(:,:,index)); colormap('gray')
xlabel(trainname)
title(['Eigenfaces Accuracy =' num2str(accuracy)])
