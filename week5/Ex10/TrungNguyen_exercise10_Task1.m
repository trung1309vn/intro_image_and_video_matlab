clear all;
close all;

% 1
img = imread("chameleon.jpg");
cube_res_img = sliceCube(img, 100);
sphere_res_img = sliceSphere(img, 90);
subplot(1,2,1)
imshow(cube_res_img)
subplot(1,2,2)
imshow(sphere_res_img)
figure
img = imread("cheetah.jpg");
cube_res_img = sliceCube(img, 100);
sphere_res_img = sliceSphere(img, 90);
subplot(1,2,1)
imshow(cube_res_img)
subplot(1,2,2)
imshow(sphere_res_img)

% 1 - slice cube
function res_img = sliceCube(img, dist)
    c = impixel(img);
    c = int32(mean(c, 1));
    res_img = img;
    [h,w,ch] = size(img);
    mask = zeros(h,w);
    for i = 1:h
        for j = 1:w
            pixel = int32(img(i, j, :));
            value = (abs(pixel(1)-c(1))+abs(pixel(2)-c(2))+abs(pixel(3)-c(3)));
            mask(i,j) = value <= dist;
        end
    end
    res_img = res_img .* uint8(mask);
end

% 1 - slice sphere
function res_img = sliceSphere(img, dist)
    c = impixel(img);
    c = double(mean(c, 1));
    res_img = img;
    [h,w,ch] = size(img);
    mask = zeros(h,w);
    for i = 1:h
        for j = 1:w
            pixel = double(img(i, j, :));
            value = (pixel(1)-c(1))^2+(pixel(2)-c(2))^2+(pixel(3)-c(3))^2;
            mask(i,j) = value <= dist^2;
        end
    end
    res_img = res_img .* uint8(mask);
end
