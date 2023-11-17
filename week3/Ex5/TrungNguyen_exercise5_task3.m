clear all;
close all;
im_dir = "C:\Users\vgtrng\Downloads\intro_image_and_video_matlab-master\intro_image_and_video_matlab-master\week3\Ex5\";
img = imread(strcat(im_dir, "miranda1.tif"));
img = double(img);

% Setup random noise
[h, w] = size(img);
noise = double(randi(30, 100, 100));
noise_im = img;
noise_im(h/2-50:h/2+49, w/2-50:w/2+49) = imadd(img(h/2-50:h/2+49, w/2-50:w/2+49), noise);
noise_im = uint8(noise_im);
imshow(noise_im);
title("noise img");

%
figure
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
    res_im = img;
    for i = 1:h-f_size
        for j = 1:w-f_size
            res_im(i,j) = median(img(i:i+f_size-1,j:j+f_size-1), "all");
        end
    end
end

function res_im = med_filter_with_threshold(img, f_size, threshold)
    %
    [h, w] = size(img);
    res_im = img;
    for i = 1:h-f_size
        for j = 1:w-f_size
            median_value = median(img(i:i+f_size-1,j:j+f_size-1), "all");
            if (abs(median_value-res_im(i,j)) <= threshold)
                res_im(i,j) = median_value;
            end
        end
    end
end