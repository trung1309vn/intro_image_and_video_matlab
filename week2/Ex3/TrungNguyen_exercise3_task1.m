imdir = "/home/trung/Project/Study/1st_year/2nd_sem/Intro_Image_and_Video/intro_image_and_video_matlab/week2/Ex3/";
img_wom = imread(strcat(imdir,"wom1.PNG"));
img_man = imread(strcat(imdir,"man8.PNG"));

ContrastStretch(img_wom);
ContrastStretch(img_man);

%a&b
function res_img = ContrastStretch(img)
    figure
    nexttile
    imshow(img);
    title("org image");

    nexttile
    im_hist = zeros(1, 256);
    for value = (1:256)
        im_hist(value) = sum(img == value-1, "all");
    end
    bar(im_hist);
    title("org image histogram");

    nexttile
    double_img = im2double(img);
    min_intensity = min(double_img, [], "all");
    max_intensity = max(double_img, [], "all");
    scale = 255.0 * (double_img - min_intensity) / (max_intensity - min_intensity)
    res_img = uint8(scale);
    imshow(res_img);
    title("contrast stretching");

    nexttile
    stretch_im_hist = zeros(1, 256);
    for value = (1:256)
        stretch_im_hist(value) = sum(res_img == value-1, "all");
    end
    bar(stretch_im_hist);
    title("contrast stretching histogram");
end

