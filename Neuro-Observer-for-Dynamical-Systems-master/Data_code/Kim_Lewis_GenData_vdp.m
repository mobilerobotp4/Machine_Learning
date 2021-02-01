clc
clear
close all

% Dynamics parameters
m = 1; l = 1; M = 0.5; g = 9.81;

% Time variables
t0 = 0; tf = 10; dt = 0.001;
tm = t0:dt:tf;
nt = size(tm, 2);

% Initialize states
q = zeros(2,nt);
dq = zeros(2,nt);
ddq = zeros(2,nt);
tau = zeros(1, nt);

% Set initial conditions
q(:, 1) = [0; 0];

% System Matrices
Amat = [0 1; 0 0];
Bmat = [0; 1];
Cmat = [1; 0];

% State estimation loop`
for i = 1:nt-1
    
    %==============
    % System Model
    %==============
    %tau(i) = sin(2*tm(i)) + cos(20*tm(i));       % validation
    tau(i) = sin(4*tm(i)) + cos(10*tm(i));                        % data2
    %tau(i) = sin(4*tm(i)) + cos(4*tm(i));        % data1
    dq(:, i) = Amat*q(:, i) + Bmat*((1 - q(1, i)^2)*q(2, i) - q(1, i) + (1 + q(1, i)^2 + q(2, i)^2)*tau(i));
    q(:, i+1) = q(:, i) + dt*dq(:, i);
    
end

% Noise generating function
a = -0.1; b = 0.1; 
gn = @(sz)(a + (b-a).*rand(sz));

% Write data in a text file
fileID = fopen('Lewisvdp_data2.txt','w');
%fileID = fopen('Lewis_valid_data1.txt','w');
A = [tm; tau; q; dq];
A_noise = [tm; tau+gn(size(tau)); q(1, :)+gn([1, size(q, 2)]);...
            q(2, :)+gn([1, size(q, 2)]); dq(1, :)+gn([1, size(dq, 2)]);...
            dq(2, :)+gn([1, size(dq, 2)])];

fprintf(fileID,'%6.6f %6.6f %6.6f %6.6f %6.6f %6.6f\r\n',A);
%uncomment this for noisy data
%fprintf(fileID,'%6.6f %6.6f %6.6f %6.6f %6.6f %6.6f\r\n',A_noise);
fclose(fileID);

% Plot states/torques
figure(1)
plot(tm, q)
title('Trajectory of State $$x_1$$, $$\hat{x}_1$$', 'Interpreter', 'Latex')
xlabel('time s', 'Interpreter', 'Latex')
ylabel('$$x_1$$, $$\hat{x}_1$$', 'Interpreter', 'Latex')
grid minor

figure(2)
plot(tm, tau)
title('torques', 'Interpreter', 'Latex')
xlabel('time s', 'Interpreter', 'Latex')
ylabel('$$\tau_1$$ Nm', 'Interpreter', 'Latex')
grid minor