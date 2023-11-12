clear all;
close all;
im_dir = "/home/trung/Project/Study/1st_year/2nd_sem/Intro_Image_and_Video/intro_image_and_video_matlab/week3/Ex5/";
img = imread(strcat(im_dir, "cameraman.tif"));
img = double(img);

% Setup random noise
[h, w] = size(img);
noise = double(randi(10, h, w))
noise_im = imadd(img, noise);

directional_filtering(noise_im, 3);
directional_filtering(noise_im, 5);
directional_filtering(noise_im, 7);

%
function res_im = directional_filtering(img, f_size)
    %
    figure
    
    % filter 0 degree
    f_0 = [zeros(1,f_size); ones(1,f_size); zeros(1,f_size)] / f_size
    f_img_0 = uint8(conv2(img, f_0, "same"));
    subplot(2,2,1)
    imshow(f_img_0, "InitialMagnification", "fit");
    title("0 degree filter");

    % filter 45 degree
    f_45 = rot90(eye(f_size, f_size))/f_size
    f_img_45 = uint8(conv2(img, f_45, "same"));
    subplot(2,2,2)
    imshow(f_img_45, "InitialMagnification", "fit");
    title("45 degree filter");

    % filter 90 degree
    f_90 = rot90(f_0)
    f_img_90 = uint8(conv2(img, f_90, "same"));
    subplot(2,2,3)
    imshow(f_img_90, "InitialMagnification", "fit");
    title("90 degree filter");

    % filter 135 degree
    f_135 = eye(f_size, f_size)/f_size
    f_img_135 = uint8(conv2(img, f_135, "same"));
    subplot(2,2,4)
    imshow(f_img_135, "InitialMagnification", "fit");
    title("135 degree filter");
end