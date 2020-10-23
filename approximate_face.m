function [] = approximate_face( d, r, test_images, ui_all)
    dir_name = strcat('approximate_face_d=', num2str(d)');
    if  ~exist(dir_name,'dir') == 0
        rmdir(dir_name, 's')
    end
    [status, msg, msgID] = mkdir(dir_name);
    for i = 1 : d
        ui(:, i) = ui_all(:, i);
    end
%     r = randi([1 13],1,99);
    for i = 1 : 99
        select(i) = 13 * (i - 1) + r(i);
        test = test_images(:, select(i));
        compare = figure(2);
        subplot(1, 2, 1);
        imshow(reshape(test, 165, 120));
        ai = test' * ui;       % 1*d
        M = sum(ui*ai', 2);
        subplot(1, 2, 2);
        imshow(reshape(M, 165, 120));
        saveas(compare, strcat('approximate_face_d=', num2str(d), '\Person-', num2str(i), '-', num2str(13+r(i)), '.bmp'), 'bmp')
    end
end