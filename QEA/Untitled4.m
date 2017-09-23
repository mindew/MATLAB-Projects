for i = 1:1:40
   [test,train] = face_detection_eigenfaces(i);
   acc = sum(test==train)./40;
end
