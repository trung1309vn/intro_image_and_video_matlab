close all;
clear all;
img = imread("fruits.jpg");
img_2 = imread("festia.jpg");
subplot(2,3,1)
imshow(img)
title("org img")
subplot(2,3,4)
imshow(img_2)
title("org img_2")

% 1a, 1b, 1c
heq_img = histeq(img);
subplot(2,3,2)
imshow(heq_img)
title("histeq img")

hsveq_img = intensityeq(img);
subplot(2,3,3)
imshow(hsveq_img)
title("hsv equal img")

heq_img_2 = histeq(img_2);
subplot(2,3,5)
imshow(heq_img_2)
title("histeq img_2")

hsveq_img_2 = intensityeq(img_2);
subplot(2,3,6)
imshow(hsveq_img_2)
title("hsv equal img_2")

% histeq use intensity (I) channel to equal while intensityeq use value (V) channel
% I is the mean(R,G,B) and V is max(R,G,B) => when equalize, the one with V
% try to stretch the histogram more to the dark side => lead to the effect

% 2
figure
img = imread("lake.jpg");
subplot(1,2,1)
imshow(img)
title("org img")
gray_img = rgb2gray(img);            % convert to hsv
thresh = graythresh(gray_img);
mask_img = bwlabel(~imbinarize(gray_img,thresh), 4);
mode_value = mode(mask_img(mask_img~=0),"all");
mask_img = mask_img==mode_value;
mask_img = uint8(mask_img);
img = img.*mask_img;
subplot(1,2,2)
imshow(img)
title("segmented img")

% 1b -function
function res_img = intensityeq(img)
    hsv_img = rgb2hsv(img);
    v_channel = hsv_img(:,:,3);
    eqv_channel = histeq(v_channel);
    hsv_img(:,:,3) = eqv_channel;
    res_img = hsv2rgb(hsv_img);
end