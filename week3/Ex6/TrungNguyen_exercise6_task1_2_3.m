h = 128;
w = 128;

% 1a
img_1a = 0.5 * ones(h,w);

% 1b
img_1b = zeros(h,w);
img_1b(h/2-10:h/2+9,w/2-10:w/2+9) = 1.0;

% 1c
img_1c = repmat([0.0:1.0/w:1.0-1.0/w], h, 1);

% 1d
img_1d = repmat([zeros(1,w/2),ones(1,w/2)], h, 1);

% 1e
n = 1:w;
x = (1 + cos(2*pi*1/32*n))/2;
y = (1 + cos(2*pi*1/32*n))/2;
[X, Y] = meshgrid(x, y);
img_1e = sqrt(X.^2 + Y.^2);

f_list = {img_1a, img_1b, img_1c, img_1d, img_1e};

% High energy concentrate where there is difference between pixels intensity
% Higher difference mean higher frequency 

% 2
for i = 1:5
    subplot(5,2,(i-1)*2+1)
    imshow(f_list{i});
    title("filter");

    subplot(5,2,(i-1)*2+2)
    fft_im = fft2(f_list{i});
    fftc_im = fftshift(fft_im);
    imshow(log(abs(fftc_im) + 0.0001));
    title("fft");
end

% 3
figure
img = imread("/home/trung/Project/Study/1st_year/2nd_sem/Intro_Image_and_Video/intro_image_and_video_matlab/week3/Ex6/cameraman.tif");
img = double(img) / 255.0;
imshow(img);
title("org image");

figure
fft_img = fftshift(fft2(img));

low_butter = BWLPfilter(img, 20, 2);
subplot(2,2,1)
imshow(low_butter);
title("low pass filter");
low_filter_img = real(ifft2(ifftshift(low_butter.*fft_img)));
subplot(2,2,3)
imshow(low_filter_img);
title("low pass image");

high_butter = 1.0 - low_butter;
subplot(2,2,2)
imshow(high_butter);
title("high pass filter");
high_filter_img = real(ifft2(ifftshift(high_butter.*fft_img)));
subplot(2,2,4)
imshow(high_filter_img);
title("high pass image");

function f = BWLPfilter(image, cutoff, n)
    [rows,cols] = size(image);
    [u,v] = meshgrid(1:1:cols,1:1:rows);
    D = sqrt( (u-cols/2).^2 + (v-rows/2).^2 );
    f = 1./(1+((D./cutoff).^(2*n)));
end


