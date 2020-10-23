clc;
clear;
close all;

fprintf('Loading images......\n');
training_file = dir(['dataset\training\*.bmp'] );
num_train = length(training_file);
for i = 1 : num_train
    img = imread(['dataset\training\', training_file(i).name]);
    train_images(:, i) = double(reshape(img, 165*120, 1)) / 255;
end
test_file = dir(['dataset\test\*.bmp'] );
num_test = length(test_file);
for i = 1 : num_test
    img2 = imread(['dataset\test\', test_file(i).name]);
    test_images(:, i) = double(reshape(img2, 165*120, 1)) / 255;
end
fprintf('Finished\n');
fprintf('Saving image data......\n');
save('image_data.mat','train_images', 'test_images');
fprintf('Finished\n');


fprintf('Processing covarian matrix......\n');
mean_face_1d = sum(train_images, 2) / num_train;
mean_face_2d = reshape(mean_face_1d, 165, 120);
matrix_A = train_images - mean_face_1d;     % matrix_A size 19800*1287
covarian_matrix = (matrix_A * matrix_A') / (num_train - 1);     % covarian_matrix size 19800*19800(19800*1287x1287*19800)
fprintf('Finished\n');

% processing eig() and save values to eigen.mat
fprintf('Processing eig(covarian_matrix)......\n');
[eigen_vector, eigen_value]  = eig(covarian_matrix');     % 19800*19800 size eigenvector
fprintf('Finished\n');
fprintf('Saving eigen data......\n');
eigen_value = diag(eigen_value);
save('eigen.mat','eigen_vector', 'eigen_value', '-v7.3');
fprintf('Finished\n');
