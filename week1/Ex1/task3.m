clear all;
close all;

im = [[0 0 0 0 0 0 0 1 1 0]
      [1 0 0 1 0 0 1 0 0 1]
      [1 0 0 1 0 1 1 0 0 0]
      [0 0 1 1 1 0 0 0 0 0]
      [0 0 1 1 1 0 0 1 1 1]];

imshow(im);

S1 = im(1:4,2:5);
S2 = im(1:4,6:9);

im_dir = "/home/trung/Project/Study/1st_year/2nd_sem/Intro_Image_and_Video/intro_image_and_video_matlab/week1/Ex1/";
S = load(strcat(im_dir,"S.mat"));

fprintf("%2g\n", count_zeros(S1));
fprintf("%2g\n", count_zeros(S2));
fprintf("%2g\n", count_zeros(S.S));

function non_zero = count_zeros(S)
    non_zero = sum(S, "all");
end
