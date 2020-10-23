clc;
clear;

fprintf('Loading image data......\n');
image_data = load('image_data.mat');
train_images = image_data.train_images;
test_images = image_data.test_images;
fprintf('Finished\n\n');
[pixels, num_test] = size(test_images);
nn_search(train_images, test_images, 1, num_test);
nn_search(train_images, test_images, 5, num_test);
nn_search(train_images, test_images, 9, num_test);
