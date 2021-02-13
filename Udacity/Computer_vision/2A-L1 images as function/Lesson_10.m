%Matlab images are matrices
%Read image from graphics file
im =  imread('Fruit.jpg');
%Display the image
image(im);
%To display the green channel. 
%Matlab starts indexing from 1, so 1 is read 2 is green and 3 is blue
%Matlab is one based indexing
imgreen= im(:,:,2);
imshow(imgreen)
%drawing a red line
line([1,512],[256,256],'color','r')
%Plot give me 256 rows all the column
plot(imgreen(256,:));
