close all;
clear all;
%imdir = "C:\Users\vgtrng\Downloads\intro_image_and_video_matlab-master\intro_image_and_video_matlab-master\week4\Ex8\";
imdir= "";
img = im2double(imread(strcat(imdir,"DIP.jpg")));
[h, w] = size(img);

% 1
figure
subplot(1,3,1)
imshow(img);
title("org img");

% 1a - motion blur filter
[u, v] = meshgrid(-h/2:h/2-1, -w/2:w/2-1);
a = 0.1;
b = 0.1;
T = 1;
offset = 0.001;
TMP = pi*(u*a+v*b);
H = (T./(TMP+offset)) .* (sin(TMP)) .* (exp(-1*j*TMP));
inv_H = TMP ./ T ./(sin(TMP+offset)) ./ (exp(-1*j*TMP));

% 1b - apply motion blur
fft_img = fftshift(fft2(img));    % FFT on image
mb_img = real(ifft2(ifftshift(H.*fft_img))); % Filtered image
subplot(1,3,2)
imshow(mb_img,[]);
title("motion blur img");

% 1c - inverse filtering
fft_img = fftshift(fft2(mb_img));
res_img = real(ifft2(ifftshift(inv_H.*fft_img)));
subplot(1,3,3)
imshow(res_img,[]);
title("restored img");

% 1d - mean square error
err_mb = immse(img, mb_img)
% print(err_mb);
err_res = immse(img, res_img)
% print(err_res);

% 2a - add noise
figure
subplot(2,3,1)
noise = (sqrt(50)*randn(h,w))/255.0;
noise_mb_img = imadd(mb_img, noise);
imshow(noise_mb_img,[]);
title("noise mb image");

% 2b
subplot(2,3,2)
fft_img = fftshift(fft2(noise_mb_img));
inv_res_img = real(ifft2(ifftshift(inv_H.*fft_img)));
imshow(inv_res_img,[]);
title("inv restored img");

% 2c
NSRs = [0.005, 0.05, 0.1];
%NSR = 0.01;
NSR = mean(power(abs(fft(noise)),2)) / mean(power(abs(fft(mb_img)),2))

subplot(2,3,3)
fft_img = fftshift(fft2(noise_mb_img));

factor = abs(H).^2 ./ (abs(H).^2 + NSR);
denoise_img = inv_H .* factor .* fft_img;
res_img = real(ifft2(ifftshift(denoise_img)));
imshow(res_img,[]);
err = immse(img, res_img);
title("restored img " + num2str(NSR) + " => " + num2str(err));

subplot(2,3,4)
fft_img = fftshift(fft2(noise_mb_img));
factor = abs(H).^2 ./ (abs(H).^2 + NSRs(1));
denoise_img = inv_H .* factor .* fft_img;
res_img = real(ifft2(ifftshift(denoise_img)));
imshow(res_img,[]);
err = immse(img, res_img);
title("restored img " + num2str(NSRs(1)) + " => " + num2str(err));

subplot(2,3,5)
fft_img = fftshift(fft2(noise_mb_img));
factor = abs(H).^2 ./ (abs(H).^2 + NSRs(2));
denoise_img = inv_H .* factor .* fft_img;
res_img = real(ifft2(ifftshift(denoise_img)));
imshow(res_img,[]);
err = immse(img, res_img);
title("restored img " + num2str(NSRs(2)) + " => " + num2str(err));

subplot(2,3,6)
fft_img = fftshift(fft2(noise_mb_img));
factor = abs(H).^2 ./ (abs(H).^2 + NSRs(3));
denoise_img = inv_H .* factor .* fft_img;
res_img = real(ifft2(ifftshift(denoise_img)));
imshow(res_img,[]);
err = immse(img, res_img);
title("restored img " + num2str(NSRs(3)) + " => " + num2str(err));


