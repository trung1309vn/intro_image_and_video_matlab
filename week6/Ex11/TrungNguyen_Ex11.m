clear all;
close all;

% 1
yuvdata = load("yuvdata.mat");
w = yuvdata.rows;
h = yuvdata.cols;
fprintf("\nmatrix size %dx%d\n", yuvdata.rows, yuvdata.cols);
fprintf("yy size (%d,%d)\n", size(yuvdata.yy));
fprintf("uu size (%d,%d)\n", size(yuvdata.uu));
fprintf("vv size (%d,%d)\n", size(yuvdata.vv));

% 1a => Matrix size (rows*cols) is not matched with size of vector
% uu and vv, but matched with yy size. Y keeps pixel's brightness, U is for
% blue color difference, V is for red color difference. The reason for 
% this difference is the compression type YUV image is usually stored with 
% types 4:2:2 or 4:2:0. These type can be explain as followed. "4" is for
% block size, "2" is number of pixels in one block that keep all Y, U, V 
% value the others only keep Y information and will get U, V info from the
% pixel that keep it. The next "2" or "0" are for indicating if the next
% block keep 2 pixel with Y, U, V info or none of them have U, V info.
% For our case, Y channel has 4 times number of pixels than U and V. So the
% compression here is 4:2:0

% 1b
figure
Y = reshape(yuvdata.yy, h, w);
U = imresize(reshape(yuvdata.uu, h/2, w/2),[h w],'nearest');
V = imresize(reshape(yuvdata.vv, h/2, w/2),[h w],'nearest');
subplot(1,3,1)
imshow(Y,[])
title("Y channel")
subplot(1,3,2)
imshow(U,[])
title("U channel")
subplot(1,3,3)
imshow(V,[])
title("V channel")

% 1c
U = U - 127;
V = V - 127;

% 1d
YUV=cat(2,Y(:),U(:),V(:));

% 1e
Yuv2Rgb = [1 0 1.402; 1 -0.34413 -0.71414; 1 1.772 0;]
RGB=Yuv2Rgb*YUV';

% 1f
figure
R=reshape(RGB(1,:), h, w);
G=reshape(RGB(2,:), h, w);
B=reshape(RGB(3,:), h, w);
RGB = zeros(h,w,3,"uint8");
RGB(:,:,1) = uint8(R);
RGB(:,:,2) = uint8(G);
RGB(:,:,3) = uint8(B);
imshow(RGB,[]);

% 2a
figure
lena = imread("lena.tiff");
[h, w, c] = size(lena);
YCbCr = rgb2ycbcr(lena);
subplot(1,3,1)
imshow(YCbCr(:,:,1),[])
title("Y channel")
subplot(1,3,2)
imshow(YCbCr(:,:,2),[])
title("Cb channel")
subplot(1,3,3)
imshow(YCbCr(:,:,3),[])
title("Cr channel")

% 2b

close all;

% 422 Cb Cr
Cb_422 = YCbCr(:,:,2);
Cb_422 = Cb_422(1:2:end,:);
Cr_422 = YCbCr(:,:,3);
Cr_422 = Cr_422(1:2:end,:);
% 411 Cb Cr
Cb_411 = YCbCr(:,:,2);
Cb_411 = Cb_411(1:4:end,:);
Cr_411 = YCbCr(:,:,3);
Cr_411 = Cr_411(1:4:end,:);
% 420 Cb Cr
Cb_420 = YCbCr(:,:,2);
Cb_420 = Cb_420(1:2:end,1:2:end);
Cr_420 = YCbCr(:,:,3);
Cr_420 = Cr_420(1:2:end,1:2:end);
% 411 Y
Y_411 = YCbCr(:,:,1);
Y_411 = Y_411(1:4:end,:);

% 2c
figure
subplot(2,3,1)
imshow(lena,[]);
title("org img")
% 422 Cb Cr
YCbCr_422 = zeros([h,w,3], "uint8");
YCbCr_422(:,:,1) = YCbCr(:,:,1);
YCbCr_422(:,:,2) = imresize(Cb_422,[h,w],'nearest');
YCbCr_422(:,:,3) = imresize(Cr_422,[h,w],'nearest');
lena_422 = ycbcr2rgb(YCbCr_422);
subplot(2,3,4)
imshow(lena_422,[])
err = immse(lena, lena_422);
title(strcat("Color 422 - ",num2str(err)))
% 411 Cb Cr
YCbCr_411 = zeros([h,w,3], "uint8");
YCbCr_411(:,:,1) = YCbCr(:,:,1);
YCbCr_411(:,:,2) = imresize(Cb_411,[h,w],'nearest');
YCbCr_411(:,:,3) = imresize(Cr_411,[h,w],'nearest');
lena_411 = ycbcr2rgb(YCbCr_411);
subplot(2,3,5)
imshow(lena_411,[])
err = immse(lena, lena_411);
title(strcat("Color 411 - ",num2str(err)))
% 420 Cb Cr
YCbCr_420 = zeros([h,w,3], "uint8");
YCbCr_420(:,:,1) = YCbCr(:,:,1);
YCbCr_420(:,:,2) = imresize(Cb_420,[h,w],'nearest');
YCbCr_420(:,:,3) = imresize(Cr_420,[h,w],'nearest');
lena_420 = ycbcr2rgb(YCbCr_420);
subplot(2,3,6)
imshow(lena_420,[])
err = immse(lena, lena_420);
title(strcat("Color 420 - ",num2str(err)))
% 411 Y
YCbCr_411 = zeros([h,w,3], "uint8");
YCbCr_411(:,:,1) = imresize(Y_411(:,:,1),[h,w],'nearest');
YCbCr_411(:,:,2) = YCbCr(:,:,2);
YCbCr_411(:,:,3) = YCbCr(:,:,3);
lena_411 = ycbcr2rgb(YCbCr_411);
subplot(2,3,2)
imshow(lena_411,[])
err = immse(lena, lena_411);
title(strcat("Brightness 411 - ",num2str(err)))



















