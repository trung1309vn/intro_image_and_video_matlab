clear all;
close all;
im_dir = "/home/trung/Project/Study/1st_year/2nd_sem/Intro_Image_and_Video/intro_image_and_video_matlab/week3/Ex5/";
img = imread(strcat(im_dir, "cameraman.tif"));
subplot(2,2,1)
imshow(img);
title("org image");
img = double(img);

% Lalapcian
lap1 = [-1 -1 -1; -1  8 -1; -1 -1 -1];
img_lap1 = uint8(conv2(img, lap1, "same"));
subplot(2,2,2)
imshow(img_lap1);
title("lap1 image")

lap2 = [-1 -1 -1; -1  9 -1; -1 -1 -1];
img_lap2 = uint8(conv2(img, lap2, "same"));
subplot(2,2,3)
imshow(img_lap2);
title("lap2 image")

lap3 = [-1 -1 -1; -1  9.7 -1; -1 -1 -1];
img_lap3 = uint8(conv2(img, lap3, "same"));
subplot(2,2,4)
imshow(img_lap3);
title("lap3 image")