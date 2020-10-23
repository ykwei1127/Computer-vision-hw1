clc;
clear;
close all;

fprintf('Loading image data......\n');
image_data = load('image_data.mat');
train_images = image_data.train_images;
test_images = image_data.test_images;
fprintf('Finished\n');

% Load eigen vectors and values from file.mat
fprintf('Loading eigen vectors and values......\n');
eigen = load('eigen.mat');
fprintf('Finished\n');
eigen_vector = eigen.eigen_vector;
eigen_value = eigen.eigen_value;
[value,index] = sort(eigen_value, 'descend');
faces = figure(1);
for i = 1 : 9
    eigenfaces{i} = eigen_vector(:, index(i));
    ui(:, i) = eigen_vector(:,index(i));
    eigenfaces{i} = reshape(eigenfaces{i}, 165, 120);
    subplot(3,3,i);
    imshow(mat2gray(eigenfaces{i}));
    title(strcat('d=', num2str(i)));
end
saveas(faces, '9-eigenfaces.bmp', 'bmp')
fprintf('Saving d-eigenfaces......\n');
save('eigenfaces.mat','eigenfaces');
fprintf('Finished\n');

fprintf('Approximating faces......\n');
r = randi([1 13],1,99);
approximate_face(1, r, test_images, ui);
approximate_face(5, r, test_images, ui);
approximate_face(9, r, test_images, ui);
fprintf('Finished\n');
close all;