clear all;
close all;

% 2 a
figure
rgb_img = imread("lena.tiff");
hsi_img = rgb2hsi(double(rgb_img));

subplot(2,3,1)
imshow(rgb_img(:,:,1),[])
title("R channel img")
subplot(2,3,2)
imshow(rgb_img(:,:,2),[])
title("G channel img")
subplot(2,3,3)
imshow(rgb_img(:,:,3),[])
title("B channel img")
subplot(2,3,4)
imshow(hsi_img(:,:,1),[])
title("H channel img")
subplot(2,3,5)
imshow(hsi_img(:,:,2),[])
title("S channel img")
subplot(2,3,6)
imshow(hsi_img(:,:,3),[])
title("I channel img")

% 2 b
figure
noise_G = imnoise(rgb_img(:,:,2),"gaussian");
noise_G_rgb_img = rgb_img;
noise_G_rgb_img(:,:,2) = noise_G;
noise_hsi_img = rgb2hsi(noise_G_rgb_img);
subplot(1,3,1)
imshow(noise_hsi_img(:,:,1),[])
title("H channel img")
subplot(1,3,2)
imshow(noise_hsi_img(:,:,2),[])
title("S channel img")
subplot(1,3,3)
imshow(noise_hsi_img(:,:,3),[])
title("I channel img")
% Noise changes Green intensity I so it can change the color => H; lower the
% staturation S

% 2 c
figure
noise_RGB = imnoise(rgb_img,"gaussian");
noise_hsi_img = rgb2hsi(noise_RGB);
subplot(1,3,1)
imshow(noise_hsi_img(:,:,1),[])
title("H channel img")
subplot(1,3,2)
imshow(noise_hsi_img(:,:,2),[])
title("S channel img")
subplot(1,3,3)
imshow(noise_hsi_img(:,:,3),[])
title("I channel img")
% More noise to all channel

% 2 d
filter = fspecial('average',[5 5]);
hf_hsi_img = noise_hsi_img;
hf_hsi_img(:,:,1) = imfilter(hf_hsi_img(:,:,1), filter);
sf_hsi_img = noise_hsi_img;
sf_hsi_img(:,:,2) = imfilter(hf_hsi_img(:,:,2), filter);
if_hsi_img = noise_hsi_img;
if_hsi_img(:,:,3) = imfilter(hf_hsi_img(:,:,3), filter);

noise_rgb_img = hsi2rgb(noise_hsi_img);
rf_rgb_img = noise_rgb_img;
rf_rgb_img(:,:,1) = imfilter(rf_rgb_img(:,:,1), filter);
gf_rgb_img = noise_rgb_img;
gf_rgb_img(:,:,2) = imfilter(gf_rgb_img(:,:,2), filter);
bf_rgb_img = noise_rgb_img;
bf_rgb_img(:,:,3) = imfilter(bf_rgb_img(:,:,3), filter);

figure
subplot(2,3,1)
imshow(hsi2rgb(hf_hsi_img))
title("hue filter image")
subplot(2,3,2)
imshow(hsi2rgb(sf_hsi_img))
title("saturation filter image")
subplot(2,3,3)
imshow(hsi2rgb(if_hsi_img))
title("intensity filter image")
subplot(2,3,4)
imshow(rf_rgb_img)
title("red filter image")
subplot(2,3,5)
imshow(gf_rgb_img)
title("green filter image")
subplot(2,3,6)
imshow(bf_rgb_img)
title("blue filter image")

