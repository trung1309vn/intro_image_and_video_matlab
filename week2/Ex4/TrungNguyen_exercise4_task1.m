clear all;
close all;
im_dir = "/home/trung/Project/Study/1st_year/2nd_sem/Intro_Image_and_Video/intro_image_and_video_matlab/week2/Ex4/";
img = imread(strcat(im_dir, "university.png"));
figure
imshow(img);
title("org image");

figure
res_im = log_enhanced_img(50, img);
imshow(res_im);

figure
res_im = power_enhanced_img(2, 1.35, img);
imshow(res_im);

function res_im = log_enhanced_img(c, img)
    double_im = c*log(double(img)+1);
    res_im = uint8(double_im);
end

function res_im = power_enhanced_img(c, gamma, img)
    double_im = c*power(double(img), gamma);
    res_im = uint8(double_im);
end

% Regardless the constant value c, we have the term log(1+r) and r^gamma. The log term increase slower than power term.
% Furthermore, the log term decrease the difference between the small and large pixel value, hence, vlaue from [0,255] can be
% adjust more equally.
% For the power term, the larger value increase more quickly, so sometimes the large value can be white out while the smaller
% are still dark
