clear all;
close all;
im_dir = "/home/trung/Project/Study/1st_year/2nd_sem/Intro_Image_and_Video/intro_image_and_video_matlab/week3/Ex5/";
img = imread(strcat(im_dir, "miranda1.tif"));
img = double(img);

% Setup random noise
[h, w] = size(img);
noise = double(randi(10, 100, 100));
noise_im = img;
noise_im(h/2-50:h/2+49, w/2-50:w/2+49) = imadd(img(h/2-50:h/2+49, w/2-50:w/2+49), noise);
noise_im = uint8(noise_im);

%
subplot(2,2,1)
imshow(med_filter(noise_im, 3));
title("med filter 3")
subplot(2,2,2)
imshow(med_filter(noise_im, 5));
title("med filter 5")
subplot(2,2,3)
imshow(med_filter(noise_im, 7));
title("med filter 7")
subplot(2,2,4)
imshow(med_filter(noise_im, 9));
title("med filter 9")

figure
subplot(1,2,1)
imshow(med_filter(noise_im, 9));
title("med filter 9")
subplot(1,2,2)
imshow(med_filter_with_threshold(noise_im, 9, 10));
title("med filter 9 with threshold 10")


% directional_filtering(noise_im, 5);
% directional_filtering(noise_im, 7);
% 

function res_im = med_filter(img, f_size)
    %
    [h, w] = size(img);
    med_block_filter = @(block_struct) ...
        median(block_struct.data,"all") * uint8(ones(size(block_struct.data)));
    res_im = blockproc(img, [f_size f_size], med_block_filter);
end

function res_im = med_filter_with_threshold(img, f_size, threshold)
    %
    [h, w] = size(img);
    med_block_filter = @(block_struct) ...
        median(block_struct.data,"all") * uint8(ones(size(block_struct.data)));
    res_im = blockproc(img, [f_size f_size], med_block_filter);
    for i = 1:h
        for j = 1:w
            if (abs(res_im(i,j)-img(i, j)) > threshold)
                res_im(i,j) = img(i,j);
            end
        end
    end
end