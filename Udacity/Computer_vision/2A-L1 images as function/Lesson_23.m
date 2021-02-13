%Add two images
im1 = imread('Dolphin.jpg');
dolphin = rgb2gray(im1);
im2 = imread('bicycle.jpg');
bicycle = rgb2gray(im2);

disp("Dolphin image size:");
disp(size(dolphin));  %404   577

disp("Bicycle image size:");
disp(size(bicycle));% 671   1024

%Two add two images there size must be equal

cropped = bicycle(100:503, 403:979);
disp(size(cropped)); %404   577
imshow(cropped);

%Addition is an element by element operation
% Adding dolphin and cropped image
%They are the matrices of same size hence perform element wise operation

summed = dolphin + cropped;
imshow(summed);

%Scale down the image intensity values

average = dolphin/2 + cropped/2;
imshow(average);

%the following expression not same as the previous ones
average_alt = (dolphin+cropped)/2;
imshow(average_alt);

%{
The two results average and average_alt are different because,
Let's consider two samples values from both images (183, 152).
Now 183/2 + 152/2 = 91.5 + 76 = 167.5
Secondly (183+152)/2 = 335/2 = 167.5
Although arithmetically both values are same we must remember that the class of 
images are uint8. This means that all pixel values are integers in the range 0 
to 255.Since the images are unsigned integers octave tries to retain the same 
type throughout the arithmetic operation. Therefore 183/2 = 92. 92+76 = 168
In the second case the addition of 183+152 gives 335 which does not fit for 
unsigned integer(0-255). Therefore it would be truncted as 255. 255/2 = 127.5 
= 128
So number of places the pixel values add up to more than 255 all this locations
become 128. Therefore 1st opration better preserve pixel values. 


%}

% Multiply by scalar
% makes image darker
result = 0.5 * dolphin;
imshow(dolphin);

% makes image brighter

result_bright = 1.5*dolphin;
imshow(result_bright);

%another way to find out the average of two images
result_alt = 0.5* dolphin + 0.5* cropped;
imshow(result_alt);

%Blending two images
% weighted sum should be one (0.25+0.75) 
blend = 0.75* dolphin + 0.25* cropped; 
imshow(blend);

%Image diferences

diff = bicycle - cropped;
imshow(diff);

%take the absolute value of differences

abs_diff = abs(bicycle - cropped);
imshow(abs_diff);

%Better use of image package
pkg load image
abs_diff2 = imabsdiff(dolphin, cropped);
imshow(abs_diff2);