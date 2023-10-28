clear all;
close all;

% nexttile
im1 = 63 .* ones(400, 400);
im1(120:279,120:279) = 127;
im1 = uint8(im1);
% imshow(im1);

% nexttile
im2 = 223 .* ones(400, 400);
im2(120:279,120:279) = 140;
im2 = uint8(im2);
% imshow(im2);

im = cat(2, im1, im2);
imshow(im)