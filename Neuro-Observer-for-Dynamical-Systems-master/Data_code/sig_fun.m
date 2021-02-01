function [sigvec] = sig_fun(x_vec)
    sigvec = zeros(length(x_vec), 1);
    for i = 1:length(x_vec)
        sigvec(i, 1) = 1/(1 + exp(-x_vec(i, 1)));
    end
end