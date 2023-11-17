close all;
clear all;
imdir = "/home/trung/Project/Study/1st_year/2nd_sem/Intro_Image_and_Video/intro_image_and_video_matlab/week4/Ex7/";
img = imread(strcat(imdir,"lena.jpg"));
[h, w] = size(img);

% 1
figure
subplot(2,2,1)
imshow(img);
title("org img");

subplot(2,2,2)
gaus_noise_img = imnoise(img, "gaussian", 0.0, 0.015);
imshow(gaus_noise_img);
title("gaussian noise img");

subplot(2,2,3)
sape_noise_img = imnoise(img, "salt & pepper", 0.075);
imshow(sape_noise_img);
title("salt pepper noise img");

subplot(2,2,4)
b = 3600;
rale_noise = uint8(sqrt(-b*log((1-rand(h,w)))));
rale_noise_img = imadd(img, rale_noise);
imshow(rale_noise_img);
title("rayleigh noise img");

% histogram(rale_noise(:)');

% 2
figure
subplot(2,2,1)
imshow(gaus_noise_img);
title("gaussian noise img");

subplot(2,2,2)
amf_gaus_img = imfilter(gaus_noise_img, fspecial('average',[5 5]));
imshow(amf_gaus_img);
title("gaus noise arth-mean filter");

subplot(2,2,3)
gmf_gaus_img = uint8(exp(imfilter(log(double(gaus_noise_img)),ones(5,5),'replicate')).^(1/(5*5)));
imshow(gmf_gaus_img);
title("gaus noise geom-mean filter");

subplot(2,2,4)
haf_gaus_img = uint8((5*5)./imfilter(1./(double(gaus_noise_img) + eps), ones(5, 5), 'replicate'));
imshow(haf_gaus_img);
title("gaus noise harm-mean filter");


figure
subplot(2,2,1)
imshow(sape_noise_img);
title("salt pepper noise img");

subplot(2,2,2)
amf_sape_img = imfilter(sape_noise_img, fspecial('average',[5 5]));
imshow(amf_sape_img);
title("sape noise arth-mean filter");

subplot(2,2,3)
gmf_sape_img = uint8(exp(imfilter(log(double(sape_noise_img)),ones(5,5),'replicate')).^(1/(5*5)));
imshow(gmf_sape_img);
title("sape noise geom-mean filter");

subplot(2,2,4)
haf_sape_img = uint8((5*5)./imfilter(1./(double(sape_noise_img) + eps), ones(5, 5), 'replicate'));
imshow(haf_sape_img);
title("sape noise harm-mean filter");


figure
subplot(2,2,1)
imshow(rale_noise_img);
title("rayleigh noise img");

subplot(2,2,2)
amf_rale_img = imfilter(rale_noise_img, fspecial('average',[5 5]));
imshow(amf_rale_img);
title("rale noise arth-mean filter");

subplot(2,2,3)
gmf_rale_img = uint8(exp(imfilter(log(double(rale_noise_img)),ones(5,5),'replicate')).^(1/(5*5)));
imshow(gmf_rale_img);
title("rale noise geom-mean filter");

subplot(2,2,4)
haf_rale_img = uint8((5*5)./imfilter(1./(double(rale_noise_img) + eps), ones(5, 5), 'replicate'));
imshow(haf_rale_img);
title("rale noise harm-mean filter");

% 3
figure
subplot(2,2,1)
imshow(img);
title("org img");

subplot(2,2,2)
sape_noise_img = imnoise(img, "salt & pepper", 0.02);
imshow(sape_noise_img);
title("salt pepper noise img");

subplot(2,2,3)
med_filter_img = med_filter(sape_noise_img, 5);
imshow(med_filter_img);
title("median filter img");

subplot(2,2,4)
wei_med_filter_img = wei_med_filter(sape_noise_img, 5);
imshow(wei_med_filter_img);
title("weight median filter img");

function res_im = med_filter(img, f_size)
    [h, w] = size(img);
    res_im = img;
    half_size = int32(f_size / 2);
    for i = 1+half_size:h-half_size
        for j = 1+half_size:w-half_size
            res_im(i,j) = median(img(i-half_size:i+half_size,j-half_size:j+half_size), "all");
        end
    end
end

function res_im = wei_med_filter(img, f_size)
    [h, w] = size(img);
    res_im = img;
    half_size = int32(f_size / 2)-1;
    for i = 1+half_size:h-half_size
        for j = 1+half_size:w-half_size
            values = img(i-half_size:i+half_size,j-half_size:j+half_size);
            values = [values(:)', ones(1, 4)*double(img(i,j))]
            median_value = median(values);
            res_im(i,j) = uint8(median_value);
        end
    end
end


