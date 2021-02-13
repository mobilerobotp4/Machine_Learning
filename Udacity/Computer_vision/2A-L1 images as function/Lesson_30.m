%Generate Gaussian noise
%if there is no parameter in randn it returns a random number
some_number = randn();
disp(some_number); %-1.3132

%if we want to generate a row vector with five columns

some_number = randn([1 5]); 
disp(some_number); % -1.1665   1.2429  -0.3014  -2.0986  -0.6651

%Generate a two dimensional matrix with 2 rows and 3 columns
%the noise is in Gaussian normal distribution

noise = randn([2 3]); 
disp(noise);

%0.3349   0.4986  -0.6155
%0.2625   0.9691   0.6109

%create a histrogram to find out randn is a Gaussian distribution
noise = randn([1 100]);
[n, x] = hist(noise,[-3 -2 -1 0 1 2 3]);
disp([x; n]);
 %-3   -2   -1    0    1    2    3
  %1    4   22   39   24    8    2
 plot(x,n);
 
%To create a reliable plot we need to increase the bin space

noise = randn([1 10000]);
[n, x] = hist(noise,linspace(-3,3,21));
plot(x,n);

noise = randni([2 1000]);
[n x] = hist(noise, linspace(-3, 3, 21));
%disp([x; n]);
plot(x, n);




 