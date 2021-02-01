clc
clear
close all

% System Matrices
Amat = [0 1; 0 0];
Bmat = [0; 1];
Cmat = [1; 0];
% Kmat = [40; 5e3];
Kmat = [400; 800];

% Initialize DRNN Weight Matrices
Wf = randn(2, 1);
Wg = randn(2, 1);
% Wf = zeros(2, 1);
Vf = ones(2, 2);
% Wg = zeros(2, 1);
Vg = ones(2, 2);

Ff = diag([5e4 5e4]); Fg = diag([5e3 5e3]);
kf = 0.001; kg = 0.001;

%=======================
% Training loop
%=======================
for idata = 1:2
    
    % Load datafile in to the workspace
    % data = load(strcat('Lewis_noisedata', num2str(idata), '.txt'));
    data = load(strcat('Lewis_data', num2str(idata), '.txt'));
    
    % Extract the data and labels
    tm = data(:, 1)';
    tau = data(:, 2)';
    q = data(:, 3:4)';
    dq = data(:, 5:6)';
    
    nt = length(tm);
    dt = tm(2) - tm(1);
    
    % Initialize Observer States
    hq = zeros(2,nt);
    hdq = zeros(2,nt);

    % Set Initial Observer States
    hq(:, 1) = q(:, 1);
    
    for i = 1:nt-1
    
        %===============
        % DRNN Observer
        %===============
        y_tild = Cmat'*q(:, i) - Cmat'*hq(:, i);    
        hdq(:, i+1) = Amat*hq(:, i) + Bmat*(Wf'*sig_fun(hq(:, i)) ...
                    + Wg'*sig_fun(hq(:, i))*tau(i)) ...
                    + Kmat*(Cmat'*q(:, i) - Cmat'*hq(:, i));
        hq(:, i+1) = hq(:, i) + dt*hdq(:, i);
    
        %====================
        % Update the weights
        %====================
        Wf = Wf + dt*(Ff*sig_fun(hq(:, i))*y_tild - kf*Ff*norm(y_tild)*Wf);
        Wg = Wg + dt*(Fg*sig_fun(hq(:, i))*y_tild*tau(i) - kg*Fg*norm(y_tild)*Wg);
    
    end
    
end

fprintf('Training complete\n');

%=======================
% Validation loop
%=======================
for vdata = 1:1
    % Load datafile in to the workspace
    data = load(strcat('Lewis_valid_data', num2str(vdata), '.txt'));
        
    % Extract the data and labels
    tm = data(:, 1)';
    tau = data(:, 2)';
    q = data(:, 3:4)';
    dq = data(:, 5:6)';
    
    nt = length(tm);
    dt = tm(2) - tm(1);
    
    % Initialize Observer States
    hq = zeros(2,nt);
    hdq = zeros(2,nt);

    % Set Initial Observer States
    hq(:, 1) = q(:, 1);
    
    for i = 1:nt-1
    
        %===============
        % DRNN Observer
        %===============
        y_tild = Cmat'*q(:, i) - Cmat'*hq(:, i);
    
        hdq(:, i+1) = Amat*hq(:, i) + Bmat*(Wf'*sig_fun(hq(:, i)) ...
                    + Wg'*sig_fun(hq(:, i))*tau(i)) ...
                    + Kmat*(Cmat'*q(:, i) - Cmat'*hq(:, i));
        hq(:, i+1) = hq(:, i) + dt*hdq(:, i);
        
        %==============================
        % No weight updation performed
        %==============================
    end
end

fprintf('Validation complete\n');

% Plot states/torques
figure(1)
plot(tm, q(1, :), tm(1, 1:100:end), hq(1, 1:100:end), '+')
%plot(tm, q(1, :), tm(1, :), hq(1, :))
title('Trajectory of State $$x_1$$, $$\hat{x}_1$$', 'Interpreter', 'Latex')
xlabel('time s', 'Interpreter', 'Latex')
ylabel('$$x_1$$, $$\hat{x}_1$$', 'Interpreter', 'Latex')
grid minor

figure(2)
plot(tm, q(2, :), tm(1, 1:100:end), hq(2, 1:100:end), '+')
%plot(tm, q(2, :), tm(1, :), hq(2, :))
% plot(tm, q(2, :), tm(1, 1:100:end), hdq(1, 1:100:end), '+')
title('Trajectory of State $$x_2$$, $$\hat{x}_2$$', 'Interpreter', 'Latex')
xlabel('time s', 'Interpreter', 'Latex')
ylabel('$$x_2$$, $$\hat{x}_2$$', 'Interpreter', 'Latex')
grid minor

figure(3)
plot(tm, tau)
title('torques', 'Interpreter', 'Latex')
xlabel('time s', 'Interpreter', 'Latex')
ylabel('$$\tau_1$$ Nm', 'Interpreter', 'Latex')
grid minor