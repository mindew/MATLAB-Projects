function accuracy_percentage = accuracy_rate_eigenface(reduced_train, reduce_test)
    load face_detect_fixed_names.mat
    
    acc = zeros(size(1,size(names_test_hard, 2)));
    
    for i = 1:size(names_test_hard, 2)
        face_number = i;
       [trname, tename, index] = calculate_difference(reduced_train,reduce_test,face_number);
       if trname == tename
           acc(:,i) = 1;
       else
           acc(:,i) = 0;
       end
    end
  
     accuracy_percentage = sum(acc)/40;
 
end    