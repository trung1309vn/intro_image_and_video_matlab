clear all;
close all;
im_dir = "/home/trung/Project/Study/1st_year/2nd_sem/Intro_Image_and_Video/intro_image_and_video_matlab/week2/Ex4/";
img = imread(strcat(im_dir, "moon.png"));
imwrite(im_enhance(img),strcat(im_dir, "new_moon.png"));
ContrastStretch(img, 0, 255);
img = imread(strcat(im_dir, "house.png"));
imwrite(im_enhance(img),strcat(im_dir, "new_house.png"));
ContrastStretch(img, 0, 255);
img = imread(strcat(im_dir, "spine.jpg"));
imwrite(im_enhance(img),strcat(im_dir, "new_spine.png"));
ContrastStretch(img, 0, 255);
img = imread(strcat(im_dir, "church.png"));
imwrite(im_enhance(img),strcat(im_dir, "new_church.png"));
ContrastStretch(img, 0, 255);

% For histogram equalization our final desire is to make the cummulation
% distribution function of the image linearly increase, hence help increase
% the constrat of the image and create more visibility.
% As for constrast stretch, it simply bases on the difference between min
% and max value of the image, so if min and max are already at maximum
% difference (e.g min=0 max=255). The function won't do any enhancement.

function res_img = im_enhance(img)
    figure
    % org image
    nexttile
    imshow(img);
    title("org image");
    [h,w] = size(img)

    % org histogram
    img_hist = zeros(1, 256);
    for value = (1:256)
        img_hist(value) = sum(img == value-1, "all");
    end

    % PDF and CDF
    norm_img_hist = im2double(img_hist) / (h*w);
    nexttile
    bar(norm_img_hist);
    title("org image histogram");
    cdf = double(zeros(1, 256));
    curr_sum = 0.0;
    for value = (1:256)
        curr_sum = curr_sum + norm_img_hist(value);
        cdf(value) = curr_sum;
    end
    % bar(cdf);
    
    % new image
    res_img = img;
    min_cdf = min(cdf, [], "all")
    for value = (0:255)
        cdf_val = (cdf(value+1)-min_cdf)/(1-min_cdf);
        new_value = uint8(255 * cdf_val + 0.5)
        res_img(img == value) = new_value;
    end
    nexttile
    imshow(res_img);
    title("new image");

    % new histogram
    res_img_hist = zeros(1, 256);
    for value = (1:256)
        res_img_hist(value) = sum(res_img == value-1, "all");
    end
    norm_res_img_hist = im2double(res_img_hist) / (h*w);
    nexttile
    bar(norm_res_img_hist);
    title("new image histogram");
end

function ContrastStretch(im, lo, hi)
    im = double(im);
    immax = max(max(im));
    immin = min(min(im));
    im1 = (im - immin)*(hi-lo)/(immax-immin)+lo;
    
    figure;
    subplot(221), imshow(uint8(im)), title('Original Image');
    subplot(222), imhist(uint8(im), gray(256)), title('Histogram');
    subplot(223), imshow(uint8(im1)), title('Cont. Stretched Image');
    subplot(224), imhist(uint8(im1), gray(256)), title('Histogram');
end