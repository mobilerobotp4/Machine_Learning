%Remove noise with Gaussian Filter
%Load an image

img = imread('Fruit.jpg');
imshow(img);

%Add some noise

noise_sigma = 25;
noise = randn(size(img)) .* noise_sigma;
noisy_img = img + noise;
imshow(noisy_img);

%create gaussian filter

filter_size = 11
filter_sigma = 2;
pkg load image;
filter = fspecial('gaussian', filter_size, filter_sigma);

%Apply it to remove noise

smoothed = imfilter(noisy_img, filter);
imshow(smoothed);

