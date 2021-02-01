clc
clear
close all

% Time variables
t0 = 0; tf = 10; dt = 0.001;
tm = t0:dt:tf;
nt = size(tm, 2);

% Initialize states
q = zeros(2,nt);
dq = zeros(2,nt);
tau = zeros(1, nt);

% Set initial conditions
q(:, 1) = [0; 0.25];

% Initialize Observer States
hq = zeros(2,nt);
hdq = zeros(2,nt);

% Set Initial Observer States
hq(:, 1) = [0.5; 0.5];

% System Matrices
Amat = [0 1; 0 0];
Bmat = [0; 1];
Cmat = [1; 0];
Kmat = [600; 5000];
Ac = Amat - Kmat*Cmat';

% Initialize DRNN Weight Matrices
% Wf = randn(2, 1);
% Wg = randn(2, 1);
Wf = zeros(2, 1);
Wg = zeros(2, 1);

Ff = diag([5e2 5e2]); Fg = diag([5e2 5e2]);
kf = 0.001; kg = 0.001;
eta = 0.1; rho1 = 1.5; rho2 = 1.5;
sc_f = 0; sc_g = 0;

% Define Activation Function (Sigmoid)
%sig_fun = @(x_vec)((1./(1 + exp(-x_vec))));

% State estimation loop`
for i = 1:nt-1
    
    %==============
    % System Model
    %==============
    %tau(i) = sin(2*tm(i));
    tau(i) = sin(2*tm(i)) + cos(2*tm(i));
    dq(:, i) = Amat*q(:, i) + Bmat*((1 - q(1, i)^2)*q(2, i) - q(1, i) + (1 + q(1, i)^2 + q(2, i)^2)*tau(i));
    q(:, i+1) = q(:, i) + dt*dq(:, i);
    
    %===============
    % DRNN Observer
    %===============
    y_tild = Cmat'*q(:, i) - Cmat'*hq(:, i);
    fprintf('y_tild: \n'); disp(y_tild);
    
    vf = -sc_f*y_tild/norm(y_tild);          % robustifying term for f
    vg = -sc_g*y_tild/norm(y_tild);          % robustifying term for g
    
%     hdq(:, i) = Amat*hq(:, i) + Bmat*(Wf'*sig_fun(hq(:, i)) ...
%                 + Wg'*sig_fun(hq(:, i))*tau(i) - vf - vg) ...
%                 + Kmat*(Cmat'*q(:, i) - Cmat'*hq(:, i));
    
%     sig_fun(hq(:, i))
    
    hdq(:, i) = Amat*hq(:, i) + Bmat*(Wf'*sig_fun(hq(:, i)) ...
                + Wg'*sig_fun(hq(:, i))*tau(i)) ...
                + Kmat*(Cmat'*q(:, i) - Cmat'*hq(:, i));
    hq(:, i+1) = hq(:, i) + dt*hdq(:, i);
    
    %====================
    % Update the weights
    %====================
    Wf = Wf + dt*(Ff*sig_fun(hq(:, i))*y_tild - kf*Ff*norm(y_tild)*Wf);
    Wg = Wg + dt*(Fg*sig_fun(hq(:, i))*y_tild*tau(i) - kg*Fg*norm(y_tild)*Wg);
    
end 

figure(1)
plot(tm, hq(1, :))
title('Trajectory of State $$x_1$$, $$\hat{x}_1$$', 'Interpreter', 'Latex')
xlabel('time s', 'Interpreter', 'Latex')
ylabel('$$x_1$$, $$\hat{x}_1$$', 'Interpreter', 'Latex')
grid minor

% Plot states/torques
figure(1)
plot(tm, q(1, :), tm(1, 1:100:end), hq(1, 1:100:end), '+')
title('Trajectory of State $$x_1$$, $$\hat{x}_1$$', 'Interpreter', 'Latex')
xlabel('time s', 'Interpreter', 'Latex')
ylabel('$$x_1$$, $$\hat{x}_1$$', 'Interpreter', 'Latex')
legend('actual', 'obs est')
grid minor

figure(2)
plot(tm, q(2, :), tm(1, 1:100:end), hq(2, 1:100:end), '+')
title('Trajectory of State $$x_2$$, $$\hat{x}_2$$', 'Interpreter', 'Latex')
xlabel('time s', 'Interpreter', 'Latex')
ylabel('$$x_2$$, $$\hat{x}_2$$', 'Interpreter', 'Latex')
legend('actual', 'obs est')
grid minor
ylim([-5 10])

figure(3)
plot(tm, tau)
title('torques', 'Interpreter', 'Latex')
xlabel('time s', 'Interpreter', 'Latex')
ylabel('$$\tau_1$$ Nm', 'Interpreter', 'Latex')
grid minor