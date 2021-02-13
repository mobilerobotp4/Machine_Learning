im1 = imread('Dolphin.jpg');
dolphin = rgb2gray(im1);
imshow(scale(dolphin,1.5));
im2 = imread('bicycle.jpg');
bicycle = rgb2gray(im2);
cropped = bicycle(100:503, 403:979);
result = blend(dolphin, cropped, 0.75);
imshow(result);