clear all;
close all;

% im = imread(strcat(dir,"c_1.jpg"));

% im = Process(im);
% imshow(im);

% function im_batch = Ex1_batch()
Ex1_batch_func();
% end

function Ex1_batch_func()
    im_dir = "/home/trung/Project/Study/1st_year/2nd_sem/Intro_Image_and_Video/intro_image_and_video_matlab/week1/Ex1/";
    list_im = dir(strcat(im_dir,"*.jpg"));
    % for loop only works with row vector so tranpose the list is neccessary
    for im_info = list_im'
        nexttile
        im = Process(imread(strcat(im_dir, im_info.name)));
        imshow(im);
        imwrite(im, strcat(im_dir, strrep(im_info.name,".jpg",".bmp")),"bmp");
    end
end

function im = Process(im)
    im = imresize(im, 0.75);
    im(:, 1:end/2, :) = fliplr(im(:, end/2+1:end, :));
    im = imrotate(im, 90);
    % im(:, end/2+1:end, :) = rotated();
    % im(:,1:end/2,:) = half_left;
end





