clear all;
close all;

% a
im_dir = "/home/trung/Project/Study/1st_year/2nd_sem/Intro_Image_and_Video/intro_image_and_video_matlab/week1/Ex2/";
im = imread(strcat(im_dir, "lena_face.png"));
% nexttile
% imshow(im);
[h,w] = size(im);
flat_im = reshape(im, 1, h*w);

% b
steps = [2 4 8 16 32 64];
for step = steps
    partition = step:step:256-step;
    codebook = step/2:step:256-step/2;
    [index, res_im] = quantiz(flat_im, partition, codebook);
    nexttile
    res_im = uint8(reshape(res_im, [h, w]));
    imshow(res_im);
end

% c
random_value = [0 10 -10];
random_pos = randi(length(random_value), h, w);
noise = int32(random_value(random_pos));
noise_im = uint8(imadd(int32(im), noise));
step = 16;
partition = step:step:256-step;
codebook = step/2:step:256-step/2;
[index, quant_im_with_noise] = quantiz(flat_im, partition, codebook);
nexttile
quant_im_with_noise = uint8(reshape(quant_im_with_noise, [h, w]));
imshow(quant_im_with_noise);