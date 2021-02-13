%Find out the image value at specific location
%At a given location (row, col)
im =  imread('Dolphin.jpg');
disp(size(im))
%Convert RGB image into grayscale
grey_con = rgb2gray(im);
imshow(grey_con);
%display the size og the image
disp(size(grey_con))
disp(grey_con(50,100)); %130

%return values for all columns
%From an entire row

disp(grey_con(50, :));

plot(im(50, :));
