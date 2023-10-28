I = imread("peppers.png");
nexttile
imshow(I);

% a
nexttile
I1 = rgb2gray(I);
imshow(I1);

% b
nexttile
imshow(I(:,:,1));

% c
nexttile
I2 = I;
I2(:,:,2) = I2(:,:,2) + 50;
imshow(I2);

% d
nexttile
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
I3 = cat(3,cat(3,B,G),R);
imshow(I3);

% e
figure
subplot(2,2,1);
imshow(I);
subplot(2,2,2);
imshow(I1);
subplot(2,2,3);
imshow(I2);
subplot(2,2,4);
imshow(I3);


