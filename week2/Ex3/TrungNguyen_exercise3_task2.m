close all;
clear all;
imdir = "/home/trung/Project/Study/1st_year/2nd_sem/Intro_Image_and_Video/intro_image_and_video_matlab/week2/Ex3/";
img = imread(strcat(imdir,"mbaboon.bmp"));
figure
imshow(img, "InitialMagnification", "fit");
title("org image");

% Create block processing function
% resize with 4 times smaller
%a
func_a = @(block_struct) ...
    imresize(block_struct.data(2,2) * uint8(ones(size(block_struct.data))),0.25);
Ia = blockproc(img, [4 4], func_a);
figure
imshow(Ia, "InitialMagnification", "fit");
title("down sampled image a");

%b
func_b = @(block_struct) ...
    imresize(block_struct.data(1,1) * uint8(ones(size(block_struct.data))),0.25);
Ib = blockproc(img, [4 4], func_b);
figure
imshow(Ib, "InitialMagnification", "fit");
title("down sampled image b");

%c
func_c = @(block_struct) ...
    imresize(mean(block_struct.data, "all") * uint8(ones(size(block_struct.data))),0.25);
Ic = blockproc(img, [4 4], func_c);
figure
imshow(Ic, "InitialMagnification", "fit");
title("down sampled image c");
