%Apply Gaussian noise to an image
img = imread('Fruit.jpg');
imshow(img);

noise= randn(size(img)) .*25;
output = img+noise;
imshow(output);