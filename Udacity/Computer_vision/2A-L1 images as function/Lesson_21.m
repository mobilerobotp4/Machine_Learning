%Color planes
img = imread('Fruit.jpg');
imshow(img);

%find out the image size

disp(size(img)); %309   378     3 Height width color_planes or number of channels

%To display an red channel image

img_red= img(:,:,1);
imshow(img_red);

%Size of red color channel image

disp(size(img_red)); %309   378

plot(img_red(150, :));