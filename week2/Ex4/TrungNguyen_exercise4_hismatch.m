clear all;
close all;
im_dir = "/home/trung/Project/Study/1st_year/2nd_sem/Intro_Image_and_Video/intro_image_and_video_matlab/week2/Ex4/";
ref_img = imread(strcat(im_dir, "corel.png"));
img1 = imread(strcat(im_dir, "spine.jpg"));
img2 = imread(strcat(im_dir, "church.png"));

img_hist_match(ref_img, img1);
img_hist_match(ref_img, img2);

function img_hist_match(ref_img, img)
    figure
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
    nexttile
    bar(ref_cdf);
    title("ref cdf");
    
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
    nexttile
    bar(img_cdf);
    title("img cdf");

    % new image
    figure
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
    figure
    img_hist = zeros(1, 256);
    for value = (1:256)
        img_hist(value) = sum(matching_img == value-1, "all");
    end
    [h,w] = size(matching_img);
    new_img_pdf = im2double(img_hist) / (h*w);
    nexttile
    bar(new_img_pdf);
    title("new image histogram");
    new_img_cdf = double(zeros(1, 256));
    curr_sum = 0.0;
    for value = (1:256)
        curr_sum = curr_sum + new_img_pdf(value);
        new_img_cdf(value) = curr_sum;
    end
    nexttile
    bar(new_img_cdf);
    title("new img cdf");
    
end