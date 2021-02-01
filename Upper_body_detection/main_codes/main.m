clc
clear
close all

% Warning: make sure VL_FEAT is installed
% For installation http://www.vlfeat.org/install-matlab.html
run('/home/nobug-ros/Documents/vlfeat/toolbox/vl_setup');

% Add path to supporting codes
addpath('../supporting_codes/');

% Warning
num = 181; % first 181 are positive examples
C = 7;
tol = 1e-2;

% Run HW2_Utils.m to access all member functions
HW2_Utils;

% Load positive and Negative data
[trD, trLb, valD, valLb, trRegs, valRegs] = HW2_Utils.getPosAndRandomNeg();

PosD = trD(:, 1:num);
Posy = trLb(1:num, 1);
NegD = trD(:, num+1:end);
Negy = trLb(num+1:end, 1);

X = [PosD NegD];
y = trLb;

% Train SVM with PosD and NegD
[w, b, alpha] = svm_quadprog_dual([PosD NegD], [Posy; Negy], C);

% Start of hard-Negetive Mining for better traing of SVM model (iterative learning)
for itr = 1:2
    Aidx = [];
    k = 1;
    
    % Construct A
    for nuz = 1:size(NegD, 2)
        if alpha(size(PosD, 2)+nuz, 1) < tol
            Aidx(1, k) = nuz;
            k = k + 1;
        end
    end
    NegD(:, Aidx(1, :)) = []; 
    
    % Construct Temp NegD
    [nD, nlb, imRegs] = HW2_Utils.getNegex(w, b, 'train');
    nD = double(nD);

    % Union of old and new
    NegD = [NegD nD];
    Negy = -1*ones(size(NegD, 2), 1);
    
    % Train SVM with PosD and NegD
    [w, b, alpha] = svm_quadprog_dual([PosD NegD], [Posy; Negy], C);
end

% Use trained model on validation data
Xv = valD;
yv = valLb;
predict = sign((w'*Xv)' + b);

correct = 0;
for i = 1:length(predict)
    if yv(i, 1) == predict(i, 1)
        correct = correct + 1;
    end
end

fprintf('Accuracy: %2.6f\n', correct/length(predict));

im_raw = sprintf('%s/valIms/%04d.jpg', HW2_Utils.dataDir, 22);
im = imread(im_raw);
HW2_Utils.detect(im, w, b, 1);
