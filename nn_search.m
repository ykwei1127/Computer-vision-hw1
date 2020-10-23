function [] = nn_search(train_images, test_images, d, n)
%     fprintf('Loading eigenfaces......\n');
    eigenfaces = load('eigenfaces.mat');
%     fprintf('Finished\n');
%     fprintf('Nearest neighbor search......\n');
    d_eigenfaces = eigenfaces.eigenfaces;
    for i = 1 : d
        eigenvectors(:, i) = reshape(d_eigenfaces{i}, 165*120, 1);
    end
    proj_train = train_images' * eigenvectors;
    proj_test = test_images' * eigenvectors;
    error_sad = 0;
    error_ssd = 0;
    for i = 1 : n
        min_sad = inf;
        min_ssd = inf;
        for j = 1 : n
            sad = sum(abs(proj_test(i, :) - proj_train(j, :)));
            ssd = sum((proj_test(i, :) - proj_train(j, :)).^2);
            if sad <min_sad
                min_sad = sad;
                label1 = j;
            end
            if ssd < min_ssd
               min_ssd = ssd;
               label2 = j;
            end
        end
        if ceil(label1 / 13) ~= ceil(i / 13)
            error_sad = error_sad + 1;
        end
        if ceil(label2 / 13) ~= ceil(i / 13)
            error_ssd = error_ssd + 1;
        end
    end
%     fprintf('Finished\n');
    fprintf('d=%d,  nn SAD error rate: %f\n',d, error_sad/n);
    fprintf('           nn SSD error rate: %f\n', error_ssd/n);
end