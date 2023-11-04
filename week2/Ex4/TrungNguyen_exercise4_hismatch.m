clear all;
close all;
im_dir = "/home/trung/Project/Study/1st_year/2nd_sem/Intro_Image_and_Video/intro_image_and_video_matlab/week2/Ex4/";
ref_img = imread(strcat(im_dir, "corel.png"));
img = imread(strcat(im_dir, "spine.jpg"));
img = imread(strcat(im_dir, "church.png"));

% ref histogram
ref_hist = zeros(1, 256);
for value = (1:256)
    ref_hist(value) = sum(ref_img == value-1, "all");
end
[h,w] = size(ref_img);
ref_pdf = im2double(ref_hist) / (h*w);
nexttile
bar(ref_pdf);
title("ref image histogram");
ref_cdf = double(zeros(1, 256));
curr_sum = 0.0;
for value = (1:256)
    curr_sum = curr_sum + ref_pdf(value);
    ref_cdf(value) = curr_sum;
end

% input histogram
img_hist = zeros(1, 256);
for value = (1:256)
    img_hist(value) = sum(img == value-1, "all");
end
[h,w] = size(img);
img_pdf = im2double(img_hist) / (h*w);
nexttile
bar(img_pdf);
title("org image histogram");
img_cdf = double(zeros(1, 256));
curr_sum = 0.0;
for value = (1:256)
    curr_sum = curr_sum + img_pdf(value);
    img_cdf(value) = curr_sum;
end

% new image
matching_img = img;
for value = (1:256)
    tmp_ref_cdf = ref_cdf;
    tmp_ref_cdf = abs(tmp_ref_cdf - img_cdf(value))
    min_distance = min(tmp_ref_cdf, [], "all")
    min_pos = find(tmp_ref_cdf == min_distance, 1)
    matching_img(img==value-1) = min_pos-1;
end
nexttile
imshow(matching_img);
title("new image");

% input histogram
img_hist = zeros(1, 256);
for value = (1:256)
    img_hist(value) = sum(matching_img == value-1, "all");
end
[h,w] = size(matching_img);
img_pdf = im2double(img_hist) / (h*w);
nexttile
bar(img_pdf);
title("new image histogram");

% function res_img = hist_equalize(img)
%     figure
%     % org image
%     nexttile
%     imshow(img);
%     title("org image");
%     [h,w] = size(img)

%     % org histogram
%     img_hist = zeros(1, 256);
%     for value = (1:256)
%         img_hist(value) = sum(img == value-1, "all");
%     end

%     % PDF and CDF
%     norm_img_hist = im2double(img_hist) / (h*w);
%     nexttile
%     bar(norm_img_hist);
%     title("org image histogram");
%     cdf = double(zeros(1, 256));
%     curr_sum = 0.0;
%     for value = (1:256)
%         curr_sum = curr_sum + norm_img_hist(value);
%         cdf(value) = curr_sum;
%     end
%     % bar(cdf);
    
%     % new image
%     res_img = img;
%     min_cdf = min(cdf, [], "all")
%     for value = (0:255)
%         cdf_val = (cdf(value+1)-min_cdf)/(1-min_cdf);
%         new_value = uint8(255 * cdf_val + 0.5)
%         res_img(img == value) = new_value;
%     end
%     nexttile
%     imshow(res_img);
%     title("new image");

%     % new histogram
%     res_img_hist = zeros(1, 256);
%     for value = (1:256)
%         res_img_hist(value) = sum(res_img == value-1, "all");
%     end
%     norm_res_img_hist = im2double(res_img_hist) / (h*w);
%     nexttile
%     bar(norm_res_img_hist);
%     title("new image histogram");
% end