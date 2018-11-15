%Supervised learning problem
clc
clear
close all
% load data from file reside at d:/andrew ng
x = load('ex2x.dat');
y = load('ex2y.dat');
% figure % open a new figure window
% plot(x, y, '*');
% ylabel('Height in meters')
% xlabel('Age in years')
m = length(y); % store the number of training examples
x = [ones(m, 1), x]; % Add a column of ones to x
theta = [0 0];
temp=0,temp2=0;
h=[];
alpha=0.07;n=2; %alpha=learning rate
for i=1:m
    temp1=0;
    for j=1:n
        %h=theta(j)*x(i,j);
        temp1=temp1+theta(j)*x(i,j);
    end
    temp=temp+(temp1-y(i));
   temp2=temp2+((temp1-y(i))*(x(i,2)));
  % temp2=temp2+(((temp1-y(i))*x(i,1))+((temp1-y(i))*x(i,2)));
end
theta(1)=theta(1)-(alpha*(1/m)*temp);
theta(2)=theta(2)-(alpha*(1/m)*temp2);


